<script setup lang="ts">
import { Pagination, PaginationContent, PaginationItem, PaginationNext, PaginationPrevious } from '@/components/ui/pagination';
import AppLayout from '@/layouts/AppLayout.vue';
import { dashboard } from '@/routes';
import { create, index } from '@/routes/formation';
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
import { ChevronDown } from 'lucide-vue-next';

import { Button } from '@/components/ui/button';
import { Checkbox } from '@/components/ui/checkbox';
import DropdownAction from '@/components/ui/data-table/DataTableDemoColumn.vue';
import { DropdownMenu, DropdownMenuCheckboxItem, DropdownMenuContent, DropdownMenuTrigger } from '@/components/ui/dropdown-menu';
import { Input } from '@/components/ui/input';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { valueUpdater } from '@/lib/utils';
import { Link, router } from '@inertiajs/vue3';
import { h, ref, watch } from 'vue';

export interface Formation {
    id: number;
    title: string;
    description: string;
    start_date: string;
    end_date: string;
    user_id: string;
}

const props = defineProps<{
    formations: {
        data: Formation[];
        current_page: number;
        last_page: number;
        per_page: number;
        total: number;
        links: { url: string | null; label: string; active: boolean }[];
    };
}>();

// Les données du tableau avec watcher
const formationsData = ref<Formation[]>(props.formations.data);
watch(
    () => props.formations.data,
    (newData) => {
        formationsData.value = newData;
    },
    { immediate: true },
);

const columns: ColumnDef<Formation>[] = [
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
        accessorKey: 'title',
        header: 'Titre',
        cell: ({ row }) => h('div', { class: 'capitalize' }, row.getValue('title')),
    },
    {
        accessorKey: 'description',
        header: 'Description',
        cell: ({ row }) => {
            const description = row.getValue('description') as string;
            const truncated = description.length > 50 ? description.substring(0, 50) + '...' : description;

            return h(
                'div',
                {
                    class: 'truncate max-w-48 capitalize',
                },
                [
                    // Avec Tooltip (décommentez si disponible)
                    // h(Tooltip, {}, [
                    //     h(TooltipTrigger, { as: 'span' }, truncated),
                    //     h(TooltipContent, {}, description)
                    // ])
                    truncated,
                ],
            );
        },
    },
    {
        accessorKey: 'start_date',
        header: 'Date de début',
        cell: ({ row }) => h('div', { class: 'capitalize' }, row.getValue('start_date')),
    },
    {
        accessorKey: 'end_date',
        header: 'Date de fin',
        cell: ({ row }) => h('div', { class: 'capitalize' }, row.getValue('end_date')),
    },
    {
        accessorKey: 'user_id',
        header: 'Formateur',
        cell: ({ row }) => h('div', { class: 'capitalize' }, row.original.formateur?.name || '—'),
    },
    {
        id: 'actions',
        enableHiding: false,
        cell: ({ row }) => {
            const formation = row.original;
            return h(DropdownAction, {
                id: formation.id,
                entityName: 'Utilisateur',
                routes: {
                    show: '/formation', // /user/{id}
                    edit: '/formation', // /user/{id}/edit
                    delete: '/formation', // /user/{id}
                    index: '/formation', // /user
                },
            });
        },
    },
];

// États table
const sorting = ref<SortingState>([]);
const columnFilters = ref<ColumnFiltersState>([]);
const columnVisibility = ref<VisibilityState>({});
const rowSelection = ref({});
const expanded = ref<ExpandedState>({});

const table = useVueTable({
    data: formationsData,
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
        title: 'Formations',
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
    <Head title="Gestion des Formations" />

    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="flex h-full flex-1 flex-col gap-4 overflow-x-auto rounded-xl p-4">
            <div class="flex items-center justify-between">
                <h1 class="text-2xl font-bold">Gestion des Formations</h1>
                <Link :href="create().url">
                    <Button variant="default"> Nouvelle Formation </Button>
                </Link>
            </div>
            <div class="flex items-center gap-2 py-4">
                <Input
                    class="max-w-52"
                    placeholder="Filtrer Titre..."
                    :model-value="table.getColumn('title')?.getFilterValue() as string"
                    @update:model-value="table.getColumn('title')?.setFilterValue($event)"
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
            <Pagination v-if="props.formations.links.length > 1">
                <PaginationContent>
                    <!-- Bouton Précédent -->
                    <PaginationPrevious
                        :class="{ 'cursor-not-allowed opacity-50': !props.formations.links[0].url }"
                        :aria-disabled="!props.formations.links[0].url"
                        @click="goToPage(props.formations.links[0].url)"
                    />

                    <!-- Pages -->
                    <template v-for="(link, index) in props.formations.links.slice(1, -1)" :key="index">
                        <PaginationItem :is-active="link.active" @click="goToPage(link.url)">
                            {{ link.label }}
                        </PaginationItem>
                    </template>

                    <!-- Bouton Suivant -->
                    <PaginationNext
                        :class="{ 'cursor-not-allowed opacity-50': !props.formations.links[props.formations.links.length - 1].url }"
                        :aria-disabled="!props.formations.links[props.formations.links.length - 1].url"
                        @click="goToPage(props.formations.links[props.formations.links.length - 1].url)"
                    />
                </PaginationContent>
            </Pagination>

            <!-- Info de pagination -->
            <div class="text-center text-sm text-muted-foreground">
                Affichage des étudiants {{ props.formations.data.length ? props.formations.data.length : 0 }} sur {{ props.formations.total }} total
                (Page {{ props.formations.current_page }} sur {{ props.formations.last_page }})
            </div>
        </div>
    </AppLayout>
</template>
