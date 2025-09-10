<script setup lang="ts">
import ClientLayout from '@/layouts/ClientLayout.vue';
import { send } from '@/routes/contact';
import { useForm } from '@inertiajs/vue3';
import Swal from 'sweetalert2';

// Formulaire avec useForm (Inertia)
const form = useForm({
    email: '',
    subject: '',
    message: '',
});

// Soumission
const submit = () => {
    form.post(send().url, {
        onSuccess: () => {
            form.reset();
            // Si Laravel envoie un flash success, on l’affiche
            onSuccess: () => {
                Swal.fire({
                    icon: 'success',
                    title: 'Message envoyé',
                    text: 'Message envoyé avec succès, nous vous répondrons dans les plus brefs délais.',
                    confirmButtonColor: '#2563eb', // bleu tailwind
                });
            };
        },
    });
};
</script>

<template>
    <ClientLayout>
        <section class="bg-white dark:bg-gray-900">
            <div class="mx-auto max-w-screen-md px-4 py-8 lg:py-16">
                <h2 class="mb-4 text-center text-4xl font-extrabold tracking-tight text-gray-900 dark:text-white">Contactez-nous</h2>
                <p class="mb-8 text-center font-light text-gray-500 sm:text-xl lg:mb-16 dark:text-gray-400">
                    Vous avez une question, un problème technique ou besoin d’informations ? Remplissez le formulaire ci-dessous.
                </p>

                <!-- FORM -->
                <form @submit.prevent="submit" class="space-y-8">
                    <!-- Email -->
                    <div>
                        <label for="email" class="mb-2 block text-sm font-medium text-gray-900 dark:text-gray-300"> Votre email </label>
                        <input
                            v-model="form.email"
                            type="email"
                            id="email"
                            class="block w-full rounded-lg border border-gray-300 bg-gray-50 p-2.5 text-sm text-gray-900 shadow-sm focus:border-primary-500 focus:ring-primary-500 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder-gray-400 dark:focus:border-primary-500 dark:focus:ring-primary-500"
                            placeholder="exemple@email.com"
                            required
                        />
                        <p v-if="form.errors.email" class="mt-1 text-sm text-red-600">
                            {{ form.errors.email }}
                        </p>
                    </div>

                    <!-- Sujet -->
                    <div>
                        <label for="subject" class="mb-2 block text-sm font-medium text-gray-900 dark:text-gray-300"> Sujet </label>
                        <input
                            v-model="form.subject"
                            type="text"
                            id="subject"
                            class="block w-full rounded-lg border border-gray-300 bg-gray-50 p-3 text-sm text-gray-900 shadow-sm focus:border-primary-500 focus:ring-primary-500 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder-gray-400 dark:focus:border-primary-500 dark:focus:ring-primary-500"
                            placeholder="Dites-nous comment nous pouvons vous aider"
                            required
                        />
                        <p v-if="form.errors.subject" class="mt-1 text-sm text-red-600">
                            {{ form.errors.subject }}
                        </p>
                    </div>

                    <!-- Message -->
                    <div>
                        <label for="message" class="mb-2 block text-sm font-medium text-gray-900 dark:text-gray-400"> Votre message </label>
                        <textarea
                            v-model="form.message"
                            id="message"
                            rows="6"
                            class="block w-full rounded-lg border border-gray-300 bg-gray-50 p-2.5 text-sm text-gray-900 shadow-sm focus:border-primary-500 focus:ring-primary-500 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder-gray-400 dark:focus:border-primary-500 dark:focus:ring-primary-500"
                            placeholder="Écrivez votre message..."
                            required
                        />
                        <p v-if="form.errors.message" class="mt-1 text-sm text-red-600">
                            {{ form.errors.message }}
                        </p>
                    </div>

                    <!-- Bouton -->
                    <button
                        type="submit"
                        :disabled="form.processing"
                        class="rounded-lg bg-primary-700 px-5 py-3 text-center text-sm font-medium text-white hover:bg-primary-800 focus:ring-4 focus:ring-primary-300 focus:outline-none disabled:opacity-50 sm:w-fit dark:bg-primary-600 dark:hover:bg-primary-700 dark:focus:ring-primary-800"
                    >
                        <span v-if="form.processing">Envoi...</span>
                        <span v-else>Envoyer le message</span>
                    </button>
                </form>
            </div>
        </section>
    </ClientLayout>
</template>
