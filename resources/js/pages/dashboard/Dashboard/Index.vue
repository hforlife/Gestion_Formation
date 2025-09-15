<script setup lang="ts">
import AppLayout from '@/layouts/AppLayout.vue';
import { dashboard } from '@/routes';
import { index as etudiantsIndex, create as etudiantsCreate } from '@/routes/etudiant';
import { index as formationsIndex, create as formationsCreate } from '@/routes/formation';
import { type BreadcrumbItem } from '@/types';
import { Head, Link } from '@inertiajs/vue3';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { Button } from '@/components/ui/button';
import {
  Users,
  UserCheck,
  BookOpen,
  TrendingUp,
  Clock,
  ArrowRight,
  UserPlus,
  Book
} from 'lucide-vue-next';
import { ref, computed } from 'vue';

interface Etudiant {
    id: number;
    nom: string;
    prenom: string;
    status: 'En Cours' | 'Validé' | 'Rejété';
    formation_id: number;
    formation?: {
        title: string;
    };
    created_at: string;
}

const props = defineProps<{
    stats: {
        totalEtudiants: number;
        etudiantsValides: number;
        totalFormations: number;
        etudiantsEnCours: number;
        etudiantesRejetes: number;
        tauxValidation: number;
    };
    recentEtudiants: Etudiant[];
    evolutionMensuelle: {
        mois: string;
        inscriptions: number;
        validations: number;
    }[];
}>();

const breadcrumbs: BreadcrumbItem[] = [
    {
        title: 'Tableau de bord',
        href: dashboard().url,
    },
];

// Fonction pour formater la date
const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('fr-FR', {
        day: '2-digit',
        month: 'short',
        year: 'numeric'
    });
};

// Couleurs selon le statut
const getStatusColor = (status: string) => {
    switch (status) {
        case 'Validé': return 'text-green-600 bg-green-100';
        case 'En Cours': return 'text-yellow-600 bg-yellow-100';
        case 'Rejété': return 'text-red-600 bg-red-100';
        default: return ' bg-gray-100';
    }
};

// Données pour le graphique (simplifié)
const chartData = computed(() => props.evolutionMensuelle);
</script>

<template>
    <Head title="Tableau de bord" />

    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="flex flex-col gap-6 p-6">
            <!-- En-tête -->
            <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
                <div>
                    <h1 class="text-2xl font-bold">Tableau de bord</h1>
                    <p class="text-sm mt-1">Vue d'ensemble de votre centre de formation</p>
                </div>
                <div class="flex gap-2">
                    <Link :href="etudiantsIndex().url">
                        <Button variant="outline" size="sm" class="gap-2">
                            <Users class="w-4 h-4" />
                            Voir tous les candidat(e)s
                        </Button>
                    </Link>
                </div>
            </div>

            <!-- Statistiques principales -->
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
                <!-- Total Étudiants -->
                <div class="rounded-xl border  p-6 shadow-sm hover:shadow-md transition-shadow">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm font-medium ">Total candidat(e)s</p>
                            <p class="mt-2 text-3xl font-bold ">{{ props.stats.totalEtudiants }}</p>
                        </div>
                        <div class="p-3 bg-blue-100 rounded-full">
                            <Users class="w-6 h-6 text-blue-600" />
                        </div>
                    </div>
                    <div class="mt-4 flex items-center text-sm">
                        <TrendingUp class="w-4 h-4 mr-1 text-green-500" />
                        <span>{{ props.stats.tauxValidation }}% de taux de validation</span>
                    </div>
                </div>

                <!-- Candidat(e)s Validés -->
                <div class="rounded-xl border  p-6 shadow-sm hover:shadow-md transition-shadow">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm font-medium ">Candidat(e)s Validés</p>
                            <p class="mt-2 text-3xl font-bold text-green-600">{{ props.stats.etudiantsValides }}</p>
                        </div>
                        <div class="p-3 bg-green-100 rounded-full">
                            <UserCheck class="w-6 h-6 text-green-600" />
                        </div>
                    </div>
                    <div class="mt-4 text-sm  ">
                        {{ Math.round((props.stats.etudiantsValides / props.stats.totalEtudiants) * 100) }}% du total
                    </div>
                </div>

                <!-- Formations -->
                <div class="rounded-xl border  p-6 shadow-sm hover:shadow-md transition-shadow">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm font-medium ">Total Formations</p>
                            <p class="mt-2 text-3xl font-bold">{{ props.stats.totalFormations }}</p>
                        </div>
                        <div class="p-3 bg-purple-100 rounded-full">
                            <BookOpen class="w-6 h-6 text-purple-600" />
                        </div>
                    </div>
                    <Link :href="formationsIndex().url">
                        <div class="mt-4 flex items-center text-sm   hover:text-blue-700 cursor-pointer">
                            <Book class="w-4 h-4 mr-1 text-blue-700" />
                            Voir les formations
                        </div>
                    </Link>
                </div>

                <!-- En Cours -->
                <div class="rounded-xl border  p-6 shadow-sm hover:shadow-md transition-shadow">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm font-medium ">En Cours</p>
                            <p class="mt-2 text-3xl font-bold">{{ props.stats.etudiantsEnCours }}</p>
                        </div>
                        <div class="p-3 bg-yellow-100 rounded-full">
                            <Clock class="w-6 h-6 text-yellow-600" />
                        </div>
                    </div>
                    <div class="mt-4 text-sm  ">
                        En attente de validation
                    </div>
                </div>
            </div>

            <!-- Grille principale -->
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <!-- Derniers candidat(e)s -->
                <div class="rounded-xl border p-6 shadow-sm">
                    <div class="flex items-center justify-between mb-6">
                        <h3 class="text-lg font-semibold ">Dernières inscriptions</h3>
                        <Link :href="etudiantsIndex().url">
                            <Button variant="ghost" size="sm" class="gap-2">
                                Voir tout
                                <ArrowRight class="w-4 h-4" />
                            </Button>
                        </Link>
                    </div>
                    <div class="overflow-hidden">
                        <Table>
                            <TableHeader>
                                <TableRow>
                                    <TableHead>Candidat</TableHead>
                                    <TableHead>Formation</TableHead>
                                    <TableHead>Date</TableHead>
                                    <TableHead>Status</TableHead>
                                </TableRow>
                            </TableHeader>
                            <TableBody>
                                <TableRow v-for="etudiant in props.recentEtudiants" :key="etudiant.id" >
                                    <TableCell>
                                        <div class="font-medium">{{ etudiant.prenom }} {{ etudiant.nom }}</div>
                                    </TableCell>
                                    <TableCell>
                                        <span class="text-sm ">{{ etudiant.formation?.title || 'N/A' }}</span>
                                    </TableCell>
                                    <TableCell>
                                        <span class="text-sm text-gray-500">{{ formatDate(etudiant.created_at) }}</span>
                                    </TableCell>
                                    <TableCell>
                                        <span :class="['px-2 py-1 rounded-full text-xs font-medium', getStatusColor(etudiant.status)]">
                                            {{ etudiant.status }}
                                        </span>
                                    </TableCell>
                                </TableRow>
                                <TableRow v-if="props.recentEtudiants.length === 0">
                                    <TableCell :colspan="4" class="text-center py-8 text-gray-500">
                                        <UserPlus class="w-12 h-12 mx-auto mb-2 text-gray-300" />
                                        <p>Aucun candidat(e)s récemment inscrit</p>
                                    </TableCell>
                                </TableRow>
                            </TableBody>
                        </Table>
                    </div>
                </div>

                <!-- Évolution mensuelle -->
                <div class="rounded-xl border  p-6 shadow-sm">
                    <div class="flex items-center justify-between mb-6">
                        <h3 class="text-lg font-semibold ">Évolution mensuelle</h3>
                        <span class="text-sm text-gray-500">6 derniers mois</span>
                    </div>
                    <div class="space-y-4">
                        <div v-for="item in chartData" :key="item.mois" class="flex items-center justify-between">
                            <span class="text-sm font-medium">{{ item.mois }}</span>
                            <div class="flex items-center gap-4">
                                <div class="text-right">
                                    <span class="text-sm ">{{ item.inscriptions }} inscriptions</span>
                                    <div class="w-32 h-2 bg-gray-200 rounded-full mt-1">
                                        <div
                                            class="h-2 bg-blue-500 rounded-full"
                                            :style="{ width: Math.min((item.inscriptions / Math.max(...chartData.map(i => i.inscriptions))) * 100, 100) + '%' }"
                                        ></div>
                                    </div>
                                </div>
                                <div class="text-right">
                                    <span class="text-sm text-green-600">{{ item.validations }} validations</span>
                                    <div class="w-32 h-2 bg-gray-200 rounded-full mt-1">
                                        <div
                                            class="h-2 bg-green-500 rounded-full"
                                            :style="{ width: Math.min((item.validations / Math.max(...chartData.map(i => i.validations))) * 100, 100) + '%' }"
                                        ></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div v-if="chartData.length === 0" class="text-center py-8 text-gray-500">
                        <TrendingUp class="w-12 h-12 mx-auto mb-2 text-gray-300" />
                        <p>Aucune donnée d'évolution disponible</p>
                    </div>
                </div>
            </div>

            <!-- Actions rapides -->
            <div class="rounded-xl border  p-6 shadow-sm">
                <h3 class="text-lg font-semibold  mb-4">Actions rapides</h3>
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
                    <Link :href="etudiantsIndex().url">
                        <Button variant="outline" class="w-full h-16 flex-col gap-2">
                            <Users class="w-6 h-6" />
                            <span>Gérer les candidats</span>
                        </Button>
                    </Link>
                    <Link :href="formationsIndex().url">
                        <Button variant="outline" class="w-full h-16 flex-col gap-2">
                            <BookOpen class="w-6 h-6" />
                            <span>Gérer les formations</span>
                        </Button>
                    </Link>
                    <Link :href="etudiantsCreate().url">
                        <Button variant="outline" class="w-full h-16 flex-col gap-2">
                            <UserPlus class="w-6 h-6" />
                            <span>Nouveau candidat</span>
                        </Button>
                    </Link>
                    <Link :href="formationsCreate().url">
                        <Button variant="outline" class="w-full h-16 flex-col gap-2">
                            <Book class="w-6 h-6" />
                            <span>Nouvelle formation</span>
                        </Button>
                    </Link>
                </div>
            </div>
        </div>
    </AppLayout>
</template>

<style scoped>
.transition-shadow {
    transition: box-shadow 0.2s ease-in-out;
}
</style>
