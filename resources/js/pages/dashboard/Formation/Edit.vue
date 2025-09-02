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
import { toast } from 'vue-sonner';

const props = defineProps<{
    formation: {
        id: number;
        title: string;
        description: string;
        start_date: string;
        end_date: string;
        user_id: number;
        image?: string;
    };
    formateurs: Array<{ id: number; name: string }>;
}>();

// Initialiser les valeurs du formulaire avec les données existantes
const form = useForm({
    title: props.formation.title,
    description: props.formation.description,
    start_date: props.formation.start_date,
    end_date: props.formation.end_date,
    user_id: props.formation.user_id,
    image: null, // le fichier image sera remplacé si uploadé
});

const breadcrumbs: BreadcrumbItem[] = [
    { title: 'Tableau de bord', href: dashboard().url },
    { title: 'Formations', href: index().url },
    { title: 'Modifier Formation', href: '#' },
];

function submitForm() {
    form.put(update(props.formation.id).url, {
        onSuccess: () => toast.success('Formation mise à jour avec succès'),
        onError: () => toast.error('Erreur lors de la modification'),
        forceFormData: true, // pour envoyer l'image correctement
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

      <form @submit.prevent="submitForm" class="space-y-4">
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

          <!-- Formateur -->
          <div class="space-y-2">
            <label class="block font-medium capitalize">Formateur</label>
            <Select v-model="form.user_id">
              <SelectTrigger class="w-full">
                <SelectValue placeholder="Sélectionnez un formateur" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem v-for="user in props.formateurs" :key="user.id" :value="user.id">
                  {{ user.name }}
                </SelectItem>
              </SelectContent>
            </Select>
            <span v-if="form.errors.user_id" class="text-sm text-red-600">{{ form.errors.user_id }}</span>
          </div>

          <!-- Image -->
          <div class="space-y-2">
            <label class="block font-medium capitalize">Image</label>
            <Input type="file" accept="image/*" @change="(e) => (form.image = e.target.files[0])" />
            <span v-if="form.errors.image" class="text-sm text-red-600">{{ form.errors.image }}</span>

            <!-- Affichage de l'image actuelle -->
            <div v-if="props.formation.image" class="mt-2">
              <img :src="`/storage/${props.formation.image}`" alt="Image actuelle" class="h-24 w-24 object-cover rounded" />
            </div>
          </div>
        </div>

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
