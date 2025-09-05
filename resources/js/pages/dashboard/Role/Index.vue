<script setup lang="ts">
import AppLayout from '@/layouts/AppLayout.vue';
import { Pagination, PaginationContent, PaginationItem, PaginationNext, PaginationPrevious } from '@/components/ui/pagination';
import { dashboard } from '@/routes';
import { create, index } from '@/routes/role';
import { type BreadcrumbItem } from '@/types';
import { Head } from '@inertiajs/vue3';
import type { ColumnDef, ColumnFiltersState, ExpandedState, SortingState, VisibilityState } from '@tanstack/vue-table';
import {
    FlexRender,
    getCoreRowModel,
    getExpandedRowModel,
    getFilteredRowModel,
    getPaginationRowModel,
    getSortedRowModel,
    useVueTable,
} from '@tanstack/vue-table';
import { ArrowUpDown, ChevronDown } from 'lucide-vue-next';

import { Button } from '@/components/ui/button';
import { Checkbox } from '@/components/ui/checkbox';
import DropdownAction from '@/components/ui/data-table/DataTableDemoColumn.vue';
import { DropdownMenu, DropdownMenuCheckboxItem, DropdownMenuContent, DropdownMenuTrigger } from '@/components/ui/dropdown-menu';
import { Input } from '@/components/ui/input';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { valueUpdater } from '@/lib/utils';
import { Link, router } from '@inertiajs/vue3';
import { h, ref, watch } from 'vue';

export interface Role {
    id: number;
    name: string;
}

const props = defineProps<{
    roles: {
        data: Role[];
        current_page: number;
        last_page: number;
        per_page: number;
        total: number;
        links: { url: string | null; label: string; active: boolean }[];
    };
}>();

// Les données du tableau avec watcher
const rolesData = ref<Role[]>(props.roles.data);
watch(
    () => props.roles.data,
    (newData) => {
        rolesData.value = newData;
    },
    { immediate: true },
);

const columns: ColumnDef<Role>[] = [
    {
        id: 'select',
        header: ({ table }) =>
            h(Checkbox, {
                modelValue: table.getIsAllPageRowsSelected() || (table.getIsSomePageRowsSelected() && 'indeterminate'),
                'onUpdate:modelValue': (value) => table.toggleAllPageRowsSelected(!!value),
                ariaLabel: 'Select all',
            }),
        cell: ({ row }) =>
            h(Checkbox, {
                modelValue: row.getIsSelected(),
                'onUpdate:modelValue': (value) => row.toggleSelected(!!value),
                ariaLabel: 'Select row',
            }),
        enableSorting: false,
        enableHiding: false,
    },
    {
        accessorKey: 'name',
        header: 'Role',
        cell: ({ row }) => h('div', { class: 'capitalize' }, row.getValue('name')),
    },
    {
        accessorKey: 'permissions',
        header: "Permissions",
        cell: ({ row }) => h('div', { class: 'capitalize' }, row.original.permissions.length),
    },
    {
        id: 'actions',
        enableHiding: false,
        cell: ({ row }) => {
            const role = row.original;
            return h(DropdownAction, {
                id: role.id,
                entityName: 'Role',
                routes: {
                    show: '/role', // /user/{id}
                    edit: '/role', // /user/{id}/edit
                    delete: '/role', // /user/{id}
                    index: '/role', // /user
                },
            });
        },
    },
];

// const getPermissionCount = (role) => {
//     return role.permissions ? role.permissions.length : 0;
// };

const sorting = ref<SortingState>([]);
const columnFilters = ref<ColumnFiltersState>([]);
const columnVisibility = ref<VisibilityState>({});
const rowSelection = ref({});
const expanded = ref<ExpandedState>({});

const table = useVueTable({
    data: rolesData,
    columns,
    getCoreRowModel: getCoreRowModel(),
    getPaginationRowModel: getPaginationRowModel(),
    getSortedRowModel: getSortedRowModel(),
    getFilteredRowModel: getFilteredRowModel(),
    getExpandedRowModel: getExpandedRowModel(),
    onSortingChange: (updaterOrValue) => valueUpdater(updaterOrValue, sorting),
    onColumnFiltersChange: (updaterOrValue) => valueUpdater(updaterOrValue, columnFilters),
    onColumnVisibilityChange: (updaterOrValue) => valueUpdater(updaterOrValue, columnVisibility),
    onRowSelectionChange: (updaterOrValue) => valueUpdater(updaterOrValue, rowSelection),
    onExpandedChange: (updaterOrValue) => valueUpdater(updaterOrValue, expanded),
    state: {
        get sorting() {
            return sorting.value;
        },
        get columnFilters() {
            return columnFilters.value;
        },
        get columnVisibility() {
            return columnVisibility.value;
        },
        get rowSelection() {
            return rowSelection.value;
        },
        get expanded() {
            return expanded.value;
        },
    },
});

const breadcrumbs: BreadcrumbItem[] = [
    {
        title: 'Tableau de bord',
        href: dashboard().url,
    },
    {
        title: 'Role',
        href: index().url,
    },
];

// Pagination côté Vue → utilise les links renvoyés par Laravel
function goToPage(url: string | null) {
    if (url) {
        router.get(
            url,
            {},
            {
                preserveState: true,
                preserveScroll: true,
                replace: true,
            },
        );
    }
}
</script>

<template>
    <Head title="Gestion des Roles" />

    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="flex h-full flex-1 flex-col gap-4 overflow-x-auto rounded-xl p-4">
            <div class="flex items-center justify-between">
                <h1 class="text-2xl font-bold">Gestion des Roles</h1>
                <Link :href="create().url">
                    <Button variant="default"> Nouveau Role </Button>
                </Link>
            </div>
            <div class="flex items-center gap-2 py-4">
                <Input
                    class="max-w-52"
                    placeholder="Filtrer Nom..."
                    :model-value="table.getColumn('name')?.getFilterValue() as string"
                    @update:model-value="table.getColumn('name')?.setFilterValue($event)"
                />
                <!-- <Button @click="randomize"> Randomize </Button> -->
                <DropdownMenu>
                    <DropdownMenuTrigger as-child>
                        <Button variant="outline" class="ml-auto"> Colonnes <ChevronDown class="ml-2 h-4 w-4" /> </Button>
                    </DropdownMenuTrigger>
                    <DropdownMenuContent align="end">
                        <DropdownMenuCheckboxItem
                            v-for="column in table.getAllColumns().filter((column) => column.getCanHide())"
                            :key="column.id"
                            class="capitalize"
                            :model-value="column.getIsVisible()"
                            @update:model-value="
                                (value) => {
                                    column.toggleVisibility(!!value);
                                }
                            "
                        >
                            {{ column.id }}
                        </DropdownMenuCheckboxItem>
                    </DropdownMenuContent>
                </DropdownMenu>
            </div>
            <div class="rounded-md border">
                <Table>
                    <TableHeader>
                        <TableRow v-for="headerGroup in table.getHeaderGroups()" :key="headerGroup.id">
                            <TableHead v-for="header in headerGroup.headers" :key="header.id">
                                <FlexRender v-if="!header.isPlaceholder" :render="header.column.columnDef.header" :props="header.getContext()" />
                            </TableHead>
                        </TableRow>
                    </TableHeader>
                    <TableBody>
                        <template v-if="table.getRowModel().rows?.length">
                            <template v-for="row in table.getRowModel().rows" :key="row.id">
                                <TableRow :data-state="row.getIsSelected() && 'selected'">
                                    <TableCell v-for="cell in row.getVisibleCells()" :key="cell.id">
                                        <FlexRender :render="cell.column.columnDef.cell" :props="cell.getContext()" />
                                    </TableCell>
                                </TableRow>
                                <TableRow v-if="row.getIsExpanded()">
                                    <TableCell :colspan="row.getAllCells().length">
                                        {{ JSON.stringify(row.original) }}
                                    </TableCell>
                                </TableRow>
                            </template>
                        </template>

                        <TableRow v-else>
                            <TableCell :colspan="columns.length" class="h-24 text-center"> Aucun resultat. </TableCell>
                        </TableRow>
                    </TableBody>
                </Table>
            </div>

            <!-- ✅ Pagination avec shadcn-vue -->
            <Pagination v-if="props.roles.links.length > 1">
                <PaginationContent>
                    <!-- Bouton Précédent -->
                    <PaginationPrevious
                        :class="{ 'cursor-not-allowed opacity-50': !props.roles.links[0].url }"
                        :aria-disabled="!props.roles.links[0].url"
                        @click="goToPage(props.roles.links[0].url)"
                    />

                    <!-- Pages -->
                    <template v-for="(link, index) in props.roles.links.slice(1, -1)" :key="index">
                        <PaginationItem :is-active="link.active" @click="goToPage(link.url)">
                            {{ link.label }}
                        </PaginationItem>
                    </template>

                    <!-- Bouton Suivant -->
                    <PaginationNext
                        :class="{ 'cursor-not-allowed opacity-50': !props.roles.links[props.roles.links.length - 1].url }"
                        :aria-disabled="!props.roles.links[props.roles.links.length - 1].url"
                        @click="goToPage(props.roles.links[props.roles.links.length - 1].url)"
                    />
                </PaginationContent>
            </Pagination>

            <!-- Info de pagination -->
            <div class="text-center text-sm text-muted-foreground">
                Affichage des étudiants {{ props.roles.data.length ? props.roles.data.length : 0 }} sur {{ props.roles.total }} total
                (Page {{ props.roles.current_page }} sur {{ props.roles.last_page }})
            </div>
        </div>
    </AppLayout>
</template>
