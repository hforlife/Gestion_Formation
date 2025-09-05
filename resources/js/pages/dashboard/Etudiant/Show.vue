<script setup lang="ts">
import AppLayout from '@/layouts/AppLayout.vue';
import { dashboard } from '@/routes';
import { edit, index } from '@/routes/etudiant';
import { type BreadcrumbItem } from '@/types';
import { Head, Link } from '@inertiajs/vue3';

const props = defineProps<{
    etudiant: {
        id: number;
        nom: string;
        prenom: string;
        email: string;
        telephone: string;
        adresse: string;
        profession: string;
        inscription_date: string;
        status: string;
        formation: {
            id: number;
            title: string;
        } | null;
    };
}>();

const breadcrumbs: BreadcrumbItem[] = [
    { title: 'Tableau de bord', href: dashboard().url },
    { title: 'Etudiants', href: index().url },
    { title: `Détails ${props.etudiant.nom}`, href: '#' },
];

// Fonction pour formater les dates
const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('fr-FR', {
        day: '2-digit',
        month: 'long',
        year: 'numeric'
    });
};
</script>

<template>
    <Head :title="`Détails Etudiant: ${props.etudiant.nom}`" />

    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="flex flex-col gap-6 p-6">
            <!-- En-tête -->
            <div class="flex flex-col items-start justify-between gap-4 sm:flex-row sm:items-center">
                <div>
                    <h1 class="text-2xl font-bold text-gray-900 md:text-3xl">{{ props.etudiant.nom }} {{ props.etudiant.prenom }}</h1>
                    <p class="mt-1 text-sm text-gray-600">ID: {{ props.etudiant.id }}</p>
                </div>

                <div class="flex flex-wrap gap-2">
                    <Link :href="edit(props.etudiant.id).url">
                        <button class="rounded-lg bg-blue-600 px-4 py-2 text-sm font-medium text-white transition-colors hover:bg-blue-700">
                            ✏️ Modifier
                        </button>
                    </Link>
                    <Link :href="index().url">
                        <button class="rounded-lg bg-gray-200 px-4 py-2 text-sm font-medium text-gray-800 transition-colors hover:bg-gray-300">
                            ← Retour à la liste
                        </button>
                    </Link>
                </div>
            </div>

            <!-- Contenu principal -->
            <div class="grid grid-cols-1 gap-6 lg:grid-cols-2">
                <!-- Colonne gauche - Description -->
                <div class="rounded-lg border border-gray-200 bg-white p-6">
                    <h2 class="mb-4 text-lg font-semibold text-gray-900">Informations Etudiant</h2>
                    <div class="prose max-w-none">
                        <p class="leading-relaxed whitespace-pre-line text-gray-700"><strong>Email :</strong> {{ props.etudiant.email }}</p>
                        <p class="leading-relaxed whitespace-pre-line text-gray-700"><strong>Téléphone :</strong> {{ props.etudiant.telephone }}</p>
                        <p class="leading-relaxed whitespace-pre-line text-gray-700"><strong>Adresse :</strong> {{ props.etudiant.adresse }}</p>
                        <p class="leading-relaxed whitespace-pre-line text-gray-700"><strong>Profession :</strong> {{ props.etudiant.profession }}</p>
                    </div>
                </div>

                <!-- Colonne droite - Informations -->
                <div class="rounded-lg border border-gray-200 bg-white p-6">
                    <h2 class="mb-4 text-lg font-semibold text-gray-900">Autres Informations</h2>

                    <div class="space-y-4">
                        <div>
                            <label class="mb-1 block text-sm font-medium text-gray-600">Date d'inscription :</label>
                            <p class="font-medium text-gray-900">{{ formatDate(props.etudiant.inscription_date) || 'Non assigné' }}</p>
                        </div>

                        <div>
                            <label class="mb-1 block text-sm font-medium text-gray-600">Statut :</label>
                            <p class="text-gray-900">{{ props.etudiant.status }}</p>
                        </div>

                        <div>
                            <label class="mb-1 block text-sm font-medium text-gray-600">Formation :</label>
                            <p class="text-gray-900" v-if="props.etudiant.formation">{{ props.etudiant.formation.title }}</p>
                            <p v-else class="text-gray-900">Aucune formation associée</p>
                        </div>
                    </div>
                </div>

                <!-- Image - Pleine largeur -->
                <!-- <div class="col-span-1 rounded-lg border border-gray-200 bg-white p-6 lg:col-span-2">
                    <h2 class="mb-4 text-lg font-semibold text-gray-900">Image de la formation</h2>

                    <div v-if="formation.image" class="flex justify-center">
                        <img
                            :src="`/storage/${formation.image}`"
                            :alt="`Image de ${formation.title}`"
                            class="h-64 max-w-full rounded-lg border border-gray-200 object-contain"
                        />
                    </div>

                    <div v-else class="py-8 text-center">
                        <div class="mb-2 text-6xl text-gray-400">🖼️</div>
                        <p class="text-gray-500">Aucune image disponible</p>
                    </div>
                </div> -->
            </div>
        </div>
    </AppLayout>
</template>
<style scoped>
.whitespace-pre-line {
    white-space: pre-line;
}

.prose {
    max-width: none;
}
</style>
