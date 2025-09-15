<script setup lang="ts">
import AppLayout from '@/layouts/AppLayout.vue';
import { dashboard } from '@/routes';
import { edit, index } from '@/routes/formation';
import { type BreadcrumbItem } from '@/types';
import { Head, Link } from '@inertiajs/vue3';

const props = defineProps<{
    formation: {
        id: number;
        title: string;
        description: string;
        start_date: string;
        end_date: string;
        user_id: number;
        user?: { id: number; name: string }; // Changé de "formateur" à "user"
        image?: string;
    };
}>();

const breadcrumbs: BreadcrumbItem[] = [
    { title: 'Tableau de bord', href: dashboard().url },
    { title: 'Formations', href: index().url },
    { title: 'Détails Formation', href: '#' },
];

// Fonction pour formater les dates
const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('fr-FR', {
        day: '2-digit',
        month: 'long',
        year: 'numeric',
    });
};
</script>

<template>
    <Head :title="`Détails Formation: ${formation.title}`" />

    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="flex flex-col gap-6 p-6">
            <!-- En-tête -->
            <div class="flex flex-col items-start justify-between gap-4 sm:flex-row sm:items-center">
                <div>
                    <h1 class="text-2xl font-bold md:text-3xl">{{ formation.title }}</h1>
                    <p class="mt-1 text-sm">ID: {{ formation.id }}</p>
                </div>

                <div class="flex flex-wrap gap-2">
                    <Link :href="edit(formation.id).url">
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
                <div class="rounded-lg border p-6">
                    <h2 class="mb-4 text-lg font-semibold">Description de la formation</h2>
                    <div class="prose max-w-none">
                        <p class="leading-relaxed whitespace-pre-line">{{ formation.description }}</p>
                    </div>
                </div>

                <!-- Colonne droite - Informations -->
                <div class="rounded-lg border p-6">
                    <h2 class="mb-4 text-lg font-semibold">Informations</h2>

                    <div class="space-y-4">
                        <div>
                            <label class="mb-1 block text-sm font-medium">Formateur</label>
                            <p class="font-medium">{{ formation.user?.name || 'Non assigné' }}</p>
                        </div>

                        <div>
                            <label class="mb-1 block text-sm font-medium">Date de début</label>
                            <p class="font-medium">{{ formatDate(formation.start_date) }}</p>
                        </div>

                        <div>
                            <label class="mb-1 block text-sm font-medium">Date de fin</label>
                            <p class="font-medium">{{ formatDate(formation.end_date) }}</p>
                        </div>

                        <div>
                            <label class="mb-1 block text-sm font-medium">ID Formateur</label>
                            <p class="font-medium">{{ formation.user_id }}</p>
                        </div>
                    </div>
                </div>

                <!-- Image - Pleine largeur -->
                <div class="col-span-1 rounded-lg border p-6 lg:col-span-2">
                    <h2 class="mb-4 text-lg font-semibold">Image de la formation</h2>

                    <div v-if="formation.image" class="flex justify-center">
                        <img
                            :src="`/storage/${formation.image}`"
                            :alt="`Image de ${formation.title}`"
                            class="h-64 max-w-full rounded-lg border border-gray-200 object-contain"
                        />
                    </div>

                    <div v-else class="py-8 text-center">
                        <div class="mb-2 text-6xl text-gray-400">🖼️</div>
                        <p class="font-semibold">Aucune image disponible</p>
                    </div>
                </div>
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
