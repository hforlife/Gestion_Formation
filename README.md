
---

# 📘 Forma Plus

**Forma Plus** est une plateforme numérique de gestion de formations et de suivi, développée avec **Laravel**, **Inertia.js** et **Vue 3**.
Le projet propose un tableau de bord moderne avec une navigation intuitive et un design cohérent basé sur le logo officiel de Forma Plus.

---

## 🚀 Fonctionnalités principales

* 🔑 **Authentification & Profil utilisateur**

  * Connexion, gestion du profil.
  * Attribution de rôles et permissions (Admin, Formateur, etc…).

* 📚 **Gestion des formations**

  * CRUD complet (création, édition, suppression).
  * Attribution des formateurs aux sessions.
  * Suivi des apprenants.
  * Définition des lieux et dates de formation.

* 👥 **Gestion des utilisateurs**

  * Création et édition des comptes.
  * Attribution dynamique de rôles et permissions.
  * Accès restreint selon le rôle (administrateur, formateur, apprenant…).

* 📊 **Tableau de bord **

  * Vue d’ensemble des formations en cours et à venir.

* 🖌️ **UI & Design**

  * Intégration de **shadcn-vue** (Sidebar, TeamSwitcher, NavProjects, etc.).
  * Palette de couleurs basée sur le **logo Forma Plus** (Bleu & Doré).
  * Responsive, clair/sombre inclus.

---

## 🛠️ Stack technique

* **Backend :** [Laravel 11+](https://laravel.com)
* **Frontend :** [Vue 3](https://vuejs.org) + [Inertia.js](https://inertiajs.com)
* **UI :** [TailwindCSS](https://tailwindcss.com) + [shadcn-vue](https://shadcn-vue.com)
* **Base de données :** MySQL
* **Gestion des rôles/permissions :** [spatie/laravel-permission](https://spatie.be/docs/laravel-permission)

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
git clone https://github.com/hforlife/Gestion_Formation.git
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

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=formaplus
DB_USERNAME=root
DB_PASSWORD=password
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
* [x] UI moderne pour inscriptions/paiements
* [ ] Notifications temps réel (WebSockets)
* [ ] Module de présence numérique (lié au projet Figma)
* [ ] Attestations de participation avec QR Code

---

## 📜 Licence

Projet privé – Tous droits réservés © Forma Plus.

---
