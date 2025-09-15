-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : lun. 15 sep. 2025 à 11:57
-- Version du serveur : 8.0.43-0ubuntu0.22.04.1
-- Version de PHP : 8.3.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `formaplus`
--

-- --------------------------------------------------------

--
-- Structure de la table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `certificats`
--

CREATE TABLE `certificats` (
  `id` bigint UNSIGNED NOT NULL,
  `etudiant_id` bigint UNSIGNED NOT NULL,
  `issued_at` timestamp NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `etudiants`
--

CREATE TABLE `etudiants` (
  `id` bigint UNSIGNED NOT NULL,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prenom` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `adresse` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `profession` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telephone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `formation_id` bigint UNSIGNED DEFAULT NULL,
  `inscription_date` timestamp NULL DEFAULT '2025-09-09 11:20:40',
  `status` enum('En Cours','Validé','Rejété') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'En Cours',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `etudiants`
--

INSERT INTO `etudiants` (`id`, `nom`, `prenom`, `email`, `adresse`, `profession`, `telephone`, `formation_id`, `inscription_date`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Haïdara', 'El Hadj Abdoulaye Yoro', 'habdoulayeyor@gmail.com', 'Dialakorodji', 'Etudiant', '+22368747504', NULL, '2025-09-09 11:20:40', 'En Cours', '2025-09-10 16:49:26', '2025-09-10 16:49:26'),
(2, 'Touré', 'Moussa', 'moussa@gmail.com', 'Sébénikoro', 'Etudiant', '+22360221414', NULL, '2025-09-09 11:20:40', 'En Cours', '2025-09-10 16:59:25', '2025-09-10 16:59:25'),
(3, 'Haïdara', 'El', 'habdoulayeyor@gmail.com', 'Bamako', 'Etudiant', '+22368747504', NULL, '2025-09-09 11:20:40', 'En Cours', '2025-09-10 17:02:40', '2025-09-10 17:02:40'),
(4, 'Coulibaly', 'Idrissa', 'idi@gmail.com', 'Hippodrome II', 'Etudiant', '+22366371767', NULL, '2025-09-09 11:20:40', 'En Cours', '2025-09-15 10:43:26', '2025-09-15 10:43:26'),
(5, 'Sogodogo', 'Namissa', 'namissa0024@yahoo.ml', 'Sébénikoro', 'Pharmacienne', '+22385509321', 7, '2025-09-09 11:20:40', 'Validé', '2025-09-15 10:49:51', '2025-09-15 11:17:18');

-- --------------------------------------------------------

--
-- Structure de la table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `formations`
--

CREATE TABLE `formations` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo_formation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(8,2) DEFAULT NULL,
  `quota` int DEFAULT NULL,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `duration` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `formations`
--

INSERT INTO `formations` (`id`, `title`, `description`, `image`, `logo_formation`, `price`, `quota`, `location`, `duration`, `start_date`, `end_date`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'Bureautique', 'uyguysgbcigesugcuyguzqfu fduysvutfcvufèqfvdutfeutfcv utqtuzfcutfvzutfvdyutucfvut fstcffzouyo_yqfytfuzycvyuztf utfzvuyuyvzcuyvuzyvcueyvcu ijkqycvo_uyveo_zauiqvco_uy bco_cyg_zècgczeèefbccgvc', 'formations/MPLCjSIstmb0TwQuQtUDhFX0CjP5yPJKI93yOixa.png', 'icones_formation/leaNIYshYzKw2ERriv5dhOCH3cnIDH7ncEJBrrSr.png', '5000.00', 40, 'Bamako, IMM Wafa Simpara', '40', '2025-09-09', '2025-09-12', 5, '2025-09-09 11:36:14', '2025-09-09 11:40:10'),
(2, 'Python - Les bases', 'Un programme stratégique dédié aux métiers du multimédia. Il s’adresse aux jeunes passionnés par la conception visuelle, la communication digitale et la production de contenus riches en médias. Ce programme est gratuit et ouvert à tous les passionnés de multimédia.\r\n\r\nModules de formation\r\n\r\n§  Montage vidéo\r\n§  Design graphique\r\n§  Design d’interface Web\r\n§  Création d’animations graphiques\r\n\r\nBénéficiaires des formations\r\n\r\n§  Entrepreneurs\r\n§  Diplômés / non diplômés\r\n§  Passionnés du multimédia\r\n\r\nObjectifs du programme\r\n\r\n§  Apprentissage\r\n§  Projets pratiques\r\n§  Apprentissage pratiques\r\n§  Diversification des compétences', 'formations/RcxyCpQD1Xel2NI5AKHeffhI6BFVLLbsRJTyvLkK.png', 'icones_formation/MkBoQrxdmbonccfz9X3hYXY36VzMPrv1fbUHRDfG.png', '10000.00', 10, 'Bamako, IMM Wafa Simpara', '50', '2025-09-09', '2025-09-16', 5, '2025-09-09 12:14:19', '2025-09-09 12:14:19'),
(3, 'Bureatique', 'Un programme stratégique dédié aux métiers du multimédia. Il s’adresse aux jeunes passionnés par la conception visuelle, la communication digitale et la production de contenus riches en médias. Ce programme est gratuit et ouvert à tous les passionnés de multimédia.\r\n\r\nModules de formation\r\n\r\n§  Montage vidéo\r\n\r\n§  Design graphique\r\n\r\n§  Design d’interface Web\r\n\r\n§  Création d’animations graphiques\r\n\r\nBénéficiaires des formations\r\n\r\n§  Entrepreneurs\r\n\r\n§  Diplômés / non diplômés\r\n\r\n§  Passionnés du multimédia\r\n\r\nObjectifs du programme\r\n\r\n§  Apprentissage\r\n\r\n§  Projets pratiques\r\n\r\n§  Apprentissage pratiques\r\n\r\n§  Diversification des compétences', 'formations/6HrzTSWc3OsHT2Jvxd3jmXd6iwhxeovLwSc39VP5.jpg', 'icones_formation/5VTmIaYS2mS78Vcshiwc9NUAnNTTe3KwbXeb9QOv.jpg', '25000.00', 30, 'Manathan, USA', '80', '2025-09-10', '2025-09-20', 5, '2025-09-09 12:15:40', '2025-09-09 12:15:40'),
(4, 'Amazon Web Services (AWS)', 'Elle propose plus de 200 services complets issus de\r\n\r\ncentres de données du monde entier. Des millions de clients (dont certaines des\r\n\r\nstartups les plus dynamiques au monde, de très grandes entreprises et des agences\r\n\r\nfédérales de premier plan) utilisent AWS pour réduire leurs coûts, gagner en agilité et\r\n\r\ninnover plus rapidement.\r\n\r\nAWS re/Start est un programme gratuit de développement des compétences, qui se\r\n\r\ndéroule à temps plein sur 12 semaines à Orange Digital Center. Nous préparons et\r\n\r\naccompagnons les apprenants (les personnes sans emploi ou sous-employées) à\r\n\r\naccéder à des postes sans expérience ou entamé une carrière dans le secteur du\r\n\r\ncloud computing grâce au programme AWS re/Start ou encore mettre en relation les\r\n\r\nparticipants avec des employeurs potentiels.\r\n\r\nAmazon Web Services (AWS) et Orange Mali à travers Orange Digital Center\r\n\r\nMali travaillent en collaboration pour aider les participants à acquérir des\r\n\r\ncompétences techniques et professionnelles dans le cadre de ce programme.', 'formations/EfA0DHn3yy9IyFbs9qwch3BzPTldfY18ULvVkQBZ.png', 'icones_formation/EEQCVAqTFuUXw64CAwLrQwKYWgppZxZzJa435rdU.jpg', '25000.00', 25, 'Koulikor, Bibliothèque', '50', '2025-09-17', '2025-09-27', 5, '2025-09-09 12:18:16', '2025-09-09 12:18:16'),
(5, 'Excel avancé', 'Elle propose plus de 200 services complets issus de\r\n\r\ncentres de données du monde entier. Des millions de clients (dont certaines des\r\n\r\nstartups les plus dynamiques au monde, de très grandes entreprises et des agences\r\n\r\nfédérales de premier plan) utilisent AWS pour réduire leurs coûts, gagner en agilité et\r\n\r\ninnover plus rapidement.\r\n\r\nAWS re/Start est un programme gratuit de développement des compétences, qui se\r\n\r\ndéroule à temps plein sur 12 semaines à Orange Digital Center. Nous préparons et\r\n\r\naccompagnons les apprenants (les personnes sans emploi ou sous-employées) à\r\n\r\naccéder à des postes sans expérience ou entamé une carrière dans le secteur du\r\n\r\ncloud computing grâce au programme AWS re/Start ou encore mettre en relation les\r\n\r\nparticipants avec des employeurs potentiels.\r\n\r\nAmazon Web Services (AWS) et Orange Mali à travers Orange Digital Center\r\n\r\nMali travaillent en collaboration pour aider les participants à acquérir des\r\n\r\ncompétences techniques et professionnelles dans le cadre de ce programme.', 'formations/pcn6yTtdmqbSfMNcpVDCdLW2V0sbK1ihqulwX0X6.jpg', 'icones_formation/1IOwYVR8jzJGDHQ2M4VoZN2gfGzT3NAo1DrzghtC.png', '7500.00', 12, 'Monaco, Brazila', '30', '2025-09-09', '2025-10-09', 5, '2025-09-09 12:31:00', '2025-09-09 12:31:00'),
(6, 'Git & Github', 'Elle propose plus de 200 services complets issus de\r\n\r\ncentres de données du monde entier. Des millions de clients (dont certaines des\r\n\r\nstartups les plus dynamiques au monde, de très grandes entreprises et des agences\r\n\r\nfédérales de premier plan) utilisent AWS pour réduire leurs coûts, gagner en agilité et\r\n\r\ninnover plus rapidement.\r\n\r\nAWS re/Start est un programme gratuit de développement des compétences, qui se\r\n\r\ndéroule à temps plein sur 12 semaines à Orange Digital Center. Nous préparons et\r\n\r\naccompagnons les apprenants (les personnes sans emploi ou sous-employées) à\r\n\r\naccéder à des postes sans expérience ou entamé une carrière dans le secteur du\r\n\r\ncloud computing grâce au programme AWS re/Start ou encore mettre en relation les\r\n\r\nparticipants avec des employeurs potentiels.\r\n\r\nAmazon Web Services (AWS) et Orange Mali à travers Orange Digital Center\r\n\r\nMali travaillent en collaboration pour aider les participants à acquérir des\r\n\r\ncompétences techniques et professionnelles dans le cadre de ce programme.', 'formations/FrDqnzsTyfHqC6mLXcVl9tATBD33waOCz0JexYhw.jpg', 'icones_formation/v2GRamvysetHjBbCPnnKxoSjN5sNiznkM2XUEpYo.png', '39000.00', 10, 'Bamako - Mali', '40', '2025-09-09', '2025-09-18', 5, '2025-09-09 12:33:10', '2025-09-09 12:33:10'),
(7, 'Suite Adobe', 'Elle propose plus de 200 services complets issus de\r\n\r\ncentres de données du monde entier. Des millions de clients (dont certaines des\r\n\r\nstartups les plus dynamiques au monde, de très grandes entreprises et des agences\r\n\r\nfédérales de premier plan) utilisent AWS pour réduire leurs coûts, gagner en agilité et\r\n\r\ninnover plus rapidement.\r\n\r\nAWS re/Start est un programme gratuit de développement des compétences, qui se\r\n\r\ndéroule à temps plein sur 12 semaines à Orange Digital Center. Nous préparons et\r\n\r\naccompagnons les apprenants (les personnes sans emploi ou sous-employées) à\r\n\r\naccéder à des postes sans expérience ou entamé une carrière dans le secteur du\r\n\r\ncloud computing grâce au programme AWS re/Start ou encore mettre en relation les\r\n\r\nparticipants avec des employeurs potentiels.\r\n\r\nAmazon Web Services (AWS) et Orange Mali à travers Orange Digital Center\r\n\r\nMali travaillent en collaboration pour aider les participants à acquérir des\r\n\r\ncompétences techniques et professionnelles dans le cadre de ce programme.', 'formations/vLRIcneXUP1ivt7x2JKxWIXKJ8zg2g4QCeOZ4nR4.jpg', 'icones_formation/dt9iy9wReMtWXHXDfgnqVaZWiwjRsYxtiEw2i1m2.jpg', '5000.00', 20, 'Bamako, Mali', '30', '2025-09-09', '2025-09-16', 5, '2025-09-09 12:36:20', '2025-09-09 12:36:20');

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_08_30_003338_create_permission_tables', 1),
(5, '2025_08_30_011259_create_formations_table', 1),
(6, '2025_08_30_011321_create_etudiants_table', 1),
(7, '2025_08_30_011335_create_progressions_table', 1),
(8, '2025_08_30_011352_create_certificats_table', 1);

-- --------------------------------------------------------

--
-- Structure de la table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(1, 'App\\Models\\User', 2),
(1, 'App\\Models\\User', 3),
(1, 'App\\Models\\User', 4),
(2, 'App\\Models\\User', 5);

-- --------------------------------------------------------

--
-- Structure de la table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'viewAny role', 'web', '2025-09-09 11:20:54', '2025-09-09 11:20:54'),
(2, 'create role', 'web', '2025-09-09 11:20:54', '2025-09-09 11:20:54'),
(3, 'view role', 'web', '2025-09-09 11:20:54', '2025-09-09 11:20:54'),
(4, 'update role', 'web', '2025-09-09 11:20:54', '2025-09-09 11:20:54'),
(5, 'delete role', 'web', '2025-09-09 11:20:54', '2025-09-09 11:20:54'),
(6, 'authorize role', 'web', '2025-09-09 11:20:54', '2025-09-09 11:20:54'),
(7, 'authorizeForUser role', 'web', '2025-09-09 11:20:54', '2025-09-09 11:20:54'),
(8, 'authorizeResource role', 'web', '2025-09-09 11:20:54', '2025-09-09 11:20:54'),
(9, 'viewAny user', 'web', '2025-09-09 11:20:54', '2025-09-09 11:20:54'),
(10, 'create user', 'web', '2025-09-09 11:20:54', '2025-09-09 11:20:54'),
(11, 'view user', 'web', '2025-09-09 11:20:54', '2025-09-09 11:20:54'),
(12, 'update user', 'web', '2025-09-09 11:20:54', '2025-09-09 11:20:54'),
(13, 'delete user', 'web', '2025-09-09 11:20:54', '2025-09-09 11:20:54'),
(14, 'viewAny formation', 'web', '2025-09-09 11:20:54', '2025-09-09 11:20:54'),
(15, 'create formation', 'web', '2025-09-09 11:20:54', '2025-09-09 11:20:54'),
(16, 'view formation', 'web', '2025-09-09 11:20:54', '2025-09-09 11:20:54'),
(17, 'update formation', 'web', '2025-09-09 11:20:54', '2025-09-09 11:20:54'),
(18, 'delete formation', 'web', '2025-09-09 11:20:54', '2025-09-09 11:20:54'),
(19, 'viewAny etudiant', 'web', '2025-09-09 11:20:54', '2025-09-09 11:20:54'),
(20, 'create etudiant', 'web', '2025-09-09 11:20:54', '2025-09-09 11:20:54'),
(21, 'updateStatus etudiant', 'web', '2025-09-09 11:20:54', '2025-09-09 11:20:54'),
(22, 'view etudiant', 'web', '2025-09-09 11:20:54', '2025-09-09 11:20:54'),
(23, 'update etudiant', 'web', '2025-09-09 11:20:54', '2025-09-09 11:20:54'),
(24, 'delete etudiant', 'web', '2025-09-09 11:20:54', '2025-09-09 11:20:54');

-- --------------------------------------------------------

--
-- Structure de la table `progressions`
--

CREATE TABLE `progressions` (
  `id` bigint UNSIGNED NOT NULL,
  `etudiant_id` bigint UNSIGNED NOT NULL,
  `progress` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'web', '2025-09-09 11:21:03', '2025-09-09 11:21:03'),
(2, 'formateur', 'web', '2025-09-09 11:21:03', '2025-09-09 11:21:03');

-- --------------------------------------------------------

--
-- Structure de la table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1);

-- --------------------------------------------------------

--
-- Structure de la table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('eYFllkaOCDj7Uh8CCP3SOiAK75qTLfrNYyIbkJxd', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaEhiTGVDanJpdXA3UWNPVDZvejVmQ25oRjhVOGNxN1o1NkJNMHEwOSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjg6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9jb3Vyc2UiO319', 1757936822);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `email`, `email_verified_at`, `password`, `avatar`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Super Admin', 'admin', 'admin@doucsoft.com', '2025-09-09 11:21:04', '$2y$12$9Sojzxflx8gKrQ3KHeJMeO.lytxoLleTG0gTer5zPLOrcVnKMA4vq', NULL, 'txH12CR9fO1SvCuY93UrjPenXeJ3Vv472vbTdzYqAwPFgg9mdpTl2i76hL87', '2025-09-09 11:21:04', '2025-09-09 11:21:04'),
(2, 'Abdoulaye Y HAIDARA', 'abdoul', 'abdoulayeyoro.haidara@doucsoft.com', '2025-09-09 11:21:04', '$2y$12$mKkemUn.Ez4dvydxHRShKudTGWac5chLE3mXhWgUxHU6hHIhb0ONe', NULL, 'yYFswYmdRt', '2025-09-09 11:21:04', '2025-09-09 11:21:04'),
(3, 'Moussa DOUCOURE', 'doucsoft', 'moussdouc@doucsoft.tech', '2025-09-09 11:21:05', '$2y$12$BuC1bAlUHc4o/9jk0phSWOW.RX2q20nbxhtq3AJoBeapuWzglxnYm', NULL, 'cpH80i4DAK', '2025-09-09 11:21:05', '2025-09-09 11:21:05'),
(4, 'Malle MAGASSA', 'kizza', 'mallemagass@doucsoft.tech', '2025-09-09 11:21:05', '$2y$12$t5RuhwWwIvIjp99ClL3Z8OqL0MBJ.PvxUC7u8P2hSOFMmzu9xQXAa', NULL, 'H8Zz1P7QUO', '2025-09-09 11:21:05', '2025-09-09 11:21:05'),
(5, 'Abdoulaye KAGNASSY', 'kagnassy_abdoulaye', 'kagnassy@gmail.com', NULL, '$2y$12$d/O4UyBOJyew1JlKDKD5dOpvKkCJMg1ee8PEMfYp6IGgtFbaTWr7m', NULL, NULL, '2025-09-09 11:34:30', '2025-09-09 11:34:30');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Index pour la table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Index pour la table `certificats`
--
ALTER TABLE `certificats`
  ADD PRIMARY KEY (`id`),
  ADD KEY `certificats_etudiant_id_foreign` (`etudiant_id`);

--
-- Index pour la table `etudiants`
--
ALTER TABLE `etudiants`
  ADD PRIMARY KEY (`id`),
  ADD KEY `etudiants_formation_id_foreign` (`formation_id`);

--
-- Index pour la table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Index pour la table `formations`
--
ALTER TABLE `formations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `formations_user_id_foreign` (`user_id`);

--
-- Index pour la table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Index pour la table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Index pour la table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Index pour la table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Index pour la table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Index pour la table `progressions`
--
ALTER TABLE `progressions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `progressions_etudiant_id_foreign` (`etudiant_id`);

--
-- Index pour la table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Index pour la table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Index pour la table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `certificats`
--
ALTER TABLE `certificats`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `etudiants`
--
ALTER TABLE `etudiants`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `formations`
--
ALTER TABLE `formations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT pour la table `progressions`
--
ALTER TABLE `progressions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `certificats`
--
ALTER TABLE `certificats`
  ADD CONSTRAINT `certificats_etudiant_id_foreign` FOREIGN KEY (`etudiant_id`) REFERENCES `etudiants` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `etudiants`
--
ALTER TABLE `etudiants`
  ADD CONSTRAINT `etudiants_formation_id_foreign` FOREIGN KEY (`formation_id`) REFERENCES `formations` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `formations`
--
ALTER TABLE `formations`
  ADD CONSTRAINT `formations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `progressions`
--
ALTER TABLE `progressions`
  ADD CONSTRAINT `progressions_etudiant_id_foreign` FOREIGN KEY (`etudiant_id`) REFERENCES `etudiants` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
