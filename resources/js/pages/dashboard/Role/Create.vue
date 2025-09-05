<script setup lang="ts">
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import AppLayout from '@/layouts/AppLayout.vue';
import { dashboard } from '@/routes';
import { create, index, store } from '@/routes/role';
import { type BreadcrumbItem } from '@/types';
import { Head, Link, router, useForm } from '@inertiajs/vue3';
import { computed } from 'vue';
import Swal from 'sweetalert2';

interface Permission {
    id: number;
    name: string;
    module: string;
}

const props = defineProps<{
    permissions: Permission[];
}>();

const form = useForm({
    name: '',
    permissions: [] as number[],
});

// Regroupement par module
const groupedPermissions = computed(() => {
    const groups: Record<string, Permission[]> = {};
    props.permissions.forEach((permission) => {
        const parts = permission.name.split(' ');
        const resourceName = parts.length > 1 ? parts[1] : 'autres';
        if (!groups[resourceName]) groups[resourceName] = [];
        groups[resourceName].push(permission);
    });
    return groups;
});

// Calculer si toutes les permissions sont sélectionnées
const allSelected = computed(() => {
    return form.permissions.length === props.permissions.length;
});

// Bouton Select All / Deselect All
function toggleSelectAll() {
    if (allSelected.value) {
        form.permissions = [];
    } else {
        form.permissions = props.permissions.map((p) => p.id);
    }
}

const breadcrumbs: BreadcrumbItem[] = [
    { title: 'Tableau de bord', href: dashboard().url },
    { title: 'Roles', href: index().url },
    { title: 'Nouveau Role', href: create().url },
];

function submitForm() {
    form.post(store().url, {
        onSuccess: () => {
            Swal.fire({
                title: 'Succès',
                text: 'Role ajouté(e) avec succès.',
                icon: 'success',
                confirmButtonText: 'OK',
            });
             form.reset();
            router.visit(index().url);
        },
        onError: () => {
            Swal.fire({
                title: 'Erreur',
                text: 'Veuillez corriger les erreurs dans le formulaire.',
                icon: 'error',
                confirmButtonText: 'OK',
            });
        },
    });
}
</script>

<template>
    <Head title="Nouveau Role" />

    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="flex h-full flex-1 flex-col gap-4 overflow-x-auto rounded-xl p-4">
            <!-- Header -->
            <div class="flex items-center justify-between">
                <h1 class="text-2xl font-bold">Nouveau Rôle</h1>
                <Link :href="index().url">
                    <Button variant="default"> Retour à la liste </Button>
                </Link>
            </div>

            <!-- Formulaire -->
            <form @submit.prevent="submitForm" class="space-y-6">
                <!-- Nom du rôle -->
                <div class="space-y-2">
                    <label for="name" class="block font-medium">Nom du rôle</label>
                    <Input type="text" v-model="form.name" placeholder="ex: Manager" />
                    <span v-if="form.errors.name" class="text-sm text-red-600">{{ form.errors.name }}</span>
                </div>

                <!-- Permissions groupées -->
                <div class="space-y-4">
                    <!-- Bouton Select All -->
                    <div class="mb-2 flex items-center justify-between">
                        <h2 class="font-semibold">Permissions</h2>
                        <Button type="button" @click="toggleSelectAll">
                            {{ allSelected ? 'Tout désélectionner' : 'Tout sélectionner' }}
                        </Button>
                    </div>

                    <div v-for="(permissions, group) in groupedPermissions" :key="group" class="rounded border p-3">
                        <h3 class="mb-2 font-bold capitalize">{{ group }}</h3>
                        <div class="grid grid-cols-1 gap-2 sm:grid-cols-2">
                            <label v-for="permission in permissions" :key="permission.id" class="flex items-center space-x-2">
                                <input type="checkbox" :value="permission.id" v-model="form.permissions" />
                                <span>{{ permission.name }}</span>
                            </label>
                        </div>
                    </div>

                    <span v-if="form.errors.permissions" class="text-sm text-red-600">
                        {{ form.errors.permissions }}
                    </span>
                </div>

                <!-- Boutons -->
                <div class="flex gap-2">
                    <Button type="submit" :disabled="form.processing">Enregistrer</Button>
                    <Link :href="index().url">
                        <Button variant="default">Annuler</Button>
                    </Link>
                </div>
            </form>
        </div>
    </AppLayout>
</template>
