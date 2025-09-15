<script setup lang="ts">
import ClientLayout from '@/layouts/ClientLayout.vue';
import { course, home } from '@/routes';
import { Link, router } from '@inertiajs/vue3';
import { ref } from 'vue';

const props = defineProps<{
    formation: {
        id: number;
        title: string;
        description: string;
        start_date: string;
        end_date: string;
        price: number;
        quota: number;
        location: string;
        duration: string;
        logo_formation?: string;
        image?: string;
        formateur?: {
            name: string;
            bio?: string;
            photo?: string;
        };
    };
    otherFormations: Array<{
        id: number;
        title: string;
        description: string;
        price: number;
        logo_formation?: string;
    }>;
}>();

// États pour le modal et le formulaire
const showModal = ref(false);
const formData = ref({
    nom: '',
    prenom: '',
    email: '',
    telephone: '',
    adresse: '',
    profession: '',
});

const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('fr-FR', {
        day: '2-digit',
        month: 'long',
        year: 'numeric',
    });
};

const formatPrice = (price: number) => {
    return new Intl.NumberFormat('fr-FR').format(price);
};

const truncate = (text: string, length: number) => {
    if (!text) return '';
    return text.length > length ? text.substring(0, length) + '...' : text;
};

const openModal = () => {
    showModal.value = true;
};

const closeModal = () => {
    showModal.value = false;
    // Réinitialiser le formulaire
    formData.value = {
        nom: '',
        prenom: '',
        email: '',
        telephone: '',
        adresse: '',
        profession: '',
    };
};

const submitInscription = () => {
    // Validation simple
    if (!formData.value.nom || !formData.value.prenom || !formData.value.email || !formData.value.telephone) {
        alert('Veuillez remplir tous les champs obligatoires');
        return;
    }

    // Envoyer les données au serveur
    router.post(`/detail/${props.formation.id}/register`, formData.value, {
        onSuccess: () => {
            alert('Votre pré-inscription a été enregistrée avec succès ! Vous recevrez un email de confirmation.');
            closeModal();
        },
        onError: (errors) => {
            alert("Erreur lors de l'inscription: " + (errors.message || 'Veuillez réessayer.'));
        },
    });
};
</script>

<template>
    <ClientLayout>
        <!-- SECTION Détails de la formation -->
        <section class="bg-white py-8 antialiased md:py-12 dark:bg-gray-900">
            <div class="mx-auto max-w-7xl px-4 2xl:px-0">
                <!-- Breadcrumb -->
                <nav class="mb-8 flex" aria-label="Breadcrumb">
                    <ol class="inline-flex items-center space-x-1 md:space-x-3">
                        <li class="inline-flex items-center">
                            <Link
                                :href="home.url()"
                                class="inline-flex items-center text-sm font-medium text-gray-700 hover:text-primary-600 dark:text-gray-400 dark:hover:text-white"
                            >
                                Accueil
                            </Link>
                        </li>
                        <li>
                            <div class="flex items-center">
                                <svg
                                    class="mx-1 h-3 w-3 text-gray-400"
                                    aria-hidden="true"
                                    xmlns="http://www.w3.org/2000/svg"
                                    fill="none"
                                    viewBox="0 0 6 10"
                                >
                                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 9 4-4-4-4" />
                                </svg>
                                <Link
                                    :href="course.url()"
                                    class="ml-1 text-sm font-medium text-gray-700 hover:text-primary-600 md:ml-2 dark:text-gray-400 dark:hover:text-white"
                                >
                                    Formations
                                </Link>
                            </div>
                        </li>
                        <li aria-current="page">
                            <div class="flex items-center">
                                <svg
                                    class="mx-1 h-3 w-3 text-gray-400"
                                    aria-hidden="true"
                                    xmlns="http://www.w3.org/2000/svg"
                                    fill="none"
                                    viewBox="0 0 6 10"
                                >
                                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 9 4-4-4-4" />
                                </svg>
                                <span class="ml-1 text-sm font-medium text-gray-500 md:ml-2 dark:text-gray-400">{{ formation.title }}</span>
                            </div>
                        </li>
                    </ol>
                </nav>

                <div class="grid gap-8 lg:grid-cols-3">
                    <!-- Contenu principal -->
                    <div class="lg:col-span-2">
                        <!-- Image principale -->
                        <div class="mb-6 h-80 w-full overflow-hidden rounded-lg">
                            <img
                                :src="formation.image ? `/storage/${formation.image}` : '/images/formation-default.jpg'"
                                :alt="formation.title"
                                class="h-full w-full object-cover"
                            />
                        </div>

                        <!-- Titre et informations principales -->
                        <div class="mb-6">
                            <h1 class="mb-4 text-3xl font-bold text-gray-900 dark:text-white">{{ formation.title }}</h1>

                            <div class="grid grid-cols-2 gap-4 md:grid-cols-4">
                                <div class="rounded-lg bg-gray-50 p-4 dark:bg-gray-800">
                                    <p class="text-sm text-gray-500 dark:text-gray-400">Prix</p>
                                    <p class="text-xl font-bold text-primary-600">{{ formatPrice(formation.price) }} FCFA</p>
                                </div>
                                <div class="rounded-lg bg-gray-50 p-4 dark:bg-gray-800">
                                    <p class="text-sm text-gray-500 dark:text-gray-400">Début</p>
                                    <p class="font-medium text-gray-900 dark:text-white">{{ formatDate(formation.start_date) }}</p>
                                </div>
                                <div class="rounded-lg bg-gray-50 p-4 dark:bg-gray-800">
                                    <p class="text-sm text-gray-500 dark:text-gray-400">Durée</p>
                                    <p class="font-medium text-gray-900 dark:text-white">{{ formation.duration }} heures</p>
                                </div>
                                <div class="rounded-lg bg-gray-50 p-4 dark:bg-gray-800">
                                    <p class="text-sm text-gray-500 dark:text-gray-400">Places</p>
                                    <p class="font-medium text-gray-900 dark:text-white">{{ formation.quota }} places</p>
                                </div>
                            </div>
                        </div>

                        <!-- Description détaillée -->
                        <div class="mb-8">
                            <h2 class="mb-4 text-2xl font-bold text-gray-900 dark:text-white">Description de la formation</h2>
                            <div class="prose max-w-none text-gray-700 dark:text-gray-300">
                                <p class="whitespace-pre-line">{{ formation.description }}</p>
                            </div>
                        </div>

                        <!-- Formateur -->
                        <div v-if="formation.formateur" class="mb-8">
                            <h2 class="mb-4 text-2xl font-bold text-gray-900 dark:text-white">Votre Formateur</h2>
                            <div class="flex items-center space-x-4 rounded-lg bg-gray-50 p-6 dark:bg-gray-800">
                                <img
                                    :src="formation.logo_formation ? `/storage/${formation.logo_formation}` : '/images/avatar-default.png'"
                                    :alt="formation.formateur.name"
                                    class="h-16 w-16 rounded-full object-cover"
                                />
                                <div>
                                    <h3 class="text-lg font-semibold text-gray-900 dark:text-white">{{ formation.formateur.name }}</h3>
                                </div>
                            </div>
                        </div>

                        <!-- Localisation -->
                        <div class="mb-8">
                            <h2 class="mb-4 text-2xl font-bold text-gray-900 dark:text-white">Lieu de formation</h2>
                            <div class="rounded-lg bg-gray-50 p-6 dark:bg-gray-800">
                                <p class="mb-4 text-gray-700 dark:text-gray-300">{{ formation.location }}</p>

                                <!-- Carte Google Maps responsive -->
                                <div class="relative h-64 w-full overflow-hidden rounded-lg sm:h-96">
                                    <iframe
                                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d973.184159614246!2d-7.935945730314983!3d12.665265207699004!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xe51d310e18e61c3%3A0x335eadffa8089d2c!2sDOUCSOFT%20Technologies%20Sarl!5e0!3m2!1sfr!2sml!4v1757936084500!5m2!1sfr!2sml"
                                        class="absolute inset-0 h-full w-full border-0"
                                        allowfullscreen=""
                                        loading="lazy"
                                        referrerpolicy="no-referrer-when-downgrade"
                                    >
                                    </iframe>
                                </div>
                            </div>
                        </div>

                        <!-- Bouton d'inscription -->
                        <div class="sticky bottom-6 z-10 mt-8 lg:hidden">
                            <button
                                @click="openModal"
                                class="w-full rounded-lg bg-primary-700 px-6 py-4 text-lg font-medium text-white hover:bg-primary-800 focus:ring-4 focus:ring-primary-300 focus:outline-none dark:bg-primary-600 dark:hover:bg-primary-700 dark:focus:ring-primary-800"
                            >
                                S'inscrire à cette formation - {{ formatPrice(formation.price) }} FCFA
                            </button>
                        </div>
                    </div>

                    <!-- Sidebar avec autres formations et bouton d'inscription -->
                    <div class="lg:col-span-1">
                        <!-- Bouton d'inscription (version desktop) -->
                        <div class="sticky top-6 mb-8 hidden lg:block">
                            <div class="rounded-lg bg-white p-6 shadow-lg dark:bg-gray-800">
                                <h3 class="mb-4 text-xl font-bold text-gray-900 dark:text-white">Rejoindre cette formation</h3>
                                <p class="mb-4 text-2xl font-bold text-primary-600">{{ formatPrice(formation.price) }} FCFA</p>
                                <button
                                    @click="openModal"
                                    class="w-full rounded-lg bg-primary-700 px-6 py-3 text-lg font-medium text-white hover:bg-primary-800 focus:ring-4 focus:ring-primary-300 focus:outline-none dark:bg-primary-600 dark:hover:bg-primary-700 dark:focus:ring-primary-800"
                                >
                                    S'inscrire maintenant
                                </button>
                                <p class="mt-3 text-sm text-gray-500 dark:text-gray-400">{{ formation.quota }} places disponibles</p>
                            </div>
                        </div>

                        <!-- Autres formations -->
                        <div class="rounded-lg bg-gray-50 p-6 dark:bg-gray-800">
                            <h3 class="mb-4 text-xl font-bold text-gray-900 dark:text-white">Autres formations</h3>
                            <div class="space-y-4">
                                <div
                                    v-for="otherFormation in otherFormations"
                                    :key="otherFormation.id"
                                    class="flex items-center space-x-3 rounded-lg bg-white p-3 hover:shadow-md dark:bg-gray-700"
                                >
                                    <img
                                        :src="otherFormation.logo_formation ? `/storage/${otherFormation.logo_formation}` : '/images/default.png'"
                                        :alt="otherFormation.title"
                                        class="h-12 w-12 rounded object-cover"
                                    />
                                    <div class="min-w-0 flex-1">
                                        <h4 class="truncate text-sm font-medium text-gray-900 dark:text-white">
                                            {{ otherFormation.title }}
                                        </h4>
                                        <p class="text-sm font-bold text-primary-600">{{ formatPrice(otherFormation.price) }} FCFA</p>
                                    </div>
                                    <Link
                                        :href="`/detail/${otherFormation.id}`"
                                        class="rounded bg-primary-100 px-2 py-1 text-xs font-medium text-primary-700 hover:bg-primary-200 dark:bg-primary-900 dark:text-primary-200 dark:hover:bg-primary-800"
                                    >
                                        Voir
                                    </Link>
                                </div>
                            </div>
                            <Link
                                :href="course.url()"
                                class="mt-4 inline-flex items-center text-sm font-medium text-primary-600 hover:text-primary-700 dark:text-primary-400 dark:hover:text-primary-300"
                            >
                                Voir toutes les formations
                                <svg class="ml-1 h-4 w-4" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                    <path
                                        fill-rule="evenodd"
                                        d="M12.293 5.293a1 1 0 011.414 0l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-2.293-2.293a1 1 0 010-1.414z"
                                        clip-rule="evenodd"
                                    ></path>
                                </svg>
                            </Link>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Modal d'inscription -->
        <div v-if="showModal" class="bg-opacity-50 fixed inset-0 z-50 flex items-center justify-center overflow-x-hidden overflow-y-auto bg-black">
            <div class="relative w-full max-w-md p-4">
                <!-- Modal content -->
                <div class="relative rounded-lg bg-white shadow dark:bg-gray-700">
                    <!-- Modal header -->
                    <div class="flex items-center justify-between rounded-t border-b p-4 md:p-5 dark:border-gray-600">
                        <h3 class="text-lg font-semibold text-gray-900 dark:text-white">Pré-inscription à la formation</h3>
                        <button
                            @click="closeModal"
                            type="button"
                            class="ms-auto inline-flex h-8 w-8 items-center justify-center rounded-lg bg-transparent text-sm text-gray-400 hover:bg-gray-200 hover:text-gray-900 dark:hover:bg-gray-600 dark:hover:text-white"
                        >
                            <svg class="h-3 w-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
                                <path
                                    stroke="currentColor"
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    stroke-width="2"
                                    d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"
                                />
                            </svg>
                            <span class="sr-only">Fermer</span>
                        </button>
                    </div>

                    <!-- Modal body -->
                    <form @submit.prevent="submitInscription" class="p-4 md:p-5">
                        <div class="mb-4 grid gap-4">
                            <div class="grid grid-cols-2 gap-4">
                                <div>
                                    <label for="prenom" class="mb-2 block text-sm font-medium text-gray-900 dark:text-white">Prénom *</label>
                                    <input
                                        type="text"
                                        id="prenom"
                                        v-model="formData.prenom"
                                        class="block w-full rounded-lg border border-gray-300 bg-gray-50 p-2.5 text-sm text-gray-900 focus:border-primary-500 focus:ring-primary-500 dark:border-gray-500 dark:bg-gray-600 dark:text-white dark:placeholder-gray-400 dark:focus:border-primary-500 dark:focus:ring-primary-500"
                                        placeholder="Votre prénom"
                                        required
                                    />
                                </div>
                                <div>
                                    <label for="nom" class="mb-2 block text-sm font-medium text-gray-900 dark:text-white">Nom *</label>
                                    <input
                                        type="text"
                                        id="nom"
                                        v-model="formData.nom"
                                        class="block w-full rounded-lg border border-gray-300 bg-gray-50 p-2.5 text-sm text-gray-900 focus:border-primary-500 focus:ring-primary-500 dark:border-gray-500 dark:bg-gray-600 dark:text-white dark:placeholder-gray-400 dark:focus:border-primary-500 dark:focus:ring-primary-500"
                                        placeholder="Votre nom"
                                        required
                                    />
                                </div>
                            </div>

                            <div>
                                <label for="email" class="mb-2 block text-sm font-medium text-gray-900 dark:text-white">Email</label>
                                <input
                                    type="email"
                                    id="email"
                                    v-model="formData.email"
                                    class="block w-full rounded-lg border border-gray-300 bg-gray-50 p-2.5 text-sm text-gray-900 focus:border-primary-500 focus:ring-primary-500 dark:border-gray-500 dark:bg-gray-600 dark:text-white dark:placeholder-gray-400 dark:focus:border-primary-500 dark:focus:ring-primary-500"
                                    placeholder="votre@email.com"
                                    required
                                />
                            </div>

                            <div>
                                <label for="telephone" class="mb-2 block text-sm font-medium text-gray-900 dark:text-white">Téléphone *</label>
                                <input
                                    type="tel"
                                    id="telephone"
                                    v-model="formData.telephone"
                                    class="block w-full rounded-lg border border-gray-300 bg-gray-50 p-2.5 text-sm text-gray-900 focus:border-primary-500 focus:ring-primary-500 dark:border-gray-500 dark:bg-gray-600 dark:text-white dark:placeholder-gray-400 dark:focus:border-primary-500 dark:focus:ring-primary-500"
                                    placeholder="+223 XX XX XX XX"
                                    required
                                />
                            </div>

                            <div>
                                <label for="adresse" class="mb-2 block text-sm font-medium text-gray-900 dark:text-white">Adresse</label>
                                <textarea
                                    id="adresse"
                                    v-model="formData.adresse"
                                    rows="2"
                                    class="block w-full rounded-lg border border-gray-300 bg-gray-50 p-2.5 text-sm text-gray-900 focus:border-primary-500 focus:ring-primary-500 dark:border-gray-500 dark:bg-gray-600 dark:text-white dark:placeholder-gray-400 dark:focus:border-primary-500 dark:focus:ring-primary-500"
                                    placeholder="Votre adresse complète"
                                ></textarea>
                            </div>

                            <div>
                                <label for="profession" class="mb-2 block text-sm font-medium text-gray-900 dark:text-white">Profession</label>
                                <input
                                    type="text"
                                    id="profession"
                                    v-model="formData.profession"
                                    class="block w-full rounded-lg border border-gray-300 bg-gray-50 p-2.5 text-sm text-gray-900 focus:border-primary-500 focus:ring-primary-500 dark:border-gray-500 dark:bg-gray-600 dark:text-white dark:placeholder-gray-400 dark:focus:border-primary-500 dark:focus:ring-primary-500"
                                    placeholder="Votre profession"
                                />
                            </div>
                        </div>

                        <button
                            type="submit"
                            class="inline-flex w-full items-center justify-center rounded-lg bg-primary-700 px-5 py-2.5 text-center text-sm font-medium text-white hover:bg-primary-800 focus:ring-4 focus:ring-primary-300 focus:outline-none dark:bg-primary-600 dark:hover:bg-primary-700 dark:focus:ring-primary-800"
                        >
                            <svg class="-ms-1 me-1 h-5 w-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                <path
                                    fill-rule="evenodd"
                                    d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                                    clip-rule="evenodd"
                                ></path>
                            </svg>
                            Soumettre ma pré-inscription
                        </button>

                        <p class="mt-3 text-xs text-gray-500 dark:text-gray-400">
                            * Champs obligatoires. Vous recevrez un email de confirmation pour finaliser votre inscription physique.
                        </p>
                    </form>
                </div>
            </div>
        </div>
    </ClientLayout>
</template>

<style scoped>
.prose {
    line-height: 1.6;
}

.prose p {
    margin-bottom: 1rem;
}

.sticky {
    position: sticky;
}
</style>
