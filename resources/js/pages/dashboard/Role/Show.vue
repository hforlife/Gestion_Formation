<script setup lang="ts">
import AppLayout from '@/layouts/AppLayout.vue';
import { dashboard } from '@/routes';
import { index } from '@/routes/role';
import { type BreadcrumbItem } from '@/types';
import { Head, Link } from '@inertiajs/vue3';
import { computed } from 'vue';
import { Button } from '@/components/ui/button';

interface Permission {
  id: number;
  name: string;
  module: string;
}

const props = defineProps<{
  role: {
    id: number;
    name: string;
    permissions: Permission[];
  };
}>();

// Regroupement par module
const groupedPermissions = computed(() => {
  const groups: Record<string, Permission[]> = {};
  props.role.permissions.forEach((permission) => {
    const parts = permission.name.split(' ');
        const resourceName = parts.length > 1 ? parts[1] : 'autres';

        if (!groups[resourceName]) groups[resourceName] = [];
        groups[resourceName].push(permission);
  });
  return groups;
});

const breadcrumbs: BreadcrumbItem[] = [
  { title: 'Tableau de bord', href: dashboard().url },
  { title: 'Roles', href: index().url },
  { title: props.role.name, href: '#' },
];
</script>

<template>
  <Head title="Détails du Rôle" />

  <AppLayout :breadcrumbs="breadcrumbs">
    <div class="flex h-full flex-1 flex-col gap-4 overflow-x-auto rounded-xl p-4">
      <div class="flex items-center justify-between">
        <h1 class="text-2xl font-bold">Détails du rôle : {{ props.role.name }}</h1>
        <Link :href="index().url">
          <Button variant="default" >Retour à la liste</Button>
        </Link>
      </div>

      <!-- Permissions -->
      <div class="space-y-4 mt-4">
        <h2 class="font-semibold text-lg">Permissions</h2>
        <div
          v-for="(permissions, group) in groupedPermissions"
          :key="group"
          class="border rounded p-3"
        >
          <h3 class="font-bold capitalize mb-2">{{ group }}</h3>
          <ul class="list-disc pl-5">
            <li v-for="permission in permissions" :key="permission.id">
              {{ permission.name }}
            </li>
          </ul>
        </div>
      </div>
    </div>
  </AppLayout>
</template>
