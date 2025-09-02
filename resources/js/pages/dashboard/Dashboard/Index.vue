<script setup lang="ts">
import AppLayout from '@/layouts/AppLayout.vue';
import { dashboard } from '@/routes';
import { type BreadcrumbItem } from '@/types';
import { Head } from '@inertiajs/vue3';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { ref } from 'vue';

interface Etudiant {
    id: number;
    nom: string;
    prenom: string;
    status: 'En Cours' | 'Validé' | 'Rejété';
    formation_id: number;
}

const props = defineProps<{
    stats: {
        totalEtudiants: number;
        etudiantsValides: number;
        totalFormations: number;
    };
    recentEtudiants: Etudiant[];
}>();

const breadcrumbs: BreadcrumbItem[] = [
    {
        title: 'Tableau de bord',
        href: dashboard().url,
    },
];
</script>

<template>
    <Head title="Tableau de bord" />

    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="flex flex-col gap-6 p-4">

            <!-- Statistiques -->
            <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4">
                <div class="rounded-xl border p-4 shadow hover:shadow-md transition">
                    <h3 class="text-sm font-semibold text-gray-500">Total Étudiants</h3>
                    <p class="mt-2 text-2xl font-bold text-gray-900">{{ props.stats.totalEtudiants }}</p>
                </div>
                <div class="rounded-xl border p-4 shadow hover:shadow-md transition">
                    <h3 class="text-sm font-semibold text-gray-500">Étudiants Validés</h3>
                    <p class="mt-2 text-2xl font-bold text-green-600">{{ props.stats.etudiantsValides }}</p>
                </div>
                <div class="rounded-xl border p-4 shadow hover:shadow-md transition">
                    <h3 class="text-sm font-semibold text-gray-500">Total Formations</h3>
                    <p class="mt-2 text-2xl font-bold text-blue-600">{{ props.stats.totalFormations }}</p>
                </div>
            </div>

            <!-- Derniers étudiants -->
            <div class="rounded-xl border p-4 shadow">
                <h3 class="text-lg font-semibold mb-4">Derniers Étudiants</h3>
                <Table>
                    <TableHeader>
                        <TableRow>
                            <TableHead>ID</TableHead>
                            <TableHead>Nom</TableHead>
                            <TableHead>Prénom</TableHead>
                            <TableHead>Status</TableHead>
                        </TableRow>
                    </TableHeader>
                    <TableBody>
                        <TableRow v-for="etudiant in props.recentEtudiants" :key="etudiant.id">
                            <TableCell>{{ etudiant.id }}</TableCell>
                            <TableCell>{{ etudiant.nom }}</TableCell>
                            <TableCell>{{ etudiant.prenom }}</TableCell>
                            <TableCell>{{ etudiant.status }}</TableCell>
                        </TableRow>
                        <TableRow v-if="props.recentEtudiants.length === 0">
                            <TableCell :colspan="4" class="text-center py-4">Aucun étudiant récemment inscrit.</TableCell>
                        </TableRow>
                    </TableBody>
                </Table>
            </div>

        </div>
    </AppLayout>
</template>
