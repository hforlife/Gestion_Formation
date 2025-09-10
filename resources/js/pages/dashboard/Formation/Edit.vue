<script setup lang="ts">
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Textarea } from '@/components/ui/textarea';
import AppLayout from '@/layouts/AppLayout.vue';
import { dashboard } from '@/routes';
import { index, update } from '@/routes/formation';
import { type BreadcrumbItem } from '@/types';
import { Head, Link, useForm } from '@inertiajs/vue3';
import { ref } from 'vue';
import axios from 'axios'; // ⬅️ AJOUTEZ CET IMPORT
import Swal from 'sweetalert2';

const props = defineProps<{
    formation: {
        id: number;
        title: string;
        description: string;
        start_date: string;
        end_date: string;
        price: number;
        quota: number;
        location: string;
        duration: string;
        user_id: number;
        image: string;
        logo_formation: string;
    };
    formateurs: Array<{ id: number; name: string }>;
}>();

const form = useForm({
    title: props.formation.title || '',
    description: props.formation.description || '',
    start_date: props.formation.start_date || '',
    end_date: props.formation.end_date || '',
    price: props.formation.price.toString() || '',
    quota: props.formation.quota.toString() || '',
    location: props.formation.location || '',
    duration: props.formation.duration || '',
    user_id: props.formation.user_id.toString() || '',
    image: null as File | null,
    logo_formation: null as File | null,
});

const handleImageChange = (event: Event) => {
    const target = event.target as HTMLInputElement;
    if (target.files && target.files[0]) {
        form.image = target.files[0];
    }
};

const handleLogoChange = (event: Event) => {
    const target = event.target as HTMLInputElement;
    if (target.files && target.files[0]) {
        form.logo_formation = target.files[0];
    }
};

const breadcrumbs: BreadcrumbItem[] = [
    { title: 'Tableau de bord', href: dashboard().url },
    { title: 'Formations', href: index().url },
    { title: 'Modifier Formation', href: '#' },
];

function submitForm() {
    form.transform((data) => ({
        ...data,
        _method: 'PUT',
    })).post(update(props.formation.id).url, {
        onSuccess: () => {
            Swal.fire({
                title: 'Succès',
                text: 'Formation modifié(e) avec succès.',
                icon: 'success',
                confirmButtonText: 'OK',
            });
            form.reset();
        },
        onError: (errors) => {
            Swal.fire({
                title: 'Erreur',
                text: 'Veuillez corriger les erreurs dans le formulaire.',
                icon: 'error',
                confirmButtonText: 'OK',
            });
        },
        forceFormData: true,
    });
}
</script>


<template>
    <Head :title="`Modifier Formation: ${props.formation.title}`" />

    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="flex h-full flex-1 flex-col gap-4 overflow-x-auto rounded-xl p-4">
            <div class="flex items-center justify-between">
                <h1 class="text-2xl font-bold">Modifier Formation</h1>
                <Link :href="index().url">
                    <Button variant="default">Retour à la liste</Button>
                </Link>
            </div>

            <form @submit.prevent="submitForm" class="space-y-4" enctype="multipart/form-data">
                <div class="grid grid-cols-1 gap-4 md:grid-cols-2">
                    <!-- Titre -->
                    <div class="space-y-2">
                        <label class="block font-medium capitalize">Titre de la Formation</label>
                        <Input type="text" v-model="form.title" />
                        <span v-if="form.errors.title" class="text-sm text-red-600">{{ form.errors.title }}</span>
                    </div>

                    <!-- Description -->
                    <div class="space-y-2">
                        <label class="block font-medium capitalize">Description</label>
                        <Textarea v-model="form.description" />
                        <span v-if="form.errors.description" class="text-sm text-red-600">{{ form.errors.description }}</span>
                    </div>

                    <!-- Date de début -->
                    <div class="space-y-2">
                        <label class="block font-medium capitalize">Date de début</label>
                        <Input type="date" v-model="form.start_date" />
                        <span v-if="form.errors.start_date" class="text-sm text-red-600">{{ form.errors.start_date }}</span>
                    </div>

                    <!-- Date de fin -->
                    <div class="space-y-2">
                        <label class="block font-medium capitalize">Date de fin</label>
                        <Input type="date" v-model="form.end_date" />
                        <span v-if="form.errors.end_date" class="text-sm text-red-600">{{ form.errors.end_date }}</span>
                    </div>

                    <!-- Prix -->
                    <div class="space-y-2">
                        <label for="price" class="block font-medium capitalize"> Prix (en FCFA) </label>
                        <Input type="number" v-model="form.price" placeholder="100000" min="0" required />
                        <span v-if="form.errors.price" class="text-sm text-red-600"> {{ form.errors.price }} </span>
                    </div>

                    <!-- Quota -->
                    <div class="space-y-2">
                        <label for="quota" class="block font-medium capitalize"> Quota </label>
                        <Input type="number" v-model="form.quota" placeholder="50" min="1" required />
                        <span v-if="form.errors.quota" class="text-sm text-red-600"> {{ form.errors.quota }} </span>
                    </div>

                    <!-- Lieu -->
                    <div class="space-y-2">
                        <label for="location" class="block font-medium capitalize"> Lieu </label>
                        <Input type="text" v-model="form.location" placeholder="Bamako, Mali" required />
                        <span v-if="form.errors.location" class="text-sm text-red-600"> {{ form.errors.location }} </span>
                    </div>

                    <!-- Durée -->
                    <div class="space-y-2">
                        <label for="duration" class="block font-medium capitalize"> Durée (en heures) </label>
                        <Input type="number" v-model="form.duration" placeholder="40" min="1" required />
                        <span v-if="form.errors.duration" class="text-sm text-red-600"> {{ form.errors.duration }} </span>
                    </div>

                    <!-- Formateur -->
                    <div class="space-y-2">
                        <label class="block font-medium capitalize">Formateur</label>
                        <Select v-model="form.user_id">
                            <SelectTrigger class="w-full">
                                <SelectValue placeholder="Sélectionnez un formateur" />
                            </SelectTrigger>
                            <SelectContent>
                                <SelectItem v-for="user in props.formateurs" :key="user.id" :value="user.id.toString()">
                                    {{ user.name }}
                                </SelectItem>
                            </SelectContent>
                        </Select>
                        <span v-if="form.errors.user_id" class="text-sm text-red-600">{{ form.errors.user_id }}</span>
                    </div>

                    <!-- Image -->
                    <div class="space-y-2">
                        <label class="block font-medium capitalize">Image</label>
                        <Input type="file" accept="image/*" @change="handleImageChange" />
                        <span v-if="form.errors.image" class="text-sm text-red-600">{{ form.errors.image }}</span>
                        <div v-if="props.formation.image" class="mt-2">
                            <p class="text-sm text-gray-500">Image actuelle:</p>
                            <img :src="`/storage/${props.formation.image}`" alt="Image actuelle" class="mt-1 h-20 w-20 object-cover rounded">
                        </div>
                    </div>

                    <!-- Logo Formation -->
                    <div class="space-y-2">
                        <label class="block font-medium capitalize">Logo Formation</label>
                        <Input type="file" accept="image/*" @change="handleLogoChange" />
                        <span v-if="form.errors.logo_formation" class="text-sm text-red-600">{{ form.errors.logo_formation }}</span>
                        <div v-if="props.formation.logo_formation" class="mt-2">
                            <p class="text-sm text-gray-500">Logo actuel:</p>
                            <img :src="`/storage/${props.formation.logo_formation}`" alt="Logo actuel" class="mt-1 h-20 w-20 object-cover rounded">
                        </div>
                    </div>
                </div>

                <div class="flex gap-2">
                    <Button type="submit">
                        Modifier
                    </Button>
                    <Link :href="index().url">
                        <Button variant="outline">Annuler</Button>
                    </Link>
                </div>
            </form>
        </div>
    </AppLayout>
</template>
