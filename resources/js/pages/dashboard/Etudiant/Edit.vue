<script setup lang="ts">
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import AppLayout from '@/layouts/AppLayout.vue';
import { dashboard } from '@/routes';
import { index, update } from '@/routes/etudiant';
import { type BreadcrumbItem } from '@/types';
import { Head, Link, useForm } from '@inertiajs/vue3';
import Swal from 'sweetalert2';

const props = defineProps<{
    etudiant: {
        id: number;
        nom: string;
        prenom: string;
        email: string;
        telephone: string;
        adresse: string;
        profession: string;
        formation_id: number;
        inscription_date: string;
        status: string;
    };
    formations: Array<{ id: number; title: string }>;
}>();

// Initialiser les valeurs du formulaire
const form = useForm({
    nom: props.etudiant.nom || '',
    prenom: props.etudiant.prenom || '',
    email: props.etudiant.email || '',
    telephone: props.etudiant.telephone || '',
    adresse: props.etudiant.adresse || '',
    profession: props.etudiant.profession || '',
    formation_id: props.etudiant.formation_id || null,
    inscription_date: props.etudiant.inscription_date || '',
    status: props.etudiant.status || 'En Cours',
});

const breadcrumbs: BreadcrumbItem[] = [
    {
        title: 'Tableau de bord',
        href: dashboard().url,
    },
    {
        title: 'Etudiants',
        href: index().url,
    },
    {
        title: 'Modifier Etudiant',
        href: '#',
    },
];

function submitForm() {
    form.transform((data) => ({
        ...data,
        _method: 'PUT',
    })).post(update(props.etudiant.id).url, {
        onSuccess: () => {
            Swal.fire({
                title: 'Succès',
                text: 'Etudiant modifié(e) avec succès.',
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
    <Head title="Modifier Etudiant" />

    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="flex h-full flex-1 flex-col gap-4 overflow-x-auto rounded-xl p-4">
            <div class="flex items-center justify-between">
                <h1 class="text-2xl font-bold">Modifier Etudiant</h1>
                <Link :href="index().url">
                    <Button variant="default"> Retour à la liste </Button>
                </Link>
            </div>

            <form @submit.prevent="submitForm" class="space-y-4">
                <div class="grid grid-cols-1 gap-4 md:grid-cols-2">
                    <!-- Nom -->
                    <div class="space-y-2">
                        <label for="nom" class="block font-medium capitalize"> Nom </label>
                        <Input type="text" v-model="form.nom" placeholder="Doe" required />
                        <span v-if="form.errors.nom" class="text-sm text-red-600"> {{ form.errors.nom }} </span>
                    </div>

                    <!-- Prenom -->
                    <div class="space-y-2">
                        <label for="prenom" class="block font-medium capitalize"> Prénom </label>
                        <Input type="text" v-model="form.prenom" placeholder="John" required />
                        <span v-if="form.errors.prenom" class="text-sm text-red-600"> {{ form.errors.prenom }} </span>
                    </div>

                    <!-- Email -->
                    <div class="space-y-2">
                        <label for="email" class="block font-medium capitalize"> Adresse Email </label>
                        <Input type="email" v-model="form.email" placeholder="john@doe.com" required />
                        <span v-if="form.errors.email" class="text-sm text-red-600"> {{ form.errors.email }} </span>
                    </div>

                    <!-- Téléphone -->
                    <div class="space-y-2">
                        <label for="telephone" class="block font-medium capitalize"> N° Téléphone </label>
                        <Input type="text" v-model="form.telephone" required />
                        <span v-if="form.errors.telephone" placeholder="+223 00 00 00 00" class="text-sm text-red-600">
                            {{ form.errors.telephone }}
                        </span>
                    </div>

                    <!-- Adresse -->
                    <div class="space-y-2">
                        <label for="adresse" class="block font-medium capitalize"> Adresse </label>
                        <Input type="text" v-model="form.adresse" placeholder="Bamako" required />
                        <span v-if="form.errors.adresse" class="text-sm text-red-600"> {{ form.errors.adresse }} </span>
                    </div>

                    <!-- Profession -->
                    <div class="space-y-2">
                        <label for="profession" class="block font-medium capitalize"> Profession </label>
                        <Input type="text" v-model="form.profession" placeholder="Etudiant" required />
                        <span v-if="form.errors.profession" class="text-sm text-red-600"> {{ form.errors.profession }} </span>
                    </div>

                    <!-- Formation -->
                    <div class="space-y-2">
                        <label for="formation_id" class="block font-medium capitalize"> Formation </label>
                        <Select v-model="form.formation_id">
                            <SelectTrigger class="w-full">
                                <SelectValue placeholder="Sélectionnez une formation" />
                            </SelectTrigger>
                            <SelectContent>
                                <SelectItem v-for="formation in formations" :key="formation.id" :value="formation.id">
                                    {{ formation.title }}
                                </SelectItem>
                            </SelectContent>
                        </Select>
                        <span v-if="form.errors.formation_id" class="text-sm text-red-600"> {{ form.errors.formation_id }} </span>
                    </div>

                    <!-- Date d'inscription -->
                    <div class="space-y-2">
                        <label for="inscription_date" class="block font-medium capitalize"> Date d'inscription </label>
                        <Input type="date" v-model="form.inscription_date" required />
                        <span v-if="form.errors.inscription_date" class="text-sm text-red-600"> {{ form.errors.inscription_date }} </span>
                    </div>

                    <!-- Status -->
                    <div class="space-y-2">
                        <label for="roles" class="block font-medium capitalize"> Status </label>
                        <Select v-model="form.status">
                            <SelectTrigger class="w-full">
                                <SelectValue placeholder="Sélectionnez un status" />
                            </SelectTrigger>
                            <SelectContent>
                                <SelectItem value="En Cours"> En Cours </SelectItem>
                                <SelectItem value="Validé"> Validé </SelectItem>
                                <SelectItem value="Réjété"> Réjété </SelectItem>
                            </SelectContent>
                        </Select>
                        <span v-if="form.errors.status" class="text-sm text-red-600"> {{ form.errors.status }} </span>
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
