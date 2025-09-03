<script setup lang="ts">
import AppLayout from '@/layouts/AppLayout.vue';
import { Head, Link } from '@inertiajs/vue3';
import { Button } from '@/components/ui/button';
import { type BreadcrumbItem } from '@/types';
import { ref } from 'vue';
import { dashboard } from '@/routes';
import { index, show } from '@/routes/user';

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
    <div class="p-6 rounded-lg space-y-4">
      <h1 class="text-2xl font-bold mb-4">Détails de l'utilisateur</h1>

      <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div>
          <p class="font-semibold">Nom :</p>
          <p class="capitalize">{{ props.users.name }}</p>
        </div>
        <div>
          <p class="font-semibold">Nom d'utilisateur :</p>
          <p class="capitalize">{{ props.users.username }}</p>
        </div>
        <div>
          <p class="font-semibold">Email :</p>
          <p class="lowercase">{{ props.users.email }}</p>
        </div>
        <div>
          <p class="font-semibold">ID :</p>
          <p>{{ props.users.id }}</p>
        </div>
      </div>

      <div class="mt-6">
        <Link href="/user">
          <Button variant="default">Retour à la liste</Button>
        </Link>
      </div>
    </div>
  </AppLayout>
</template>
