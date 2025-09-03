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
import { index, update } from '@/routes/user';

interface Role { id: number; name: string; }
interface User {
  id: number | string;
  name: string;
  username: string;
  email: string;
  roles: number[];
}

const props = defineProps<{
  users: User;
  roles: Role[];
}>();

const form = useForm({
  name: props.users.name,
  username: props.users.username,
  email: props.users.email,
  roles: props.users.roles,
  password: '',
  password_confirmation: '',
});

const breadcrumbs: BreadcrumbItem[] = [
  { title: 'Tableau de bord', href: dashboard().url },
  { title: 'Utilisateurs', href: index().url },
  { title: 'Éditer Utilisateur', href: '#' },
];

function submitForm() {
  form.put(update(props.users.id).url, {
    onSuccess: () => {
      toast.success('Utilisateur mis à jour avec succès');
      router.visit(index().url, { preserveScroll: true });
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
    <div class="flex h-full flex-1 flex-col gap-4 overflow-x-auto rounded-xl p-4">
      <div class="flex items-center justify-between">
        <h1 class="text-2xl font-bold">Éditer Utilisateur</h1>
        <Link :href="index().url">
          <Button variant="default"> Retour à la liste </Button>
        </Link>
      </div>

      <form @submit.prevent="submitForm" class="space-y-4">
        <div class="grid grid-cols-1 gap-4 md:grid-cols-2">
          <!-- Nom -->
          <div class="space-y-2">
            <label for="name" class="block font-medium capitalize"> Nom & Prénom </label>
            <Input type="text" v-model="form.name" placeholder="John Doe" />
            <span v-if="form.errors.name" class="text-sm text-red-600"> {{ form.errors.name }} </span>
          </div>

          <!-- Username -->
          <div class="space-y-2">
            <label for="username" class="block font-medium capitalize"> Nom d'utilisateur </label>
            <Input type="text" v-model="form.username" placeholder="J_Killer_24" />
            <span v-if="form.errors.username" class="text-sm text-red-600"> {{ form.errors.username }} </span>
          </div>

          <!-- Email -->
          <div class="space-y-2">
            <label for="email" class="block font-medium capitalize"> Email </label>
            <Input type="email" v-model="form.email" placeholder="johndoe@gmail.com" />
            <span v-if="form.errors.email" class="text-sm text-red-600"> {{ form.errors.email }} </span>
          </div>

          <!-- Rôle -->
          <div class="space-y-2">
            <label for="roles" class="block font-medium capitalize"> Rôle </label>
            <Select v-model="form.roles">
              <SelectTrigger class="w-full">
                <SelectValue placeholder="Sélectionnez un rôle" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem v-for="role in roles" :key="role" :value="role">
                  {{ role }}
                </SelectItem>
              </SelectContent>
            </Select>
            <span v-if="form.errors.roles" class="text-sm text-red-600"> {{ form.errors.roles }} </span>
          </div>

          <!-- Password -->
          <div class="space-y-2">
            <label for="password" class="block font-medium capitalize"> Mot de passe </label>
            <Input type="password" v-model="form.password" placeholder="Mot de passe" required />
            <span v-if="form.errors.password" class="text-sm text-red-600"> {{ form.errors.password }} </span>
          </div>

          <!-- Confirm Password -->
          <div class="space-y-2">
            <label for="password_confirmation" class="block font-medium capitalize"> Confirmer Mot de passe </label>
            <Input type="password" v-model="form.password_confirmation" placeholder="Confirmation mot de passe" required />
            <span v-if="form.errors.password_confirmation" class="text-sm text-red-600"> {{ form.errors.password_confirmation }} </span>
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
