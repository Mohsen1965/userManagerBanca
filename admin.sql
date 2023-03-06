-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 06, 2023 at 09:30 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `admin`
--

-- --------------------------------------------------------

--
-- Table structure for table `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20230228154217', '2023-02-28 16:42:27', 2569),
('DoctrineMigrations\\Version20230228164539', '2023-02-28 18:03:33', 319),
('DoctrineMigrations\\Version20230228214407', '2023-02-28 22:44:27', 7734);

-- --------------------------------------------------------

--
-- Table structure for table `messenger_messages`
--

CREATE TABLE `messenger_messages` (
  `id` bigint(20) NOT NULL,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `available_at` datetime NOT NULL,
  `delivered_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `id` int(11) NOT NULL,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`id`, `nom`) VALUES
(1, 'ROLE_USER'),
(2, 'ROLE_ADMIN');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `is_active`, `password`, `created_at`, `updated_at`) VALUES
(20, 'mohsen', 'gmohsen6@gmail.com', 1, '$2y$10$a7VRaKeBkCHpLWUhdwttgeiiRKTv2QW.wjdqvzTBgT/wlFUkh/b2G', '2023-03-04 11:53:38', '2023-03-04 12:17:18'),
(21, 'amine', 'agmohsen6@gmail.com', 0, '$2y$10$mVKQVoGktVKYZJ2UU2PB2uOcbpAaBR3LeUTPAmGtft906QGVVq86q', '2023-03-04 11:54:03', '2023-03-04 11:54:15'),
(22, 'sss', 'sgmohsen6@gmail.com', 0, '$2y$10$An6s19wXZgQsr4kRnTJ9kOFvC6y.2MvnJlGjYm8KUpHf4wV2.8Mcq', '2023-03-04 11:55:16', NULL),
(23, 'aaa', 'kgmohsen6@gmail.com', 1, '$2y$10$lpYEtCyKObcecyjdNE7ypuhlRQXIgEhwF76jj2MjQ76Wq98l/9Ode', '2023-03-04 11:55:49', '2023-03-04 14:34:03'),
(24, 'rrr', '\'ét(t', 1, '$2y$10$.ruyBOj/GmyQSw4JQQXjdOiVcQ408KRtEjE0XythK0VyyOTL1irl2', '2023-03-06 14:43:36', NULL),
(25, 'aaaaaa', 'aaaa@gh.com', 0, '$2y$10$i7jLfznXYkOPH5DeTM8jwut4b9q5szatH.8d0DKa554fx7OXspaby', '2023-03-06 14:46:17', '2023-03-06 17:03:09'),
(26, 'mohsen', 'tgmohsen6@gmail.com', 1, '$2y$10$6cVXPW3.yKgxagx0K512OeqfTGokHkAlcxCg5R.LvsZwDOX4pfMJC', '2023-03-06 17:02:50', NULL),
(27, 'zzzz', 'zzgmohsen6@gmail.com', 1, '$2y$10$mXi1QfpgzFtfrQMy6DlSO.gr20lA9LwZdCufxmVsdUBZsog6RfAz2', '2023-03-06 17:14:56', '2023-03-06 17:15:44'),
(28, 'zzzz', 'zzzzgmohsen6@gmail.com', NULL, '$2y$10$76B18hZjx.Qst.wjzxYSquwAc9yTUFswHXCpmtfOsfGiwtNcsT9ze', '2023-03-06 17:27:57', NULL),
(29, 'ddd', 'dddgmohsen6@gmail.com', NULL, '$2y$10$Z2uyvLhAvCV945eboio0IuDePHOeLXS8YKNRb/El3R4o/CW8kkO1a', '2023-03-06 17:34:50', NULL),
(30, 'zzzzzz', 'zzzzzzgmohsen6@gmail.com', NULL, '$2y$10$YKUVICNVeXseg4n6wouZruVIi4Ba66kKxTYHRPp0eYa43mdoeQMle', '2023-03-06 17:43:32', NULL),
(31, 'zzzzzz', 'zzzzzazgmohsen6@gmail.com', NULL, '$2y$10$.UUmcCkXumgijbINeDa8IOnFa8iNE1WWGjyNDBXCahq7DgvRMJBiq', '2023-03-06 17:44:16', NULL),
(32, 'zzzzzz', 'zrzzztzazgmohsen6@gmail.com', NULL, '$2y$10$emvvjRLgix5/9Tkp4l2b6u8p9EaUAhVrHiKdfNX.E5L9FQsS67/J2', '2023-03-06 17:48:19', NULL),
(33, 'mohsen1', 'gmohsen6@gmail.com1', NULL, '$2y$10$K3TfF6bbg5SsgbTWJJ4ETek0w.5UQ/UbGTx9JtYE9ua5c/vwB20pu', '2023-03-06 17:48:57', NULL),
(34, 'aa', 'bgmohsen6@gmail.com', 1, '$2y$10$n5eHgZroqf4hCqb.53yxauAZs/pd0XNJNyUEJntjLnp1OuZ11PVsi', '2023-03-06 17:50:51', '2023-03-06 17:52:24'),
(35, 'najia', 'najia@gmail.com', 0, '$2y$10$.GI2TQbqYTVDk9/TAFKDdO.y4JIq0B4kNk5Z7Qy9TFwRzwHQtPn/C', '2023-03-06 17:53:44', '2023-03-06 17:55:07'),
(36, 'ziko', 'ziko@gmail.com', 0, '$2y$10$tFTpsf.4Za1tP3Nr8ewbDeuhxnZTzP1vJ0mwEe6D4ynhwsITomzvS', '2023-03-06 17:56:18', '2023-03-06 17:58:18'),
(37, 'yahia', 'yahia@gmail.com', 1, '$2y$10$M/6LdZSBUTZ0SV5UhRixreYgMKE1Y5/DPE/k74XlBx/8fNfgxsKtK', '2023-03-06 17:59:16', '2023-03-06 18:00:52'),
(38, 'xxx', 'xxx@gmail.com', NULL, '$2y$10$J80T8SwAee9tzhSVKTvZLeB8n3krNapGV8z.r/Mr7GYtwXfnizcJS', '2023-03-06 19:29:53', NULL),
(39, 'zara', 'zadmin@admin.com', 1, '$2y$10$vE5oCRp9MOpOW2/KqaQUwuKdFH0aZS.wDl/gcF02b0F7vwM8avW62', '2023-03-06 19:30:57', '2023-03-06 21:02:26'),
(40, 'zaza', 'zaza@zaza.com', 1, '$2y$10$aFBqJRkVt3syZQ39vV6dr.7mpZO1pBGQiK5cn/wl0XFRsEQ8urEF6', '2023-03-06 19:34:41', NULL),
(41, 'mohseng', 'mgmohsen6@gmail.com', NULL, '$2y$10$A5FYR5loa2L9.X2JKUd.netpRExGWtPGeims8/oV.QsSdmayE5ybm', '2023-03-06 21:08:59', NULL),
(42, 'amine', 'amin@gmail.com', 0, '$2y$10$AFEWhhzzRn66w6KofpjpFetNraMnyRRgNatJj2U557cTvGNBw..eG', '2023-03-06 21:10:44', '2023-03-06 21:12:31');

-- --------------------------------------------------------

--
-- Table structure for table `user_role`
--

CREATE TABLE `user_role` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_role`
--

INSERT INTO `user_role` (`user_id`, `role_id`) VALUES
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 2),
(25, 2),
(26, 2),
(34, 2),
(35, 2),
(36, 2),
(37, 2),
(39, 2),
(40, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Indexes for table `messenger_messages`
--
ALTER TABLE `messenger_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  ADD KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  ADD KEY `IDX_75EA56E016BA31DB` (`delivered_at`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `IDX_2DE8C6A3A76ED395` (`user_id`),
  ADD KEY `IDX_2DE8C6A3D60322AC` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `messenger_messages`
--
ALTER TABLE `messenger_messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `user_role`
--
ALTER TABLE `user_role`
  ADD CONSTRAINT `FK_2DE8C6A3A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_2DE8C6A3D60322AC` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
