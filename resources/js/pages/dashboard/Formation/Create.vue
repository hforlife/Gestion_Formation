<script setup lang="ts">
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Textarea } from '@/components/ui/textarea';
import AppLayout from '@/layouts/AppLayout.vue';
import { dashboard } from '@/routes';
import { create, index, store } from '@/routes/formation';
import { type BreadcrumbItem } from '@/types';
import { Head, Link, useForm } from '@inertiajs/vue3';
import Swal from 'sweetalert2';

const props = defineProps<{
    formateurs: Array<{ id: number; name: string }>;
}>();

// Initialiser les valeurs du formulaire
const form = useForm({
    title: '',
    description: '',
    start_date: '',
    end_date: '',
    user_id: '',
    image: null, // initialiser à null
    logo_formation: null, // initialiser à null
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
    {
        title: 'Nouvelle Formation',
        href: create().url,
    },
];

function submitForm() {
    form.post(store().url, {
        onSuccess: () => {
            Swal.fire({
                title: 'Succès',
                text: 'Formation ajouté(e) avec succès.',
                icon: 'success',
                confirmButtonText: 'OK',
            });
            form.reset();
        },
        onError: () => {
            Swal.fire({
                title: 'Erreur',
                text: 'Veuillez corriger les erreurs dans le formulaire.',
                icon: 'error',
                confirmButtonText: 'OK',
            });
        },
        forceFormData: true, // 🔑 obligatoire pour envoyer le fichier
    });
}
</script>

<template>
    <Head title="Nouvelle Formation" />

    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="flex h-full flex-1 flex-col gap-4 overflow-x-auto rounded-xl p-4">
            <div class="flex items-center justify-between">
                <h1 class="text-2xl font-bold">Nouvelle Formation</h1>
                <Link :href="index().url">
                    <Button variant="default"> Retour à la liste </Button>
                </Link>
            </div>

            <form @submit.prevent="submitForm" class="space-y-4">
                <div class="grid grid-cols-1 gap-4 md:grid-cols-2">
                    <!-- Titre -->
                    <div class="space-y-2">
                        <label for="title" class="block font-medium capitalize"> Titre de la Formation </label>
                        <Input type="text" v-model="form.title" placeholder="John Doe" required />
                        <span v-if="form.errors.title" class="text-sm text-red-600"> {{ form.errors.title }} </span>
                    </div>

                    <!-- Description -->
                    <div class="space-y-2">
                        <label for="description" class="block font-medium capitalize"> Description </label>
                        <Textarea v-model="form.description" placeholder="Description de la formation" required />
                        <span v-if="form.errors.description" class="text-sm text-red-600"> {{ form.errors.description }} </span>
                    </div>

                    <!-- Date de debut de la formation -->
                    <div class="space-y-2">
                        <label for="start_date" class="block font-medium capitalize"> Date de début </label>
                        <Input type="date" v-model="form.start_date" required />
                        <span v-if="form.errors.start_date" class="text-sm text-red-600"> {{ form.errors.start_date }} </span>
                    </div>

                    <!-- Date de fin de la formation -->
                    <div class="space-y-2">
                        <label for="end_date" class="block font-medium capitalize"> Date de fin </label>
                        <Input type="date" v-model="form.end_date" required />
                        <span v-if="form.errors.end_date" class="text-sm text-red-600"> {{ form.errors.end_date }} </span>
                    </div>

                    <!-- Formateur -->
                    <div class="space-y-2">
                        <label for="roles" class="block font-medium capitalize"> Formateur </label>
                        <Select v-model="form.user_id">
                            <SelectTrigger class="w-full">
                                <SelectValue placeholder="Sélectionnez un formateur" />
                            </SelectTrigger>
                            <SelectContent>
                                <SelectItem v-for="user in formateurs" :key="user.id" :value="user.id">
                                    {{ user.name }}
                                </SelectItem>
                            </SelectContent>
                        </Select>
                        <span v-if="form.errors.user_id" class="text-sm text-red-600"> {{ form.errors.user_id }} </span>
                    </div>

                    <!-- Image -->
                    <div class="space-y-2">
                        <label for="image" class="block font-medium capitalize"> Image Formation </label>
                        <Input type="file" accept="image/*" @change="(e) => (form.image = e.target.files[0])" />
                        <span v-if="form.errors.image" class="text-sm text-red-600"> {{ form.errors.image }} </span>
                    </div>

                    <!-- Logo de la Formation -->
                    <div class="space-y-2">
                        <label for="logo_formation" class="block font-medium capitalize"> Logo de la formation </label>
                        <Input type="file" accept="image/*" @change="(e) => (form.logo_formation = e.target.files[0])" />
                        <span v-if="form.errors.logo_formation" class="text-sm text-red-600"> {{ form.errors.logo_formation }} </span>
                    </div>
                </div>

                <div class="flex gap-2">
                    <Button type="submit" :disabled="form.processing"> Enregistrer </Button>
                    <Link :href="index().url">
                        <Button variant="default"> Annuler </Button>
                    </Link>
                </div>
            </form>
        </div>
    </AppLayout>
</template>
