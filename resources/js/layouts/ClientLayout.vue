<script setup>
import { about, contact, course, home, login } from '@/routes';
import { Link } from '@inertiajs/vue3';
</script>

<template>
    <div class="bg-white text-gray-800">
        <!-- 🌐 NAVBAR -->
        <header>
            <nav class="border-gray-200 bg-white px-4 py-2.5 lg:px-6 dark:bg-gray-800">
                <div class="mx-auto flex max-w-screen-xl flex-wrap items-center justify-between">
                    <Link :href="home.url()" class="flex items-center">
                        <img src="asset/img/logo_formaplus.png" class="mr-3 h-6 sm:h-9" alt="Forma Plus Logo" />
                        <span class="self-center text-xl font-semibold whitespace-nowrap dark:text-white">Forma Plus</span>
                    </Link>
                    <div class="flex items-center lg:order-2">
                        <Link
                            :href="contact.url()"
                            class="mr-2 rounded-lg px-4 py-2 text-sm font-medium text-gray-800 hover:bg-gray-50 focus:ring-4 focus:ring-gray-300 focus:outline-none lg:px-5 lg:py-2.5 dark:text-white dark:hover:bg-gray-700 dark:focus:ring-gray-800"
                            >Contact</Link
                        >
                        <Link
                            :href="course.url()"
                            class="mr-2 rounded-lg bg-primary-700 px-4 py-2 text-sm font-medium text-white hover:bg-primary-800 focus:ring-4 focus:ring-primary-300 focus:outline-none lg:px-5 lg:py-2.5 dark:bg-primary-600 dark:hover:bg-primary-700 dark:focus:ring-primary-800"
                            >Commencer</Link
                        >
                        <button
                            data-collapse-toggle="mobile-menu-2"
                            type="button"
                            class="ml-1 inline-flex items-center rounded-lg p-2 text-sm text-gray-500 hover:bg-gray-100 focus:ring-2 focus:ring-gray-200 focus:outline-none lg:hidden dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600"
                            aria-controls="mobile-menu-2"
                            aria-expanded="false"
                        >
                            <span class="sr-only">Open main menu</span>
                            <svg class="h-6 w-6" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                <path
                                    fill-rule="evenodd"
                                    d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z"
                                    clip-rule="evenodd"
                                ></path>
                            </svg>
                            <svg class="hidden h-6 w-6" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                <path
                                    fill-rule="evenodd"
                                    d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                                    clip-rule="evenodd"
                                ></path>
                            </svg>
                        </button>
                    </div>
                    <div class="hidden w-full items-center justify-between lg:order-1 lg:flex lg:w-auto" id="mobile-menu-2">
                        <ul class="mt-4 flex flex-col font-medium lg:mt-0 lg:flex-row lg:space-x-8">
                            <li>
                                <Link
                                    :href="home.url()"
                                    class="block rounded bg-primary-700 py-2 pr-4 pl-3 text-white lg:bg-transparent lg:p-0 lg:text-primary-700 dark:text-white"
                                    aria-current="page"
                                    >Accueil</Link
                                >
                            </li>
                            <li>
                                <Link
                                href="#"
                                class="block border-b border-gray-100 py-2 pr-4 pl-3 text-gray-700 hover:bg-gray-50 lg:border-0 lg:p-0 lg:hover:bg-transparent lg:hover:text-primary-700 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white lg:dark:hover:bg-transparent lg:dark:hover:text-white"
                                >Nos Formations</Link
                                >
                            </li>
                            <li>
                                <Link
                                    :href="about.url()"
                                    class="block border-b border-gray-100 py-2 pr-4 pl-3 text-gray-700 hover:bg-gray-50 lg:border-0 lg:p-0 lg:hover:bg-transparent lg:hover:text-primary-700 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white lg:dark:hover:bg-transparent lg:dark:hover:text-white"
                                    >A Propos</Link
                                >
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>

        <main>
            <slot></slot>
        </main>

        <!-- 🔻 FOOTER -->
        <footer class="bg-white p-4 sm:p-6 dark:bg-gray-800">
            <div class="mx-auto max-w-screen-xl">
                <div class="md:flex md:justify-between">
                    <!-- Logo -->
                    <div class="mb-6 md:mb-0">
                        <Link :href="home.url()" class="flex items-center">
                            <img src="/asset/img/logo_formaplus.png" class="mr-3 h-10" alt="Forma Plus Logo" />
                            <span class="self-center text-2xl font-bold whitespace-nowrap dark:text-white">Forma Plus</span>
                        </Link>
                        <p class="mt-4 max-w-xs text-sm text-gray-600 dark:text-gray-400">
                            Forma Plus by Doucsoft — Votre partenaire privilégié pour la formation et la transformation numérique en Afrique.
                        </p>
                    </div>

                    <!-- Liens -->
                    <div class="grid grid-cols-2 gap-8 sm:grid-cols-3 sm:gap-6">
                        <div>
                            <h2 class="mb-6 text-sm font-semibold text-gray-900 uppercase dark:text-white">Navigation</h2>
                            <ul class="text-gray-600 dark:text-gray-400">
                                <li class="mb-4"><Link href="/about" class="hover:underline">À propos</Link></li>
                                <li class="mb-4"><Link href="/courses" class="hover:underline">Formations</Link></li>
                                <li><Link href="/contact" class="hover:underline">Contact</Link></li>
                            </ul>
                        </div>

                        <div>
                            <h2 class="mb-6 text-sm font-semibold text-gray-900 uppercase dark:text-white">Ressources</h2>
                            <ul class="text-gray-600 dark:text-gray-400">
                                <li class="mb-4"><a href="https://tailwindcss.com/" target="_blank" class="hover:underline">Tailwind CSS</a></li>
                                <li><a href="https://flowbite.com" target="_blank" class="hover:underline">Flowbite</a></li>
                            </ul>
                        </div>

                        <div>
                            <h2 class="mb-6 text-sm font-semibold text-gray-900 uppercase dark:text-white">Légal</h2>
                            <ul class="text-gray-600 dark:text-gray-400">
                                <li class="mb-4"><Link href="/privacy" class="hover:underline">Politique de confidentialité</Link></li>
                                <li><Link href="/terms" class="hover:underline">Conditions d’utilisation</Link></li>
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- Separator -->
                <hr class="my-6 border-gray-200 sm:mx-auto lg:my-8 dark:border-gray-700" />

                <!-- Bottom -->
                <div class="sm:flex sm:items-center sm:justify-between">
                    <span class="text-sm text-gray-500 sm:text-center dark:text-gray-400">
                        © 2025 <span class="font-semibold">Forma Plus by Doucsoft</span>. Tous droits réservés.
                    </span>

                    <!-- Social links -->
                    <div class="mt-4 flex space-x-6 sm:mt-0 sm:justify-center">
                        <a href="https://facebook.com" target="_blank" class="text-gray-500 hover:text-gray-900 dark:hover:text-white">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a href="https://twitter.com" target="_blank" class="text-gray-500 hover:text-gray-900 dark:hover:text-white">
                            <i class="fab fa-twitter"></i>
                        </a>
                        <a href="https://linkedin.com" target="_blank" class="text-gray-500 hover:text-gray-900 dark:hover:text-white">
                            <i class="fab fa-linkedin-in"></i>
                        </a>
                        <a href="https://github.com" target="_blank" class="text-gray-500 hover:text-gray-900 dark:hover:text-white">
                            <i class="fab fa-github"></i>
                        </a>
                    </div>
                </div>
            </div>
        </footer>
    </div>
</template>
