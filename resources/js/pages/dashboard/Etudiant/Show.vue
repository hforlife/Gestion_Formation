<script setup lang="ts">
import AppLayout from '@/layouts/AppLayout.vue';
import { dashboard } from '@/routes';
import { index, edit } from '@/routes/etudiant';
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
</script>

<template>
  <Head :title="`Détails Etudiant: ${props.etudiant.nom}`" />

  <AppLayout :breadcrumbs="breadcrumbs">
    <div class="flex flex-col gap-4 p-4">
      <!-- Header -->
      <div class="flex items-center justify-between">
        <h1 class="text-2xl font-bold">
          {{ props.etudiant.nom }} {{ props.etudiant.prenom }}
        </h1>
        <div class="flex gap-2">
          <Link :href="edit(props.etudiant.id).url">
            <button class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">
              Modifier
            </button>
          </Link>
          <Link :href="index().url">
            <button class="px-4 py-2 bg-gray-300 rounded hover:bg-gray-400">
              Retour à la liste
            </button>
          </Link>
        </div>
      </div>

      <!-- Informations Etudiant -->
      <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div class="space-y-2">
          <p><strong>Email :</strong> {{ props.etudiant.email }}</p>
          <p><strong>Téléphone :</strong> {{ props.etudiant.telephone }}</p>
          <p><strong>Adresse :</strong> {{ props.etudiant.adresse }}</p>
          <p><strong>Profession :</strong> {{ props.etudiant.profession }}</p>
        </div>

        <div class="space-y-2">
          <p><strong>Date d'inscription :</strong> {{ props.etudiant.inscription_date }}</p>
          <p><strong>Statut :</strong> {{ props.etudiant.status }}</p>
          <p>
            <strong>Formation :</strong>
            <span v-if="props.etudiant.formation">
              {{ props.etudiant.formation.title }}
            </span>
            <span v-else class="text-gray-500">Aucune formation associée</span>
          </p>
        </div>
      </div>
    </div>
  </AppLayout>
</template>
