<script setup lang="ts">
import AppLayout from '@/layouts/AppLayout.vue';
import { dashboard } from '@/routes';
import { create, index } from '@/routes/etudiant';
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
import { h, ref } from 'vue';


export interface Etudiant {
    id: number;
    nom: string;
    prenom: string;
    email: string;
    telephone: string;
    adresse: string;
    profession: string;
    formation_id: string;
    status: 'En Cours' | 'Validé' | 'Rejété';
}

const props = defineProps<{
    etudiants: Etudiant[];
}>();

// const data = shallowRef<user[]>([
//     {
//         id: props.users.id,
//         name: props.users.name,
//         username: props.users.username,
//         email: props.users.email,
//     },
// ]);

const columns: ColumnDef<Etudiant>[] = [
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
        accessorKey: 'nom',
        header: 'Nom',
        cell: ({ row }) => h('div', { class: 'capitalize' }, row.getValue('nom')),
    },
    {
        accessorKey: 'prenom',
        header: 'Prénom',
        cell: ({ row }) => h('div', { class: 'capitalize' }, row.getValue('prenom')),
    },
    {
        accessorKey: 'email',
        header: ({ column }) => {
            return h(
                Button,
                {
                    variant: 'ghost',
                    onClick: () => column.toggleSorting(column.getIsSorted() === 'asc'),
                },
                () => ['Email', h(ArrowUpDown, { class: 'ml-2 h-4 w-4' })],
            );
        },
        cell: ({ row }) => h('div', { class: 'lowercase' }, row.getValue('email')),
    },
    {
        accessorKey: 'telephone',
        header: 'Téléphone',
        cell: ({ row }) => h('div', { class: 'capitalize' }, row.getValue('telephone')),
    },
    {
        accessorKey: 'adresse',
        header: 'Adresse',
        cell: ({ row }) => h('div', { class: 'capitalize' }, row.getValue('adresse')),
    },
    {
        accessorKey: 'profession',
        header: 'Profession',
        cell: ({ row }) => h('div', { class: 'capitalize' }, row.getValue('profession')),
    },
    {
        accessorKey: 'formation_id',
        header: 'Formation',
        cell: ({ row }) => h('div', { class: 'capitalize' }, row.original.formation?.title || '—'),
    },
    {
        accessorKey: 'inscription_date',
        header: "Date d'inscription",
        cell: ({ row }) => h('div', { class: 'capitalize' }, row.getValue('inscription_date')),
    },
    {
        accessorKey: 'status',
        header: 'Status',
        cell: ({ row }) => {
            const etudiant = row.original;

            return h(
                'select',
                {
                    class: 'border rounded p-1 text-sm',
                    value: etudiant.status,
                    onChange: (e: Event) => {
                        const newStatus = (e.target as HTMLSelectElement).value;
                        // Requête vers Laravel via Inertia
                        router.put(`/etudiant/${etudiant.id}/status`, { status: newStatus });
                    },
                },
                [
                    h('option', { value: 'En Cours' }, 'En Cours'),
                    h('option', { value: 'Validé' }, 'Validé'),
                    h('option', { value: 'Rejété' }, 'Rejété'),
                ],
            );
        },
    },
    {
        id: 'actions',
        enableHiding: false,
        cell: ({ row }) => {
            const etudiant = row.original;
            return h(DropdownAction, {
                id: etudiant.id,
                entityName: 'Etudiant',
                routes: {
                    show: '/etudiant', // /user/{id}
                    edit: '/etudiant', // /user/{id}/edit
                    delete: '/etudiant', // /user/{id}
                    index: '/etudiant', // /user
                },
            });
        },
    },
];

const sorting = ref<SortingState>([]);
const columnFilters = ref<ColumnFiltersState>([]);
const columnVisibility = ref<VisibilityState>({});
const rowSelection = ref({});
const expanded = ref<ExpandedState>({});
const tableData = ref<Etudiant[]>(props.etudiants);

const table = useVueTable({
    data: tableData.value,
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

// const statuses: user['name'][] = 'name';
// function randomize() {
//     data.value = data.value.map((item) => ({
//         ...item,
//         status: statuses[Math.floor(Math.random() * statuses.length)],
//     }));
// }

const breadcrumbs: BreadcrumbItem[] = [
    {
        title: 'Tableau de bord',
        href: dashboard().url,
    },
    {
        title: 'Etudiants',
        href: index().url,
    },
];
</script>

<template>
    <Head title="Gestion des Etudiants" />

    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="flex h-full flex-1 flex-col gap-4 overflow-x-auto rounded-xl p-4">
            <div class="flex items-center justify-between">
                <h1 class="text-2xl font-bold">Gestion des Etudiants</h1>
                <Link :href="create().url">
                    <Button variant="default"> Nouvel Etudiant </Button>
                </Link>
            </div>
            <div class="flex items-center gap-2 py-4">
                <Input
                    class="max-w-52"
                    placeholder="Filtrer Email..."
                    :model-value="table.getColumn('email')?.getFilterValue() as string"
                    @update:model-value="table.getColumn('email')?.setFilterValue($event)"
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

            <div class="flex items-center justify-end space-x-2 py-4">
                <div class="flex-1 text-sm text-muted-foreground">
                    {{ table.getFilteredSelectedRowModel().rows.length }} of {{ table.getFilteredRowModel().rows.length }} ligne(s) selectionné.
                </div>
                <div class="space-x-2">
                    <Button variant="outline" size="sm" :disabled="!table.getCanPreviousPage()" @click="table.previousPage()"> Précedent </Button>
                    <Button variant="outline" size="sm" :disabled="!table.getCanNextPage()" @click="table.nextPage()"> Suivant </Button>
                </div>
            </div>
        </div>
    </AppLayout>
</template>
