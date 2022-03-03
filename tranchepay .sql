-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : ven. 25 fév. 2022 à 19:41
-- Version du serveur : 10.4.22-MariaDB
-- Version de PHP : 8.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `tranchepay`
--

-- --------------------------------------------------------

--
-- Structure de la table `admins`
--

CREATE TABLE `admins` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenoms` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telephone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `aides`
--

CREATE TABLE `aides` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `boutiques`
--

CREATE TABLE `boutiques` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `addresse` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `commercant_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `boutiques`
--

INSERT INTO `boutiques` (`id`, `nom`, `addresse`, `commercant_id`, `created_at`, `updated_at`) VALUES
('8708a09d-7f26-4e31-a60e-3fe7d618e852', 'Biba Shop', 'Thies, Arafat', '25d5c643-4f2a-4311-bb11-db503af4abb2', '2022-02-15 23:12:13', '2022-02-15 23:12:13');

-- --------------------------------------------------------

--
-- Structure de la table `boutique_has_categories`
--

CREATE TABLE `boutique_has_categories` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `boutique_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `categorie_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE `categories` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

CREATE TABLE `clients` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenoms` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telephone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `adresse` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deplafonner` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `clients`
--

INSERT INTO `clients` (`id`, `prenoms`, `nom`, `telephone`, `adresse`, `image_path`, `deplafonner`, `created_at`, `updated_at`) VALUES
('6587d2ba-a03b-4d3a-807e-1f4f293412b9', 'Jean', 'Sané', '704779065', NULL, NULL, 0, '2022-02-24 17:22:27', '2022-02-24 17:22:27'),
('fcc164f1-af9e-486e-8be3-da4875387069', 'Mor', 'Diaw', '781879981', NULL, NULL, 0, '2022-02-15 20:29:32', '2022-02-15 20:29:32');

-- --------------------------------------------------------

--
-- Structure de la table `commandes`
--

CREATE TABLE `commandes` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prix_total` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nb_produits` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `interet` float UNSIGNED NOT NULL DEFAULT 0,
  `nb_tranche` int(10) UNSIGNED NOT NULL DEFAULT 3,
  `date_time` datetime NOT NULL DEFAULT '2022-02-15 20:29:04',
  `date_limite` date NOT NULL,
  `commission` double NOT NULL DEFAULT 0,
  `boutique_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `etat_commande_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `commandes`
--

INSERT INTO `commandes` (`id`, `reference`, `prix_total`, `nb_produits`, `interet`, `nb_tranche`, `date_time`, `date_limite`, `commission`, `boutique_id`, `client_id`, `etat_commande_id`, `created_at`, `updated_at`) VALUES
('3cfc3940-3806-49e5-b885-997db3f5b3e7', '15648433223', '195000', 1, 0.3, 1, '2022-02-19 15:00:08', '2022-03-19', 45000, '8708a09d-7f26-4e31-a60e-3fe7d618e852', 'fcc164f1-af9e-486e-8be3-da4875387069', '2', '2022-02-19 15:00:08', '2022-02-19 15:00:08'),
('b3edcf86-7d0f-4ec6-8ff0-53040fca232e', '21547820225', '200000', 1, 0.1, 3, '2022-02-15 23:19:08', '2022-05-15', 20000, '8708a09d-7f26-4e31-a60e-3fe7d618e852', 'fcc164f1-af9e-486e-8be3-da4875387069', '3', '2022-02-15 23:19:08', '2022-02-15 23:19:08');

-- --------------------------------------------------------

--
-- Structure de la table `commercants`
--

CREATE TABLE `commercants` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenoms` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telephone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `adresse` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `commercants`
--

INSERT INTO `commercants` (`id`, `prenoms`, `nom`, `telephone`, `adresse`, `image_path`, `created_at`, `updated_at`) VALUES
('25d5c643-4f2a-4311-bb11-db503af4abb2', 'Mame Bassine', 'Kane', '763978322', 'Thies, Arafat', NULL, '2022-02-15 23:12:13', '2022-02-15 23:12:13');

-- --------------------------------------------------------

--
-- Structure de la table `comptes`
--

CREATE TABLE `comptes` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `solde` double NOT NULL DEFAULT 0,
  `boutique_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `comptes`
--

INSERT INTO `comptes` (`id`, `solde`, `boutique_id`, `created_at`, `updated_at`) VALUES
('a6f00c46-1dd0-416f-a5d3-ea4bbc96188b', 275000, '8708a09d-7f26-4e31-a60e-3fe7d618e852', '2022-02-15 23:12:13', '2022-02-19 15:00:08');

-- --------------------------------------------------------

--
-- Structure de la table `etat_commandes`
--

CREATE TABLE `etat_commandes` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `etat_commandes`
--

INSERT INTO `etat_commandes` (`id`, `nom`, `created_at`, `updated_at`) VALUES
('1', 'append', '2022-02-01 21:20:15', '2022-02-01 21:20:15'),
('2', 'load', '2022-02-01 21:20:15', '2022-02-01 21:20:15'),
('3', 'finish', '2022-02-01 21:20:53', '2022-02-01 21:20:53');

-- --------------------------------------------------------

--
-- Structure de la table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(51, '2014_10_12_100000_create_password_resets_table', 1),
(52, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
(53, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
(54, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
(55, '2016_06_01_000004_create_oauth_clients_table', 1),
(56, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
(57, '2019_08_19_000000_create_failed_jobs_table', 1),
(58, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(59, '2022_01_01_011756_create_commercants_table', 1),
(60, '2022_01_01_011807_create_clients_table', 1),
(61, '2022_01_01_011839_create_admins_table', 1),
(62, '2022_01_01_011840_create_users_table', 1),
(63, '2022_01_01_011854_create_boutiques_table', 1),
(64, '2022_01_01_011916_create_categories_table', 1),
(65, '2022_01_01_011952_create_boutique_has_categories_table', 1),
(66, '2022_01_01_012055_create_commandes_table', 1),
(67, '2022_01_01_012110_create_produits_table', 1),
(68, '2022_01_01_012119_create_versements_table', 1),
(69, '2022_01_01_013210_create_aides_table', 1),
(70, '2022_01_01_013233_create_paddings_table', 1),
(71, '2022_01_01_154135_create_params_table', 1),
(72, '2022_01_04_155555_create_etat_commandes_table', 1),
(73, '2022_01_14_114803_create_comptes_table', 1),
(74, '2022_01_14_161033_create_retraits_table', 1),
(75, '2022_02_01_131026_create_partenaires_table', 1),
(76, '2022_02_19_094812_add_reference_column', 2),
(79, '2022_02_19_100511_create_mode_payement_table', 3);

-- --------------------------------------------------------

--
-- Structure de la table `mode_payement`
--

CREATE TABLE `mode_payement` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `interet` double NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nb_mois` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `mode_payement`
--

INSERT INTO `mode_payement` (`id`, `interet`, `label`, `nb_mois`, `created_at`, `updated_at`) VALUES
('c3edcf86-7d0f-9ec6-8ff0-53040fea232e', 0.3, 'Payer sur 1 mois', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_id` varchar(6000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('12066063746e072a83d2d37111a458ab8ae268a341f8b1fca88bc3a5df3c20ce404d41b8b5faaadb', '145167ef-a820-4d86-8d07-155dbbeeb774', '959ba36f-ef3d-43e6-8d46-af91587cf71c', NULL, '[]', 0, '2022-02-15 23:33:12', '2022-02-15 23:33:12', '2023-02-15 23:33:12'),
('25a2e5128e0d618fef1ee668cfd2e9a54eb0d7058ede5a68867846761a7c626f9faf52768b459c07', '145167ef-a820-4d86-8d07-155dbbeeb774', '959ba36f-ef3d-43e6-8d46-af91587cf71c', NULL, '[]', 0, '2022-02-19 09:43:13', '2022-02-19 09:43:13', '2023-02-19 09:43:13'),
('263c90ee08c88f20b237db825b9238fc7eed8096d4603d353bf2c3a6c96f19b64b72979f9140c7e8', 'b561596e-f991-4fa6-a646-60fba92cb264', '959ba36f-ef3d-43e6-8d46-af91587cf71c', NULL, '[]', 0, '2022-02-19 09:56:19', '2022-02-19 09:56:19', '2023-02-19 09:56:19'),
('2feeb53e9dd40693d29267ef02ff7a4828570af56857f8c7a903bfe9a7b475ab83d85602fab40874', '145167ef-a820-4d86-8d07-155dbbeeb774', '959ba36f-ef3d-43e6-8d46-af91587cf71c', NULL, '[]', 0, '2022-02-24 16:56:29', '2022-02-24 16:56:29', '2023-02-24 16:56:29'),
('3bb6525cb8e6ee29b455d55e19c635abede5818e650a3e3c4ce8b00b64d8c6e345b2c4dcd76779bc', 'b561596e-f991-4fa6-a646-60fba92cb264', '959ba36f-ef3d-43e6-8d46-af91587cf71c', NULL, '[]', 0, '2022-02-15 23:13:12', '2022-02-15 23:13:12', '2023-02-15 23:13:12'),
('5124b37471e63b613d580cb7d20a3689b233a33f3bd2ba95e87537364a1753ace295a8aea58cd2d1', '145167ef-a820-4d86-8d07-155dbbeeb774', '959ba36f-ef3d-43e6-8d46-af91587cf71c', NULL, '[]', 0, '2022-02-24 16:36:09', '2022-02-24 16:36:09', '2023-02-24 16:36:09'),
('61e8d20962acea9f5af4ef3071270985a46e6c1c29e8633b1878b834873746bd1fb18311aa826eac', 'b561596e-f991-4fa6-a646-60fba92cb264', '959ba36f-ef3d-43e6-8d46-af91587cf71c', NULL, '[]', 0, '2022-02-19 10:48:18', '2022-02-19 10:48:18', '2023-02-19 10:48:18'),
('6b035f703c87ea61e8dfd427c84595a16f87f7597e9bda2249ee7c0a2f61577dbd9bb44e69156a04', '145167ef-a820-4d86-8d07-155dbbeeb774', '959ba36f-ef3d-43e6-8d46-af91587cf71c', NULL, '[]', 0, '2022-02-16 13:13:46', '2022-02-16 13:13:46', '2023-02-16 13:13:46'),
('6ffed59b0f3ed634e36c482c56c75e9dc6536a8f4ab566de311b5cd4a87028423459f92ff147d483', '145167ef-a820-4d86-8d07-155dbbeeb774', '959ba36f-ef3d-43e6-8d46-af91587cf71c', NULL, '[]', 0, '2022-02-23 20:58:25', '2022-02-23 20:58:25', '2023-02-23 20:58:25'),
('838ad2906000d3b8a3ed4349c88f0633a1e63c36aa38b95ae4a381b98579d187b02ff5b008881902', '145167ef-a820-4d86-8d07-155dbbeeb774', '959ba36f-ef3d-43e6-8d46-af91587cf71c', NULL, '[]', 0, '2022-02-24 12:19:23', '2022-02-24 12:19:23', '2023-02-24 12:19:23'),
('860205a9ee9829ab1c8cf2d5eb9e9ad8450e36b0f767edb405c6e6cf63cdb2b789d9b80c69556f5c', 'b561596e-f991-4fa6-a646-60fba92cb264', '959ba36f-ef3d-43e6-8d46-af91587cf71c', NULL, '[]', 0, '2022-02-16 13:34:10', '2022-02-16 13:34:10', '2023-02-16 13:34:10'),
('97b39bfe71c8191ce595e3586d4cfd6ebd9829b7e7e7a4bbce6c6047e915dea136cfd4714372ad2b', '145167ef-a820-4d86-8d07-155dbbeeb774', '959ba36f-ef3d-43e6-8d46-af91587cf71c', NULL, '[]', 0, '2022-02-19 10:39:04', '2022-02-19 10:39:04', '2023-02-19 10:39:04'),
('a1f44b6ac63358c5a4c449d99978b4bc1f4620c37c98441ccf85233c794d137460934c43dcdef0fd', 'b561596e-f991-4fa6-a646-60fba92cb264', '959ba36f-ef3d-43e6-8d46-af91587cf71c', NULL, '[]', 0, '2022-02-19 14:09:40', '2022-02-19 14:09:40', '2023-02-19 14:09:40'),
('a6175b3043bcfae77b57f59e04daae604002e178255c8c4ee98a0c7aac0402bc1e5ed76325fed29a', '145167ef-a820-4d86-8d07-155dbbeeb774', '959ba36f-ef3d-43e6-8d46-af91587cf71c', NULL, '[]', 0, '2022-02-19 16:47:04', '2022-02-19 16:47:04', '2023-02-19 16:47:04'),
('ac8f954f397fa0bf7496c49df7c5c6f699ff7d44b1fb93e60130fbda7c91ef96886f19abe95e778c', '145167ef-a820-4d86-8d07-155dbbeeb774', '959ba36f-ef3d-43e6-8d46-af91587cf71c', NULL, '[]', 0, '2022-02-15 20:43:22', '2022-02-15 20:43:22', '2023-02-15 20:43:22'),
('afdb3316e6e78bbcbaef23d327cf38a1e23a5132bcc4a8966f9fba2a694f621d86c1959118d7d4c8', '145167ef-a820-4d86-8d07-155dbbeeb774', '959ba36f-ef3d-43e6-8d46-af91587cf71c', NULL, '[]', 0, '2022-02-24 12:38:55', '2022-02-24 12:38:55', '2023-02-24 12:38:55'),
('b330368faeb801317ab4820baf234e628167b579c9542e230d1f5d2779b8dbeb3ef529dc3755d22f', '145167ef-a820-4d86-8d07-155dbbeeb774', '959ba36f-ef3d-43e6-8d46-af91587cf71c', NULL, '[]', 0, '2022-02-21 17:20:24', '2022-02-21 17:20:24', '2023-02-21 17:20:24'),
('b8756fe4fc22d24f39318f3f5aefb24290dab0b1e682579d4569437a4d97099a8ab8dfa703332a88', 'b561596e-f991-4fa6-a646-60fba92cb264', '959ba36f-ef3d-43e6-8d46-af91587cf71c', NULL, '[]', 0, '2022-02-19 14:02:34', '2022-02-19 14:02:34', '2023-02-19 14:02:34'),
('b97593e8c6e85428473b74c4b0e3eba6fed7f470be845e3c091b1695eac7c56288b7aae5e49be8b7', 'b561596e-f991-4fa6-a646-60fba92cb264', '959ba36f-ef3d-43e6-8d46-af91587cf71c', NULL, '[]', 0, '2022-02-16 13:14:48', '2022-02-16 13:14:48', '2023-02-16 13:14:48'),
('bd5094c98ba6b7a7f3341761a3917ed0543ca65b806dd99d81736399e133db655cdb018a3c0139fa', 'b561596e-f991-4fa6-a646-60fba92cb264', '959ba36f-ef3d-43e6-8d46-af91587cf71c', NULL, '[]', 0, '2022-02-24 12:27:31', '2022-02-24 12:27:31', '2023-02-24 12:27:31'),
('bd66b932b5c9c423d0a0f2eee5acc18a15d1071ae070cc01187c1eb55755e3c7edddd5993d0df55f', '145167ef-a820-4d86-8d07-155dbbeeb774', '959ba36f-ef3d-43e6-8d46-af91587cf71c', NULL, '[]', 0, '2022-02-24 17:01:48', '2022-02-24 17:01:48', '2023-02-24 17:01:48'),
('bf33e37959a77dc6b8d57f06d1be525075d87c5b69e2027de7ad23ee63168f729f0e3c2d64dbfd75', 'b561596e-f991-4fa6-a646-60fba92cb264', '959ba36f-ef3d-43e6-8d46-af91587cf71c', NULL, '[]', 0, '2022-02-21 17:22:27', '2022-02-21 17:22:27', '2023-02-21 17:22:27'),
('bf580d0898c19a587b44b67c1110101fd2310eb88967cd0cd38459fddc318dce6e38951cb9a560e9', 'b561596e-f991-4fa6-a646-60fba92cb264', '959ba36f-ef3d-43e6-8d46-af91587cf71c', NULL, '[]', 0, '2022-02-19 14:42:26', '2022-02-19 14:42:26', '2023-02-19 14:42:26'),
('c5dfcdf1419fc401f5a991349f73e7c72fc02efbe74134d978b1687341e7bf102dc18218646e054a', 'b561596e-f991-4fa6-a646-60fba92cb264', '959ba36f-ef3d-43e6-8d46-af91587cf71c', NULL, '[]', 0, '2022-02-23 20:47:19', '2022-02-23 20:47:19', '2023-02-23 20:47:19'),
('de7988e63127c8b6dda20fce3f4025314cea6dcbb28064d15f05df94350edd6f993c30b3bfa84a55', '145167ef-a820-4d86-8d07-155dbbeeb774', '959ba36f-ef3d-43e6-8d46-af91587cf71c', NULL, '[]', 0, '2022-02-18 21:17:06', '2022-02-18 21:17:06', '2023-02-18 21:17:06'),
('dfb98ed31e3f4251cb640ce9cbafeb7952c651f8401ba76ba3cac54f58d2afb5a14ea1333b6eef93', 'b561596e-f991-4fa6-a646-60fba92cb264', '959ba36f-ef3d-43e6-8d46-af91587cf71c', NULL, '[]', 0, '2022-02-19 17:13:29', '2022-02-19 17:13:29', '2023-02-19 17:13:29'),
('e3b6ade2921b095beb21c8020b8fc326503e2d96b2fbdc6efb9db2e8524e8e4f586916a5aeda186f', '145167ef-a820-4d86-8d07-155dbbeeb774', '959ba36f-ef3d-43e6-8d46-af91587cf71c', NULL, '[]', 0, '2022-02-21 10:33:08', '2022-02-21 10:33:08', '2023-02-21 10:33:08'),
('fd8a373456d3ffcab4496681c9ec48a5ac39099d2e234870360018db26c307096f449bc4ed7f711c', 'b561596e-f991-4fa6-a646-60fba92cb264', '959ba36f-ef3d-43e6-8d46-af91587cf71c', NULL, '[]', 0, '2022-02-21 10:34:01', '2022-02-21 10:34:01', '2023-02-21 10:34:01');

-- --------------------------------------------------------

--
-- Structure de la table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `client_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
('959ba36f-ef3d-43e6-8d46-af91587cf71c', NULL, 'Tranchepay Personal Access Client', 'B9bHrJ1pDPnCuNIYvQiMpC1KOIZKYdrQZhG1MaCk', NULL, 'http://localhost', 1, 0, 0, '2022-02-15 20:29:04', '2022-02-15 20:29:04'),
('959ba36f-f62a-4007-bc75-b37a73a22fba', NULL, 'Tranchepay Password Grant Client', 'pFxKdIoqOTHMfqBO4asWGShlFwvlTZW1W4e8GEaE', 'users', 'http://localhost', 0, 1, 0, '2022-02-15 20:29:04', '2022-02-15 20:29:04');

-- --------------------------------------------------------

--
-- Structure de la table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `client_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, '959ba36f-ef3d-43e6-8d46-af91587cf71c', '2022-02-15 20:29:04', '2022-02-15 20:29:04');

-- --------------------------------------------------------

--
-- Structure de la table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `paddings`
--

CREATE TABLE `paddings` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `params`
--

CREATE TABLE `params` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cle` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `valeur` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `params`
--

INSERT INTO `params` (`id`, `cle`, `valeur`, `created_at`, `updated_at`) VALUES
('', 'access_token', 'brwmWVWyqhzI4GJCxRrCSAyLGx5J', NULL, '2022-02-24 17:22:28'),
('c3edcf86-7d0f-9ec6-8ff0-53040fea5s8r', 'max_pay', '200000', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `partenaires`
--

CREATE TABLE `partenaires` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `site_web` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `partenaires`
--

INSERT INTO `partenaires` (`id`, `nom`, `site_web`, `logo_url`, `created_at`, `updated_at`) VALUES
('c3edcf86-7d0f-9ec6-8ff0-53040fea23ac', 'Total Super Marché', 'www.total-sup.sn', 'https://totalenergies.sn/system/files/styles/cover_slider_762px/private/atoms/image/vibrons-football-avec-la-can-totalenergies.jpg?itok=ImA3emcA&c=584fbe437be47edbc7d9d4c57f3a59eb', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `password_resets`
--

INSERT INTO `password_resets` (`email`, `token`, `created_at`) VALUES
('704779065', '1C2G', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `produits`
--

CREATE TABLE `produits` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantite` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `prix_unitaire` double NOT NULL,
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `commande_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `retraits`
--

CREATE TABLE `retraits` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `montant` double NOT NULL,
  `date` datetime NOT NULL DEFAULT '2022-02-15 20:29:04',
  `via` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'INCONNUE',
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `compte_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verify_at` datetime DEFAULT NULL,
  `etat` tinyint(1) NOT NULL DEFAULT 1,
  `model` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `email_verify_at`, `etat`, `model`, `model_type`, `remember_token`, `created_at`, `updated_at`) VALUES
('145167ef-a820-4d86-8d07-155dbbeeb774', '781879981', NULL, '$2y$10$tiq7ovgail1CQfQdXueEHeUzgOtcIrXjiOWhtZvPwMl26BpaCxXnW', '2022-02-01 23:18:27', 1, 'fcc164f1-af9e-486e-8be3-da4875387069', 'Client', NULL, '2022-02-15 20:29:32', '2022-02-16 13:13:35'),
('392c326a-70a6-4bb8-a55a-e16cb83c9a7f', '704779065', NULL, '$2y$10$iXlA1cJgR4mVst2nOheCdO4ngRPmArNEl2qZTYmhohpFeghGjL7OO', NULL, 1, '6587d2ba-a03b-4d3a-807e-1f4f293412b9', 'Client', NULL, '2022-02-24 17:22:27', '2022-02-24 17:22:27'),
('b561596e-f991-4fa6-a646-60fba92cb264', '763978322', 'biba@gmail.com', '$2y$10$KGxnNhOvPvWBXXJcbxDClu47RbhkXtCw.k5jiAY5MDqKUy3R6Mazu', '2022-02-01 23:13:04', 1, '25d5c643-4f2a-4311-bb11-db503af4abb2', 'Commercant', NULL, '2022-02-15 23:12:13', '2022-02-16 13:33:29');

-- --------------------------------------------------------

--
-- Structure de la table `versements`
--

CREATE TABLE `versements` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_time` datetime NOT NULL DEFAULT '2022-02-15 20:29:04',
  `via` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `montant` double NOT NULL,
  `commande_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `versements`
--

INSERT INTO `versements` (`id`, `date_time`, `via`, `reference`, `montant`, `commande_id`, `created_at`, `updated_at`) VALUES
('48eda971-a8a6-4f9c-9f0d-b21dffa251e8', '2022-02-19 15:00:08', 'PAIEMENT EN CAISE', '68438242138415', 75000, '3cfc3940-3806-49e5-b885-997db3f5b3e7', '2022-02-19 15:00:08', '2022-02-19 15:00:08'),
('c3edcf86-7d0f-9ec6-8ff0-53040fea232e', '2022-02-15 20:29:04', 'Wave', '564821465512', 10000, 'b3edcf86-7d0f-4ec6-8ff0-53040fca232e', '2022-02-01 23:41:51', '2022-02-01 23:41:51');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `aides`
--
ALTER TABLE `aides`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `boutiques`
--
ALTER TABLE `boutiques`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `boutique_has_categories`
--
ALTER TABLE `boutique_has_categories`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `commandes`
--
ALTER TABLE `commandes`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `commercants`
--
ALTER TABLE `commercants`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `comptes`
--
ALTER TABLE `comptes`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `etat_commandes`
--
ALTER TABLE `etat_commandes`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Index pour la table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `mode_payement`
--
ALTER TABLE `mode_payement`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`(768));

--
-- Index pour la table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_auth_codes_user_id_index` (`user_id`);

--
-- Index pour la table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Index pour la table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Index pour la table `paddings`
--
ALTER TABLE `paddings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `paddings_token_unique` (`token`) USING HASH;

--
-- Index pour la table `params`
--
ALTER TABLE `params`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `partenaires`
--
ALTER TABLE `partenaires`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Index pour la table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Index pour la table `produits`
--
ALTER TABLE `produits`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `retraits`
--
ALTER TABLE `retraits`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_unique` (`username`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Index pour la table `versements`
--
ALTER TABLE `versements`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `versements_reference_unique` (`reference`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT pour la table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
