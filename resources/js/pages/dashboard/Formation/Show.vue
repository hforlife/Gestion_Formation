<script setup lang="ts">
import AppLayout from '@/layouts/AppLayout.vue';
import { dashboard } from '@/routes';
import { index, edit } from '@/routes/formation';
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
        user: { id: number; name: string };
        image?: string;
    };
}>();

const breadcrumbs: BreadcrumbItem[] = [
    { title: 'Tableau de bord', href: dashboard().url },
    { title: 'Formations', href: index().url },
    { title: 'Détails Formation', href: '#' },
];
</script>

<template>
  <Head :title="`Détails Formation: ${props.formation.title}`" />

  <AppLayout :breadcrumbs="breadcrumbs">
    <div class="flex flex-col gap-4 p-4">
      <div class="flex items-center justify-between">
        <h1 class="text-2xl font-bold">{{ props.formation.title }}</h1>
        <div class="flex gap-2">
          <Link :href="edit(props.formation.id).url">
            <button class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">Modifier</button>
          </Link>
          <Link :href="index().url">
            <button class="px-4 py-2 bg-gray-300 rounded hover:bg-gray-400">Retour à la liste</button>
          </Link>
        </div>
      </div>

      <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div class="space-y-2">
          <p><strong>Description :</strong></p>
          <p>{{ props.formation.description }}</p>
        </div>

        <div class="space-y-2">
          <p><strong>Formateur :</strong> {{ props.formation.formateur.name }}</p>
          <p><strong>Date de début :</strong> {{ props.formation.start_date }}</p>
          <p><strong>Date de fin :</strong> {{ props.formation.end_date }}</p>
        </div>

        <div class="col-span-1 md:col-span-2 mt-4">
          <p><strong>Image :</strong></p>
          <div v-if="props.formation.image" class="mt-2">
            <img :src="`/storage/${props.formation.image}`" alt="Image Formation" class="h-48 w-full object-cover rounded" />
          </div>
          <p v-else class="text-gray-500">Pas d'image disponible</p>
        </div>
      </div>
    </div>
  </AppLayout>
</template>
