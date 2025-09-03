
---

# 📘 Forma Plus

**Forma Plus** est une plateforme numérique de gestion de formations et de suivi, développée avec **Laravel**, **Inertia.js** et **Vue 3**.
Le projet propose un tableau de bord moderne, inspiré d’une **interface POS (point de vente)**, avec une navigation intuitive et un design cohérent basé sur le logo officiel de Forma Plus.

---

## 🚀 Fonctionnalités principales

* 🔑 **Authentification & Profil utilisateur**

  * Inscription, connexion, gestion du profil.
  * Attribution de rôles et permissions (Admin, Formateur, Étudiant…).

* 📚 **Gestion des formations**

  * CRUD complet (création, édition, suppression).
  * Attribution des formateurs aux sessions.
  * Suivi des apprenants.

* 👥 **Gestion des utilisateurs**

  * Création et édition des comptes.
  * Attribution dynamique de rôles et permissions.
  * Accès restreint selon le rôle (admin, chef, caissier, etc.).

* 💳 **Ventes & Paiements**

  * Interface **POS-like** pour enregistrer rapidement les ventes.
  * Prise en charge des **modes de paiement**.
  * Limitation des ventes selon la capacité disponible.

* 🎫 **Billetterie & QR Code**

  * Génération automatique de billets de train/formation avec **QR Code**.
  * Attribution de places (prise en compte des wagons/chaises).

* 📦 **Gestion des colis & bagages**

  * Catégorisation des colis.
  * Définition des prix au kilo (configurable dans les paramètres).

* 📊 **Tableau de bord & Rapports**

  * Vue d’ensemble des ventes et formations.
  * Export des ventes en **CSV/XLS** par mois.

* 🖌️ **UI & Design**

  * Intégration de **shadcn-vue** (Sidebar, TeamSwitcher, NavProjects, etc.).
  * Palette de couleurs basée sur le **logo Forma Plus** (Bleu & Doré).
  * Responsive, clair/sombre inclus.

---

## 🛠️ Stack technique

* **Backend :** [Laravel 11+](https://laravel.com)
* **Frontend :** [Vue 3](https://vuejs.org) + [Inertia.js](https://inertiajs.com)
* **UI :** [TailwindCSS](https://tailwindcss.com) + [shadcn-vue](https://shadcn-vue.com)
* **Base de données :** PostgreSQL
* **Gestion des rôles/permissions :** [spatie/laravel-permission](https://spatie.be/docs/laravel-permission)
* **QR Codes :** [Simple QrCode](https://github.com/SimpleSoftwareIO/simple-qrcode)

---

## 📂 Structure du projet

```
forma-plus/
├── app/            # Backend Laravel (contrôleurs, modèles, policies)
├── database/       # Migrations & seeders
├── resources/
│   ├── js/
│   │   ├── Pages/       # Vues Inertia (Vue 3)
│   │   ├── Components/  # Composants réutilisables
│   │   └── Layouts/     # Layouts globaux (AppLayout, Sidebar, etc.)
│   └── css/             # Styles Tailwind + thèmes personnalisés
├── routes/         # Routes Laravel
├── storage/        # Fichiers générés (QR Codes, exports…)
└── README.md
```

---

## ⚙️ Installation & configuration

### 1. Cloner le projet

```bash
git clone https://github.com/votre-repo/forma-plus.git
cd forma-plus
```

### 2. Installer les dépendances

```bash
composer install
npm install
```

### 3. Configurer l’environnement

Copier `.env.example` vers `.env` et ajuster :

```env
APP_NAME=FormaPlus
APP_URL=http://localhost:8000

DB_CONNECTION=pgsql
DB_HOST=127.0.0.1
DB_PORT=5432
DB_DATABASE=forma_plus
DB_USERNAME=postgres
DB_PASSWORD=secret
```

### 4. Générer la clé de l’application

```bash
php artisan key:generate
```

### 5. Lancer les migrations & seeders

```bash
php artisan migrate --seed
```

### 6. Compiler les assets

```bash
npm run dev
```

### 7. Lancer le serveur

```bash
php artisan serve
```

---

## 🎨 Thème & Personnalisation

* **Couleur principale (primary)** : `#3333ff` (bleu Forma Plus)
* **Accent (secondary/accent)** : `#f4b400` (doré Forma Plus)
* Mode clair/sombre supporté.
* Palette gérée dans `resources/css/theme.css`.

---

## 📌 Roadmap

* [x] Authentification & rôles
* [x] Gestion des formations
* [x] POS-like UI pour ventes
* [x] Génération de billets avec QR Code
* [ ] Notifications temps réel (WebSockets)
* [ ] Module de présence numérique (lié au projet Figma)

---

## 📜 Licence

Projet privé – Tous droits réservés © Forma Plus.

---

