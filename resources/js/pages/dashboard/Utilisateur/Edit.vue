<script setup lang="ts">
import AppLayout from '@/layouts/AppLayout.vue';
import { dashboard } from '@/routes';
import { type BreadcrumbItem } from '@/types';
import { Head, useForm, router } from '@inertiajs/vue3';
import { Select, SelectTrigger, SelectValue, SelectContent, SelectItem } from '@/components/ui/select';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Link } from '@inertiajs/vue3';
import { toast } from 'vue-sonner';
import { route } from 'ziggy-js';

interface Role { id: number; name: string; }
interface User {
  id: number | string;
  name: string;
  username: string;
  email: string;
  roles: number[];
}

const props = defineProps<{
  user: User;
  roles: Role[];
}>();

const form = useForm({
  name: props.user.name,
  username: props.user.username,
  email: props.user.email,
  roles: props.user.roles,
  password: '',
  password_confirmation: '',
});

const breadcrumbs: BreadcrumbItem[] = [
  { title: 'Tableau de bord', href: dashboard().url },
  { title: 'Utilisateurs', href: route('users.index') },
  { title: 'Éditer Utilisateur', href: route('users.edit', { user: props.user.id }) },
];

function submitForm() {
  form.put(route('users.update', { user: props.user.id }), {
    onSuccess: () => {
      toast.success('Utilisateur mis à jour avec succès');
      router.visit(route('users.index'), { preserveScroll: true });
    },
    onError: () => {
      toast.error('Erreur lors de la mise à jour');
    },
  });
}
</script>

<template>
  <Head title="Éditer Utilisateur" />
  <AppLayout :breadcrumbs="breadcrumbs">
    <div class="p-4 flex flex-col gap-4">
      <div class="flex justify-between items-center">
        <h1 class="text-2xl font-bold">Éditer Utilisateur</h1>
        <Link :href="route('users.index')">
          <Button variant="default">Retour à la liste</Button>
        </Link>
      </div>

      <form @submit.prevent="submitForm" class="space-y-4">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div class="space-y-2">
            <label class="block font-medium">Nom & Prénom</label>
            <Input type="text" v-model="form.name" />
            <span v-if="form.errors.name" class="text-sm text-red-600">{{ form.errors.name }}</span>
          </div>
          <div class="space-y-2">
            <label class="block font-medium">Nom d'utilisateur</label>
            <Input type="text" v-model="form.username" />
            <span v-if="form.errors.username" class="text-sm text-red-600">{{ form.errors.username }}</span>
          </div>
          <div class="space-y-2">
            <label class="block font-medium">Email</label>
            <Input type="email" v-model="form.email" />
            <span v-if="form.errors.email" class="text-sm text-red-600">{{ form.errors.email }}</span>
          </div>
          <div class="space-y-2">
            <label class="block font-medium">Rôles</label>
            <Select v-model="form.roles" multiple>
              <SelectTrigger class="w-full" />
              <SelectContent>
                <SelectItem v-for="role in roles" :key="role.id" :value="role.id">{{ role.name }}</SelectItem>
              </SelectContent>
            </Select>
            <span v-if="form.errors.roles" class="text-sm text-red-600">{{ form.errors.roles }}</span>
          </div>
          <div class="space-y-2">
            <label class="block font-medium">Mot de passe (facultatif)</label>
            <Input type="password" v-model="form.password" />
            <span v-if="form.errors.password" class="text-sm text-red-600">{{ form.errors.password }}</span>
          </div>
          <div class="space-y-2">
            <label class="block font-medium">Confirmer Mot de passe</label>
            <Input type="password" v-model="form.password_confirmation" />
            <span v-if="form.errors.password_confirmation" class="text-sm text-red-600">{{ form.errors.password_confirmation }}</span>
          </div>
        </div>

        <div class="flex gap-2">
          <Button type="submit" :disabled="form.processing">Mettre à jour</Button>
          <Link :href="route('users.index')">
            <Button variant="default">Annuler</Button>
          </Link>
        </div>
      </form>
    </div>
  </AppLayout>
</template>
