<script setup lang="ts">
import { Button } from '@/components/ui/button'
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuSeparator, DropdownMenuTrigger } from '@/components/ui/dropdown-menu'
import { MoreHorizontal } from 'lucide-vue-next'
import { Edit, Trash, Eye } from 'lucide-vue-next'
import { router, Link } from '@inertiajs/vue3'
import { toast } from 'vue-sonner'



const props = defineProps({
  id: { type: Number, required: true },         // l'ID de l’entité
  routes: { type: Object, required: true },     // routes dynamiques
  entityName: { type: String, required: true }, // pour messages (ex: "Utilisateur", "Rôle")
})

function edit() {
  if (props.routes.edit) {
    router.visit(`${props.routes.edit}/${props.id}/edit`);
  }
}

function show() {
  if (props.routes.show) {
    router.visit(`${props.routes.show}/${props.id}`);
  }
}

function deleteEntity() {
  if (props.routes.delete) {
    if (confirm(`Confirmer la suppression de ce ${props.entityName} ?`)) {
      router.delete(`${props.routes.delete}/${props.id}`, {
        onSuccess: () => {
          toast.success(`${props.entityName} supprimé avec succès`);
          if (props.routes.index) {
            router.visit(props.routes.index, { preserveScroll: true });
          }
        },
        onError: () => {
          toast.error(`Erreur lors de la suppression du ${props.entityName}`);
        },
      });
    }
  }
}


console.log(props.routes.edit);
console.log(props.routes.edit, { id: props.id });
</script>

<template>
  <DropdownMenu>
    <DropdownMenuTrigger as-child>
      <Button variant="ghost" class="w-8 h-8 p-0">
        <span class="sr-only">Ouvrir Menu</span>
        <MoreHorizontal class="w-4 h-4" />
      </Button>
    </DropdownMenuTrigger>
    <DropdownMenuContent align="end">
      <DropdownMenuLabel>Actions</DropdownMenuLabel>
      <DropdownMenuSeparator />
      <DropdownMenuItem @click="show">
        <Eye class="mr-2 h-4 w-4" />
        Voir
      </DropdownMenuItem>
      <DropdownMenuItem @click="edit">
        <Edit class="mr-2 h-4 w-4" />
        Modifier
      </DropdownMenuItem>
      <DropdownMenuItem @click="deleteEntity">
        <Trash class="mr-2 h-4 w-4" />
        Supprimer
      </DropdownMenuItem>

    </DropdownMenuContent>
  </DropdownMenu>
</template>
