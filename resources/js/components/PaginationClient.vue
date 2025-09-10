<template>
    <div v-if="paginationData" class="mt-8 flex flex-col items-center">
        <span class="text-sm text-gray-700 dark:text-gray-400">
            Affichage
            <span class="font-semibold text-gray-900 dark:text-white">{{ paginationData.from }}</span>
            à
            <span class="font-semibold text-gray-900 dark:text-white">{{ paginationData.to }}</span>
            sur
            <span class="font-semibold text-gray-900 dark:text-white">{{ paginationData.total }}</span>
            formations
        </span>

        <div class="xs:mt-0 mt-2 inline-flex">
            <!-- Premier -->
            <Link
                v-if="paginationData.first_page_url && paginationData.current_page > 1"
                :href="paginationData.first_page_url"
                class="flex h-10 items-center justify-center rounded-s bg-gray-800 px-3 text-sm font-medium text-white hover:bg-gray-900 dark:bg-gray-800 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"
                preserve-scroll
            >
                &laquo;
            </Link>
            
            <!-- Précédent -->
            <Link
                v-if="paginationData.prev_page_url"
                :href="paginationData.prev_page_url"
                class="flex h-10 items-center justify-center bg-gray-800 px-3 text-sm font-medium text-white hover:bg-gray-900 dark:bg-gray-800 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"
                preserve-scroll
            >
                &lsaquo;
            </Link>
            
            <!-- Pages -->
            <Link
                v-for="(link, index) in paginationData.links"
                :key="index"
                :href="link.url"
                v-html="link.label"
                class="flex h-10 items-center justify-center px-3 text-sm font-medium"
                :class="{
                    'bg-gray-800 text-white hover:bg-gray-900 dark:bg-gray-800 dark:hover:bg-gray-700': !link.active,
                    'bg-primary-600 text-white': link.active,
                    'rounded-e': index === paginationData.links.length - 1 && !paginationData.next_page_url,
                    'rounded-s': index === 0 && !paginationData.prev_page_url
                }"
                preserve-scroll
            />
            
            <!-- Suivant -->
            <Link
                v-if="paginationData.next_page_url"
                :href="paginationData.next_page_url"
                class="flex h-10 items-center justify-center bg-gray-800 px-3 text-sm font-medium text-white hover:bg-gray-900 dark:bg-gray-800 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"
                preserve-scroll
            >
                &rsaquo;
            </Link>
            
            <!-- Dernier -->
            <Link
                v-if="paginationData.last_page_url && paginationData.current_page < paginationData.last_page"
                :href="paginationData.last_page_url"
                class="flex h-10 items-center justify-center rounded-e bg-gray-800 px-3 text-sm font-medium text-white hover:bg-gray-900 dark:bg-gray-800 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"
                preserve-scroll
            >
                &raquo;
            </Link>
        </div>
    </div>
</template>

<script setup lang="ts">
import { Link } from '@inertiajs/vue3';

defineProps<{
    paginationData: {
        from: number;
        to: number;
        total: number;
        current_page: number;
        last_page: number;
        first_page_url: string;
        last_page_url: string;
        prev_page_url: string | null;
        next_page_url: string | null;
        links: Array<{
            url: string | null;
            label: string;
            active: boolean;
        }>;
    };
}>();
</script>