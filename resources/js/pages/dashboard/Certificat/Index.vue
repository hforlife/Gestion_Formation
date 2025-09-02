<script setup lang="ts">
import AppLayout from '@/layouts/AppLayout.vue';
import { dashboard } from '@/routes';
import { index } from '@/routes/certificat';
import { type BreadcrumbItem } from '@/types';
import { Head } from '@inertiajs/vue3';
import type { ColumnDef } from '@tanstack/vue-table';
import { FlexRender, getCoreRowModel, getFilteredRowModel, getPaginationRowModel, getSortedRowModel, useVueTable } from '@tanstack/vue-table';
import { ArrowUpDown } from 'lucide-vue-next';

import { Button } from '@/components/ui/button';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { h, ref } from 'vue';

export interface Etudiant {
    id: number;
    nom: string;
    prenom: string;
    email: string;
    telephone: string;
    adresse: string;
    profession: string;
    formation_id: number; // 👈 ajoute ça
    formation?: { title: string };
    inscription_date: string;
    status: 'En Cours' | 'Validé' | 'Rejété';
}

const props = defineProps<{
    etudiants: Etudiant[];
}>();

// Bouton pour générer le certificat
function generateCertificat(userId: number, formId: number) {
    const url = `/certificat/${userId}/${formId}/generate`;
    window.open(url, '_blank'); // Ouvre le PDF dans un nouvel onglet
}

const columns: ColumnDef<Etudiant>[] = [
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
        header: () => h(Button, { variant: 'ghost' }, () => ['Email', h(ArrowUpDown, { class: 'ml-2 h-4 w-4' })]),
        cell: ({ row }) => h('div', { class: 'lowercase' }, row.getValue('email')),
    },
    {
        accessorKey: 'formation',
        header: 'Formation',
        cell: ({ row }) => h('div', {}, row.original.formation?.title || '—'),
    },
    {
        accessorKey: 'status',
        header: 'Status',
        cell: ({ row }) => h('div', {}, row.getValue('status')),
    },
    {
        id: 'actions',
        header: 'Actions',
        cell: ({ row }) => {
            const etudiant = row.original;
            return h(
                Button,
                {
                    variant: 'default',
                    size: 'sm',
                    onClick: () => generateCertificat(etudiant.id, etudiant.formation_id),
                },
                () => 'Générer',
            );
        },
    },
];

const tableData = ref<Etudiant[]>(props.etudiants);

const table = useVueTable({
    data: tableData.value,
    columns,
    getCoreRowModel: getCoreRowModel(),
    getPaginationRowModel: getPaginationRowModel(),
    getSortedRowModel: getSortedRowModel(),
    getFilteredRowModel: getFilteredRowModel(),
});

const breadcrumbs: BreadcrumbItem[] = [
    { title: 'Tableau de bord', href: dashboard().url },
    { title: 'Certificats', href: index().url },
];
</script>

<template>
    <Head title="Gestion des Certificats" />
    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="flex flex-col gap-4 p-4">
            <h1 class="text-2xl font-bold">Gestion des Certificats</h1>
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
                            <TableRow v-for="row in table.getRowModel().rows" :key="row.id">
                                <TableCell v-for="cell in row.getVisibleCells()" :key="cell.id">
                                    <FlexRender :render="cell.column.columnDef.cell" :props="cell.getContext()" />
                                </TableCell>
                            </TableRow>
                        </template>
                        <TableRow v-else>
                            <TableCell :colspan="columns.length" class="h-24 text-center">Aucun étudiant validé.</TableCell>
                        </TableRow>
                    </TableBody>
                </Table>
            </div>
        </div>
    </AppLayout>
</template>
