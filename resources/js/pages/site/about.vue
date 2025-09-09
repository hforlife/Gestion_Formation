<script setup>
import { Link } from '@inertiajs/vue3';
import ClientLayout from '@/layouts/ClientLayout.vue';
</script>

<template>
    <ClientLayout>
        <!-- 🌐 NAVBAR + 🎯 HERO -->
    <div class="bg-white text-gray-800">

<!-- SECTION Description -->
<section class="bg-white dark:bg-gray-900">
  <div class="mx-auto max-w-screen-xl items-center gap-16 px-4 py-8 lg:grid lg:grid-cols-2 lg:px-6 lg:py-16">
    <!-- Texte -->
    <div class="font-light text-gray-500 sm:text-lg dark:text-gray-400">
      <h2 class="mb-6 text-4xl font-extrabold tracking-tight text-gray-900 dark:text-white">
        Forma Plus by Doucsoft
      </h2>
      <p class="mb-4">
        Bienvenue sur Forma Plus, votre partenaire privilégié pour la formation en présentiel et l’accompagnement numérique.
        DoucSoft est une entreprise de services numériques (ESN) basée au Mali, avec une ambition forte :
        se hisser parmi les leaders de la révolution digitale en Afrique.
      </p>
      <p class="mb-4">
        Nous sommes spécialisés dans le conseil, les services informatiques et la transformation numérique.
        Grâce à notre expertise dans les technologies modernes telles que le cloud, le digital et les plateformes,
        nous permettons à nos clients de se positionner en avant-garde du développement numérique.
      </p>
      <p>
        Conscients des défis technologiques du continent africain, nous concevons des outils et services innovants
        pour améliorer l’accès et l’utilisation des technologies de l’information à travers l’Afrique.
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
        Chez <span class="font-semibold text-primary-600">DoucSoft</span>, nous croyons au pouvoir des technologies pour transformer 
        la société africaine. À travers <span class="font-semibold">Forma Plus</span>, nous développons des compétences pratiques 
        et innovantes, adaptées aux besoins du marché et aux défis de la transformation digitale.
      </p>
      <p class="mb-6 font-light text-gray-500 md:text-lg dark:text-gray-400">
        Du conseil stratégique aux formations en présentiel, nous accompagnons particuliers et entreprises
        dans leur évolution vers un futur numérique durable et inclusif.
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





    </div>
    </ClientLayout>
</template>
