<script setup lang="ts">
import { Button } from '@/components/ui/button';
import AppLayout from '@/layouts/AppLayout.vue';
import { dashboard } from '@/routes';
import { index, edit } from '@/routes/user';
import { type BreadcrumbItem } from '@/types';
import { Head, Link } from '@inertiajs/vue3';

interface User {
    id: number;
    name: string;
    username: string;
    email: string;
}

const props = defineProps<{
    users: User;
}>();

const breadcrumbs: BreadcrumbItem[] = [
    {
        title: 'Tableau de bord',
        href: dashboard().url,
    },
    {
        title: 'Utilisateur',
        href: index().url,
    },
    {
        title: 'Détails Utilisateur',
        href: '#',
    },
];
</script>

<template>
    <Head title="Détails Utilisateur" />

    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="flex flex-col gap-6 p-6">
            <!-- En-tête -->
            <div class="flex flex-col items-start justify-between gap-4 sm:flex-row sm:items-center">
                <div>
                    <h1 class="text-2xl font-bold md:text-3xl">{{ props.users.name }}</h1>
                    <p class="mt-1 text-sm">ID: {{ props.users.id }}</p>
                </div>

                <div class="flex flex-wrap gap-2">
                    <Link :href="edit(props.users.id).url">
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
                   <h2 class="mb-4 text-lg font-semibold">Informations</h2>

                    <div class="space-y-4">
                        <div>
                            <label class="mb-1 block text-sm font-medium">Nom :</label>
                            <p class="font-medium">{{ props.users.name || 'Non assigné' }}</p>
                        </div>

                        <div>
                            <label class="mb-1 block text-sm font-medium">Nom D'utilisateur :</label>
                            <p class="font-medium">{{ props.users.username || 'Non assigné' }}</p>
                        </div>

                        <div>
                            <label class="mb-1 block text-sm font-medium">Adresse Email :</label>
                            <p class="font-medium">{{ props.users.email }}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AppLayout>
</template>
