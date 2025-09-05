<script setup lang="ts">
import AppLayout from '@/layouts/AppLayout.vue';
import { Pagination, PaginationContent, PaginationItem, PaginationNext, PaginationPrevious } from '@/components/ui/pagination';
import { dashboard } from '@/routes';
import { index } from '@/routes/certificat';
import { type BreadcrumbItem } from '@/types';
import { Head } from '@inertiajs/vue3';
import type { ColumnDef } from '@tanstack/vue-table';
import { FlexRender, getCoreRowModel, getFilteredRowModel, getPaginationRowModel, getSortedRowModel, useVueTable } from '@tanstack/vue-table';
import { ArrowUpDown } from 'lucide-vue-next';

import { Button } from '@/components/ui/button';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { Link, router } from '@inertiajs/vue3';
import { h, ref, watch } from 'vue';

export interface Etudiant {
    id: number;
    nom: string;
    prenom: string;
    email: string;
    telephone: string;
    adresse: string;
    profession: string;
    formation_id: number;
    formation?: { title: string };
    inscription_date: string;
    status: 'En Cours' | 'Validé' | 'Rejété';
}

const props = defineProps<{
    etudiants: {
        data: Etudiant[];
        current_page: number;
        last_page: number;
        per_page: number;
        total: number;
        links: { url: string | null; label: string; active: boolean }[];
    };
}>();

// Les données du tableau avec watcher
const etudiantsData = ref<Etudiant[]>(props.etudiants.data);
watch(
    () => props.etudiants.data,
    (newData) => {
        etudiantsData.value = newData;
    },
    { immediate: true },
);

// Bouton pour générer le certificat PDF
function generateCertificatPDF(userId: number, formId: number) {
    const url = `/certificat/${userId}/${formId}/generate`;
    window.open(url, '_blank');
}

// Bouton pour voir en mode navigateur
function viewCertificate(userId: number, formId: number) {
    const url = `/certificat/${userId}/${formId}/show`;
    window.open(url, '_blank');
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
                'div',
                { class: 'flex gap-2' },
                [
                    h(
                        Button,
                        {
                            variant: 'outline',
                            size: 'sm',
                            onClick: () => viewCertificate(etudiant.id, etudiant.formation_id),
                        },
                        () => '👀 Voir'
                    ),
                    h(
                        Button,
                        {
                            variant: 'default',
                            size: 'sm',
                            onClick: () => generateCertificatPDF(etudiant.id, etudiant.formation_id),
                        },
                        () => '📄 PDF'
                    )
                ]
            );
        },
    },
];

// États table

const rowSelection = ref({});

const table = useVueTable({
    data: etudiantsData,
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

            <!-- ✅ Pagination avec shadcn-vue -->
            <Pagination v-if="props.etudiants.links.length > 1">
                <PaginationContent>
                    <!-- Bouton Précédent -->
                    <PaginationPrevious
                        :class="{ 'cursor-not-allowed opacity-50': !props.etudiants.links[0].url }"
                        :aria-disabled="!props.etudiants.links[0].url"
                        @click="goToPage(props.etudiants.links[0].url)"
                    />

                    <!-- Pages -->
                    <template v-for="(link, index) in props.etudiants.links.slice(1, -1)" :key="index">
                        <PaginationItem :is-active="link.active" @click="goToPage(link.url)">
                            {{ link.label }}
                        </PaginationItem>
                    </template>

                    <!-- Bouton Suivant -->
                    <PaginationNext
                        :class="{ 'cursor-not-allowed opacity-50': !props.etudiants.links[props.etudiants.links.length - 1].url }"
                        :aria-disabled="!props.etudiants.links[props.etudiants.links.length - 1].url"
                        @click="goToPage(props.etudiants.links[props.etudiants.links.length - 1].url)"
                    />
                </PaginationContent>
            </Pagination>

            <!-- Info de pagination -->
            <div class="text-center text-sm text-muted-foreground">
                Affichage des étudiants {{ props.etudiants.data.length ? props.etudiants.data.length : 0 }} sur {{ props.etudiants.total }} total
                (Page {{ props.etudiants.current_page }} sur {{ props.etudiants.last_page }})
            </div>
        </div>
    </AppLayout>
</template>
