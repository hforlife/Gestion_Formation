<script setup lang="ts">
import ClientLayout from '@/layouts/ClientLayout.vue';
import { detail } from '@/routes';
import { Link, router } from '@inertiajs/vue3';

const props = defineProps<{
    formations: {
        data: Array<{
            id: number;
            title: string;
            description: string;
            start_date: string;
            end_date: string;
            price: number;
            logo_formation?: string;
        }>;
        current_page: number;
        first_page_url: string;
        from: number;
        last_page: number;
        last_page_url: string;
        links: Array<{
            url: string | null;
            label: string;
            active: boolean;
        }>;
        next_page_url: string | null;
        path: string;
        per_page: number;
        prev_page_url: string | null;
        to: number;
        total: number;
    };
}>();

const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('fr-FR', {
        day: '2-digit',
        month: 'long',
        year: 'numeric',
    });
};

const truncate = (text: string, length: number) => {
    if (!text) return '';
    return text.length > length ? text.substring(0, length) + '...' : text;
};

// Fonction de navigation pour la pagination
function goToPage(url: string | null) {
    if (url) {
        router.get(
            url,
            {},
            {
                preserveState: true,
                preserveScroll: true,
                replace: true,
            },
        );
    }
}
</script>

<template>
    <ClientLayout>
        <!-- SECTION Formations -->
        <section class="bg-gray-50 py-8 antialiased md:py-12 dark:bg-gray-900">
            <div class="mx-auto max-w-screen-xl px-4 2xl:px-0">
                <!-- Heading -->
                <div class="mb-8 text-center">
                    <h2 class="text-2xl font-extrabold text-gray-900 sm:text-3xl dark:text-white">Nos Formations</h2>
                    <p class="mt-2 text-gray-500 dark:text-gray-400">Découvrez toutes les formations disponibles sur Forma Plus.</p>
                </div>

                <!-- Grid formations -->
                <div class="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
                    <div
                        v-for="formation in formations.data"
                        :key="formation.id"
                        class="rounded-lg border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-800"
                    >
                        <!-- Image -->
                        <div class="h-48 w-full overflow-hidden rounded-t-lg">
                            <img
                                :src="formation.logo_formation ? `/storage/${formation.logo_formation}` : '/images/default.png'"
                                :alt="formation.title"
                                class="h-full w-full object-cover"
                            />
                        </div>

                        <!-- Infos -->
                        <div class="p-5">
                            <h3 class="mb-2 text-lg font-semibold text-gray-900 dark:text-white">
                                {{ formation.title }}
                            </h3>

                            <!-- Description -->
                            <p class="mb-4 text-sm text-gray-700 dark:text-gray-400">
                                {{ truncate(formation.description, 120) }}
                            </p>

                            <!-- Prix -->
                            <p class="mb-4 text-xl font-bold text-primary-600">{{ formation.price }} FCFA</p>

                            <!-- Ligne date + bouton -->
                            <div class="flex items-center justify-between">
                                <p class="text-sm text-primary-600 dark:text-gray-400">
                                    {{ formatDate(formation.start_date) }}
                                </p>

                                <Link
                                    :href="detail.url({ id: formation.id })"
                                    class="inline-flex items-center justify-center rounded-lg bg-primary-700 px-4 py-2 text-sm font-medium text-white hover:bg-primary-800 focus:ring-4 focus:ring-primary-300 focus:outline-none dark:bg-primary-600 dark:hover:bg-primary-700 dark:focus:ring-primary-800"
                                >
                                    Voir les détails
                                </Link>
                            </div>
                        </div>
                    </div>
                </div>

                <div v-if="formations" class="mt-8 flex flex-col items-center">
                    <span class="text-sm text-gray-700 dark:text-gray-400">
                        Affichage
                        <span class="font-semibold text-gray-900 dark:text-white">{{ formations.from }}</span>
                        à
                        <span class="font-semibold text-gray-900 dark:text-white">{{ formations.to }}</span>
                        sur
                        <span class="font-semibold text-gray-900 dark:text-white">{{ formations.total }}</span>
                        formations
                    </span>

                    <div class="xs:mt-0 mt-2 inline-flex">
                        <!-- Bouton Précédent -->
                        <button
                            :class="[
                                'flex h-10 items-center justify-center rounded-s bg-gray-800 px-4 text-base font-medium text-white hover:bg-gray-900 dark:bg-gray-800 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white',
                                { 'cursor-not-allowed opacity-50': !formations.prev_page_url },
                            ]"
                            :disabled="!formations.prev_page_url"
                            @click="goToPage(formations.prev_page_url)"
                        >
                            Précédent
                        </button>

                        <!-- Bouton Suivant -->
                        <button
                            :class="[
                                'flex h-10 items-center justify-center rounded-e bg-gray-800 px-4 text-base font-medium text-white hover:bg-gray-900 dark:bg-gray-800 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white',
                                { 'cursor-not-allowed opacity-50': !formations.next_page_url },
                            ]"
                            :disabled="!formations.next_page_url"
                            @click="goToPage(formations.next_page_url)"
                        >
                            Suivant
                        </button>
                    </div>
                </div>
            </div>
        </section>
    </ClientLayout>
</template>
