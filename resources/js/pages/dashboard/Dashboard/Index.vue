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
        default: return 'text-gray-600 bg-gray-100';
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
                    <h1 class="text-2xl md:text-3xl font-bold text-gray-900">Tableau de bord</h1>
                    <p class="text-sm text-gray-600 mt-1">Vue d'ensemble de votre centre de formation</p>
                </div>
                <div class="flex gap-2">
                    <Link :href="etudiantsIndex().url">
                        <Button variant="outline" size="sm" class="gap-2">
                            <Users class="w-4 h-4" />
                            Voir tous les étudiants
                        </Button>
                    </Link>
                </div>
            </div>

            <!-- Statistiques principales -->
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
                <!-- Total Étudiants -->
                <div class="rounded-xl border bg-white p-6 shadow-sm hover:shadow-md transition-shadow">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm font-medium text-gray-600">Total Étudiants</p>
                            <p class="mt-2 text-3xl font-bold text-gray-900">{{ props.stats.totalEtudiants }}</p>
                        </div>
                        <div class="p-3 bg-blue-100 rounded-full">
                            <Users class="w-6 h-6 text-blue-600" />
                        </div>
                    </div>
                    <div class="mt-4 flex items-center text-sm text-gray-500">
                        <TrendingUp class="w-4 h-4 mr-1 text-green-500" />
                        <span>{{ props.stats.tauxValidation }}% de taux de validation</span>
                    </div>
                </div>

                <!-- Étudiants Validés -->
                <div class="rounded-xl border bg-white p-6 shadow-sm hover:shadow-md transition-shadow">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm font-medium text-gray-600">Étudiants Validés</p>
                            <p class="mt-2 text-3xl font-bold text-green-600">{{ props.stats.etudiantsValides }}</p>
                        </div>
                        <div class="p-3 bg-green-100 rounded-full">
                            <UserCheck class="w-6 h-6 text-green-600" />
                        </div>
                    </div>
                    <div class="mt-4 text-sm text-gray-500">
                        {{ Math.round((props.stats.etudiantsValides / props.stats.totalEtudiants) * 100) }}% du total
                    </div>
                </div>

                <!-- Formations -->
                <div class="rounded-xl border bg-white p-6 shadow-sm hover:shadow-md transition-shadow">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm font-medium text-gray-600">Total Formations</p>
                            <p class="mt-2 text-3xl font-bold text-blue-600">{{ props.stats.totalFormations }}</p>
                        </div>
                        <div class="p-3 bg-purple-100 rounded-full">
                            <BookOpen class="w-6 h-6 text-purple-600" />
                        </div>
                    </div>
                    <Link :href="formationsIndex().url">
                        <div class="mt-4 flex items-center text-sm text-blue-600 hover:text-blue-700 cursor-pointer">
                            <Book class="w-4 h-4 mr-1" />
                            Voir les formations
                        </div>
                    </Link>
                </div>

                <!-- En Cours -->
                <div class="rounded-xl border bg-white p-6 shadow-sm hover:shadow-md transition-shadow">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm font-medium text-gray-600">En Cours</p>
                            <p class="mt-2 text-3xl font-bold text-yellow-600">{{ props.stats.etudiantsEnCours }}</p>
                        </div>
                        <div class="p-3 bg-yellow-100 rounded-full">
                            <Clock class="w-6 h-6 text-yellow-600" />
                        </div>
                    </div>
                    <div class="mt-4 text-sm text-gray-500">
                        En attente de validation
                    </div>
                </div>
            </div>

            <!-- Grille principale -->
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <!-- Derniers étudiants -->
                <div class="rounded-xl border bg-white p-6 shadow-sm">
                    <div class="flex items-center justify-between mb-6">
                        <h3 class="text-lg font-semibold text-gray-900">Dernières inscriptions</h3>
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
                                    <TableHead>Étudiant</TableHead>
                                    <TableHead>Formation</TableHead>
                                    <TableHead>Date</TableHead>
                                    <TableHead>Status</TableHead>
                                </TableRow>
                            </TableHeader>
                            <TableBody>
                                <TableRow v-for="etudiant in props.recentEtudiants" :key="etudiant.id" class="hover:bg-gray-50">
                                    <TableCell>
                                        <div class="font-medium">{{ etudiant.prenom }} {{ etudiant.nom }}</div>
                                    </TableCell>
                                    <TableCell>
                                        <span class="text-sm text-gray-600">{{ etudiant.formation?.title || 'N/A' }}</span>
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
                                        <p>Aucun étudiant récemment inscrit</p>
                                    </TableCell>
                                </TableRow>
                            </TableBody>
                        </Table>
                    </div>
                </div>

                <!-- Évolution mensuelle -->
                <div class="rounded-xl border bg-white p-6 shadow-sm">
                    <div class="flex items-center justify-between mb-6">
                        <h3 class="text-lg font-semibold text-gray-900">Évolution mensuelle</h3>
                        <span class="text-sm text-gray-500">6 derniers mois</span>
                    </div>
                    <div class="space-y-4">
                        <div v-for="item in chartData" :key="item.mois" class="flex items-center justify-between">
                            <span class="text-sm font-medium text-gray-700">{{ item.mois }}</span>
                            <div class="flex items-center gap-4">
                                <div class="text-right">
                                    <span class="text-sm text-gray-600">{{ item.inscriptions }} inscriptions</span>
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
            <div class="rounded-xl border bg-white p-6 shadow-sm">
                <h3 class="text-lg font-semibold text-gray-900 mb-4">Actions rapides</h3>
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
                    <Link :href="etudiantsIndex().url">
                        <Button variant="outline" class="w-full h-16 flex-col gap-2">
                            <Users class="w-6 h-6" />
                            <span>Gérer les étudiants</span>
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
                            <span>Nouvel étudiant</span>
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