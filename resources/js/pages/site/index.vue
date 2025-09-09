<script setup lang="ts">
import ClientLayout from '@/layouts/ClientLayout.vue';
import { about, contact, course, home, detail } from '@/routes';
import { Link } from '@inertiajs/vue3';

const props = defineProps<{
  formations: Array<{
    id: number;
    title: string;
    description: string;
    prix: number;
    image?: string;
    logo_formation?: string;
  }>;
}>();
</script>


<template>
    <ClientLayout>
        <!-- 🌐 NAVBAR + 🎯 HERO -->
        <div class="bg-white text-gray-800">
            <!-- 🎯 HERO -->
            <section class="bg-white dark:bg-gray-900">
                <div class="mx-auto max-w-screen-xl px-4 py-12 text-center lg:px-12 lg:py-20">
                    <!-- Badge -->
                    <a
                        href="#"
                        class="mb-7 inline-flex items-center justify-between rounded-full bg-gray-100 px-1 py-1 pr-4 text-sm text-gray-700 hover:bg-gray-200 dark:bg-gray-800 dark:text-white dark:hover:bg-gray-700"
                        role="alert"
                    >
                        <span class="mr-3 rounded-full bg-primary-600 px-4 py-1.5 text-xs text-white">Forma Plus</span>
                        <span class="text-sm font-medium">by Doucsoft — Votre partenaire numérique</span>
                    </a>

                    <!-- Titre -->
                    <h1 class="mb-6 text-4xl leading-tight font-extrabold tracking-tight text-gray-900 md:text-5xl lg:text-6xl dark:text-white">
                        Bienvenue sur <span class="text-primary-600">Forma Plus</span>
                    </h1>

                    <!-- Sous-texte -->
                    <p class="mb-8 text-lg font-normal text-gray-600 sm:px-16 lg:text-xl xl:px-48 dark:text-gray-400">
                        Votre partenaire privilégié pour la formation en présentiel et l’accompagnement numérique. DoucSoft, entreprise de services
                        numériques basée au Mali, ambitionne de se hisser parmi les leaders de la révolution digitale en Afrique.
                    </p>

                    <!-- CTA -->
                    <div class="mb-10 flex flex-col space-y-4 sm:flex-row sm:justify-center sm:space-y-0 sm:space-x-4">
                        <Link
                                    :href="course.url()"
                            class="inline-flex items-center justify-center rounded-lg bg-primary-700 px-6 py-3 text-center text-base font-medium text-white hover:bg-primary-800 focus:ring-4 focus:ring-primary-300 dark:focus:ring-primary-900"
                        >
                            Découvrir nos formations
                            <svg class="-mr-1 ml-2 h-5 w-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                <path
                                    fill-rule="evenodd"
                                    d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z"
                                    clip-rule="evenodd"
                                ></path>
                            </svg>
                        </Link>
                        <Link
                                    :href="about.url()"
                            class="inline-flex items-center justify-center rounded-lg border border-gray-300 px-6 py-3 text-center text-base font-medium text-gray-900 hover:bg-gray-100 focus:ring-4 focus:ring-gray-100 dark:border-gray-700 dark:text-white dark:hover:bg-gray-700 dark:focus:ring-gray-800"
                        >
                            En savoir plus
                    </Link>
                    </div>
                </div>
            </section>

            <!-- SECTION Description -->
            <section class="bg-gray-50 py-8 antialiased md:py-12 dark:bg-gray-900">
                <div class="mx-auto max-w-screen-xl items-center gap-16 px-4 py-8 lg:grid lg:grid-cols-2 lg:px-6 lg:py-16">
                    <!-- Texte -->
                    <div class="font-light text-gray-500 sm:text-lg dark:text-gray-400">
                        <h2 class="mb-6 text-4xl font-extrabold tracking-tight text-gray-900 dark:text-white">Forma Plus by Doucsoft</h2>
                        <p class="mb-4">
                            Bienvenue sur Forma Plus, votre partenaire privilégié pour la formation en présentiel et l’accompagnement numérique.
                            DoucSoft est une entreprise de services numériques (ESN) basée au Mali, avec une ambition forte : se hisser parmi les
                            leaders de la révolution digitale en Afrique.
                        </p>
                        <p class="mb-4">
                            Nous sommes spécialisés dans le conseil, les services informatiques et la transformation numérique. Grâce à notre
                            expertise dans les technologies modernes telles que le cloud, le digital et les plateformes, nous permettons à nos clients
                            de se positionner en avant-garde du développement numérique.
                        </p>
                        <p>
                            Conscients des défis technologiques du continent africain, nous concevons des outils et services innovants pour améliorer
                            l’accès et l’utilisation des technologies de l’information à travers l’Afrique.
                        </p>
                    </div>

                    <!-- Images -->
                    <div class="mt-8 grid grid-cols-2 gap-4">
                        <img
                            class="w-full rounded-lg shadow"
                            src="https://flowbite.s3.amazonaws.com/blocks/marketing-ui/content/office-long-2.png"
                            alt="Formation en présentiel"
                        />
                        <img
                            class="mt-4 w-full rounded-lg shadow lg:mt-10"
                            src="https://flowbite.s3.amazonaws.com/blocks/marketing-ui/content/office-long-1.png"
                            alt="Accompagnement numérique"
                        />
                    </div>
                </div>
            </section>

            <!-- SECTION Description 2 -->
            <section class="bg-white dark:bg-gray-900">
                <div class="mx-auto max-w-screen-xl items-center gap-8 px-4 py-8 sm:py-16 md:grid md:grid-cols-2 lg:px-6 xl:gap-16">
                    <!-- Image -->
                    <img
                        class="w-full dark:hidden"
                        src="https://flowbite.s3.amazonaws.com/blocks/marketing-ui/cta/cta-dashboard-mockup.svg"
                        alt="Transformation numérique"
                    />
                    <img
                        class="hidden w-full dark:block"
                        src="https://flowbite.s3.amazonaws.com/blocks/marketing-ui/cta/cta-dashboard-mockup-dark.svg"
                        alt="Transformation numérique dark"
                    />

                    <!-- Texte -->
                    <div class="mt-4 md:mt-0">
                        <h2 class="mb-4 text-4xl font-extrabold tracking-tight text-gray-900 dark:text-white">
                            Des solutions numériques pour l’Afrique de demain
                        </h2>
                        <p class="mb-6 font-light text-gray-500 md:text-lg dark:text-gray-400">
                            Chez <span class="font-semibold text-primary-600">DoucSoft</span>, nous croyons au pouvoir des technologies pour
                            transformer la société africaine. À travers <span class="font-semibold">Forma Plus</span>, nous développons des
                            compétences pratiques et innovantes, adaptées aux besoins du marché et aux défis de la transformation digitale.
                        </p>
                        <p class="mb-6 font-light text-gray-500 md:text-lg dark:text-gray-400">
                            Du conseil stratégique aux formations en présentiel, nous accompagnons particuliers et entreprises dans leur évolution
                            vers un futur numérique durable et inclusif.
                        </p>

                        <!-- CTA -->
                        <a
                            href="/about"
                            class="inline-flex items-center rounded-lg bg-primary-700 px-5 py-2.5 text-center text-sm font-medium text-white hover:bg-primary-800 focus:ring-4 focus:ring-primary-300 dark:focus:ring-primary-900"
                        >
                            En savoir plus
                            <svg class="-mr-1 ml-2 h-5 w-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                <path
                                    fill-rule="evenodd"
                                    d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z"
                                    clip-rule="evenodd"
                                ></path>
                            </svg>
                        </a>
                    </div>
                </div>
            </section>

<!-- SECTION Dernières Formations -->
<section class="bg-gray-50 py-8 antialiased md:py-12 dark:bg-gray-900">
  <div class="mx-auto max-w-screen-xl px-4 2xl:px-0">
    <!-- Heading -->
    <div class="mb-8 text-center">
      <h2 class="text-2xl font-extrabold text-gray-900 sm:text-3xl dark:text-white">
        Nos dernières formations
      </h2>
      <p class="mt-2 text-gray-500 dark:text-gray-400">
        Découvrez les 6 dernières formations ajoutées sur Forma Plus.
      </p>
    </div>

    <!-- Grid formations -->
    <div class="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
      <div
        v-for="formation in props.formations"
        :key="formation.id"
        class="rounded-lg border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-800"
      >
        <!-- Image -->
        <div class="h-48 w-full overflow-hidden rounded-t-lg">
          <img
            :src="formation.logo_formation 
              ? `/storage/${formation.logo_formation}` 
              : '/images/default.png'"
            :alt="formation.title"
            class="h-full w-full object-cover"
          />
        </div>

        <!-- Infos -->
        <div class="p-5">
          <h3 class="mb-2 text-lg font-semibold text-gray-900 dark:text-white">
            {{ formation.title }}
          </h3>
          <p class="mb-4 text-sm text-gray-700 dark:text-gray-400">
            {{ formation.description }}
          </p>
          <p class="mb-4 text-xl font-bold text-primary-600">
            {{ formation.prix }} FCFA
          </p>

          <!-- Bouton -->
          <Link
            :href="detail.url()"
            class="inline-flex w-full items-center justify-center rounded-lg bg-primary-700 px-4 py-2 text-sm font-medium text-white hover:bg-primary-800 focus:ring-4 focus:ring-primary-300 focus:outline-none dark:bg-primary-600 dark:hover:bg-primary-700 dark:focus:ring-primary-800"
          >
            Voir les détails
          </Link>
        </div>
      </div>
    </div>
  </div>
</section>



            <!-- 📩 CTA -->
            <section class="bg-white dark:bg-gray-900">
                <div class="mx-auto max-w-screen-xl px-4 py-8 sm:py-16 lg:px-6">
                    <!-- Titre -->
                    <div class="mb-8 max-w-screen-md lg:mb-16">
                        <h2 class="mb-4 text-4xl font-extrabold tracking-tight text-gray-900 dark:text-white">Nos domaines d’expertise</h2>
                        <p class="text-gray-500 sm:text-xl dark:text-gray-400">
                            Avec <span class="font-semibold text-primary-600">Forma Plus by Doucsoft</span>, nous allions formation, conseil et
                            innovation pour bâtir une Afrique numérique plus compétitive et inclusive.
                        </p>
                    </div>

                    <!-- Grille -->
                    <div class="space-y-8 md:grid md:grid-cols-2 md:gap-12 md:space-y-0 lg:grid-cols-3">
                        <!-- Formation -->
                        <div>
                            <div class="mb-4 flex h-12 w-12 items-center justify-center rounded-full bg-primary-100 dark:bg-primary-900">
                                <svg class="h-6 w-6 text-primary-600 dark:text-primary-300" fill="currentColor" viewBox="0 0 20 20">
                                    <path d="M10 2L2 6l8 4 8-4-8-4zm0 7l-8-4v9a1 1 0 001 1h14a1 1 0 001-1V5l-8 4z"></path>
                                </svg>
                            </div>
                            <h3 class="mb-2 text-xl font-bold dark:text-white">Formation</h3>
                            <p class="text-gray-500 dark:text-gray-400">
                                Développez vos compétences grâce à nos formations en présentiel et en ligne, adaptées aux besoins du marché.
                            </p>
                        </div>

                        <!-- Conseil & Services IT -->
                        <div>
                            <div class="mb-4 flex h-12 w-12 items-center justify-center rounded-full bg-primary-100 dark:bg-primary-900">
                                <svg class="h-6 w-6 text-primary-600 dark:text-primary-300" fill="currentColor" viewBox="0 0 20 20">
                                    <path
                                        fill-rule="evenodd"
                                        d="M18 13a1 1 0 01-1 1h-1v3a1 1 0 01-1 1H5a1 1 0 01-1-1v-3H3a1 1 0 01-1-1V7a1 1 0 011-1h1V3a1 1 0 011-1h10a1 1 0 011 1v3h1a1 1 0 011 1v6z"
                                        clip-rule="evenodd"
                                    ></path>
                                </svg>
                            </div>
                            <h3 class="mb-2 text-xl font-bold dark:text-white">Conseil & Services IT</h3>
                            <p class="text-gray-500 dark:text-gray-400">
                                Nous accompagnons les entreprises dans la mise en place de solutions numériques performantes et sécurisées.
                            </p>
                        </div>

                        <!-- Transformation numérique -->
                        <div>
                            <div class="mb-4 flex h-12 w-12 items-center justify-center rounded-full bg-primary-100 dark:bg-primary-900">
                                <svg class="h-6 w-6 text-primary-600 dark:text-primary-300" fill="currentColor" viewBox="0 0 20 20">
                                    <path
                                        fill-rule="evenodd"
                                        d="M4 3a1 1 0 00-1 1v2a1 1 0 001 1h1v2H4a1 1 0 000 2h1v2H4a1 1 0 000 2h1v2a1 1 0 001 1h2a1 1 0 001-1v-1h2v1a1 1 0 001 1h2a1 1 0 001-1v-2h1a1 1 0 000-2h-1v-2h1a1 1 0 000-2h-1V7h1a1 1 0 000-2h-1V4a1 1 0 00-1-1h-2a1 1 0 00-1 1v1H9V4a1 1 0 00-1-1H6a1 1 0 00-1 1v2H4z"
                                        clip-rule="evenodd"
                                    ></path>
                                </svg>
                            </div>
                            <h3 class="mb-2 text-xl font-bold dark:text-white">Transformation numérique</h3>
                            <p class="text-gray-500 dark:text-gray-400">
                                Migration vers le cloud, digitalisation des processus et adoption de plateformes modernes.
                            </p>
                        </div>

                        <!-- Innovation africaine -->
                        <div>
                            <div class="mb-4 flex h-12 w-12 items-center justify-center rounded-full bg-primary-100 dark:bg-primary-900">
                                <svg class="h-6 w-6 text-primary-600 dark:text-primary-300" fill="currentColor" viewBox="0 0 20 20">
                                    <path d="M10 2a8 8 0 100 16 8 8 0 000-16zm1 8H9V5h2v5zm0 2H9v2h2v-2z"></path>
                                </svg>
                            </div>
                            <h3 class="mb-2 text-xl font-bold dark:text-white">Innovation africaine</h3>
                            <p class="text-gray-500 dark:text-gray-400">
                                Des solutions pensées pour les réalités africaines, afin de relever les défis locaux par la technologie.
                            </p>
                        </div>

                        <!-- Accessibilité -->
                        <div>
                            <div class="mb-4 flex h-12 w-12 items-center justify-center rounded-full bg-primary-100 dark:bg-primary-900">
                                <svg class="h-6 w-6 text-primary-600 dark:text-primary-300" fill="currentColor" viewBox="0 0 20 20">
                                    <path
                                        fill-rule="evenodd"
                                        d="M18 10A8 8 0 112 10a8 8 0 0116 0zm-8-3a1 1 0 00-.867.5L8 10H6a1 1 0 000 2h2.382l1.724 2.447a1 1 0 001.732-1.094L10.618 12H12a1 1 0 000-2h-1.382l-1.105-1.553A1 1 0 0010 7z"
                                        clip-rule="evenodd"
                                    ></path>
                                </svg>
                            </div>
                            <h3 class="mb-2 text-xl font-bold dark:text-white">Accessibilité</h3>
                            <p class="text-gray-500 dark:text-gray-400">
                                Nous œuvrons pour démocratiser l’accès aux technologies de l’information à travers l’Afrique.
                            </p>
                        </div>

                        <!-- Développement durable -->
                        <div>
                            <div class="mb-4 flex h-12 w-12 items-center justify-center rounded-full bg-primary-100 dark:bg-primary-900">
                                <svg class="h-6 w-6 text-primary-600 dark:text-primary-300" fill="currentColor" viewBox="0 0 20 20">
                                    <path
                                        fill-rule="evenodd"
                                        d="M4 2a1 1 0 00-1 1v4c0 5.523 4.477 10 10 10h4a1 1 0 001-1v-4c0-5.523-4.477-10-10-10H4zm6 2a8 8 0 018 8h-2a6 6 0 00-6-6V4z"
                                        clip-rule="evenodd"
                                    ></path>
                                </svg>
                            </div>
                            <h3 class="mb-2 text-xl font-bold dark:text-white">Développement durable</h3>
                            <p class="text-gray-500 dark:text-gray-400">
                                Nos solutions s’inscrivent dans une vision de croissance inclusive, durable et respectueuse des communautés.
                            </p>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </ClientLayout>
</template>
