-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 23, 2020 at 06:23 AM
-- Server version: 8.0.21
-- PHP Version: 7.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `automation_center`
--

-- --------------------------------------------------------

--
-- Table structure for table `authtoken_token`
--

CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `authtoken_token`
--

INSERT INTO `authtoken_token` (`key`, `created`, `user_id`) VALUES
('63edb092e36251d9487e1b6f3de0a9a4e5db6949', '2020-08-17 10:43:14.757607', 2),
('e115c07dc773ed81d54c3981ee4c93c635c57495', '2020-08-17 15:42:34.754494', 1);

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `auth_group`
--

INSERT INTO `auth_group` (`id`, `name`) VALUES
(2, 'debug'),
(3, 'debug2'),
(1, 'project_owner');

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` int NOT NULL,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `auth_group_permissions`
--

INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES
(1, 1, 5),
(2, 1, 6),
(3, 1, 7),
(4, 1, 8),
(5, 1, 9),
(6, 1, 10),
(7, 1, 11),
(8, 1, 12),
(9, 1, 13),
(10, 1, 14),
(11, 1, 15),
(12, 1, 16),
(13, 1, 29),
(14, 1, 30),
(15, 1, 31),
(16, 1, 32),
(17, 1, 33),
(18, 1, 34),
(19, 1, 35),
(20, 1, 36),
(21, 1, 37),
(22, 1, 38),
(23, 1, 39),
(24, 1, 40),
(25, 1, 41),
(26, 1, 42),
(27, 1, 43),
(28, 1, 44),
(29, 1, 45),
(30, 1, 46),
(31, 1, 47),
(32, 1, 48),
(33, 1, 49),
(34, 1, 50),
(35, 1, 51),
(36, 1, 52),
(37, 1, 53),
(38, 1, 54),
(39, 1, 55),
(40, 1, 56),
(41, 1, 57),
(42, 1, 58),
(43, 1, 59),
(44, 1, 60),
(45, 1, 61),
(46, 1, 62),
(47, 1, 63),
(48, 1, 64),
(49, 1, 65),
(50, 1, 66),
(51, 1, 67),
(52, 1, 68),
(53, 1, 69),
(54, 1, 70),
(55, 1, 71),
(56, 1, 72),
(57, 1, 73),
(58, 1, 74),
(59, 1, 75),
(60, 1, 76),
(61, 2, 1),
(66, 2, 13),
(69, 2, 30),
(65, 2, 53),
(67, 2, 77),
(62, 3, 9),
(64, 3, 49),
(63, 3, 50);

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add Token', 7, 'add_token'),
(26, 'Can change Token', 7, 'change_token'),
(27, 'Can delete Token', 7, 'delete_token'),
(28, 'Can view Token', 7, 'view_token'),
(29, 'Can add project', 8, 'add_project'),
(30, 'Can change project', 8, 'change_project'),
(31, 'Can delete project', 8, 'delete_project'),
(32, 'Can view project', 8, 'view_project'),
(33, 'Can add automated case', 9, 'add_automatedcase'),
(34, 'Can change automated case', 9, 'change_automatedcase'),
(35, 'Can delete automated case', 9, 'delete_automatedcase'),
(36, 'Can view automated case', 9, 'view_automatedcase'),
(37, 'Can add script', 10, 'add_script'),
(38, 'Can change script', 10, 'change_script'),
(39, 'Can delete script', 10, 'delete_script'),
(40, 'Can view script', 10, 'view_script'),
(41, 'Can add function', 11, 'add_function'),
(42, 'Can change function', 11, 'change_function'),
(43, 'Can delete function', 11, 'delete_function'),
(44, 'Can view function', 11, 'view_function'),
(45, 'Can add script function', 12, 'add_scriptfunction'),
(46, 'Can change script function', 12, 'change_scriptfunction'),
(47, 'Can delete script function', 12, 'delete_scriptfunction'),
(48, 'Can view script function', 12, 'view_scriptfunction'),
(49, 'Can add browser', 13, 'add_browser'),
(50, 'Can change browser', 13, 'change_browser'),
(51, 'Can delete browser', 13, 'delete_browser'),
(52, 'Can view browser', 13, 'view_browser'),
(53, 'Can add device', 14, 'add_device'),
(54, 'Can change device', 14, 'change_device'),
(55, 'Can delete device', 14, 'delete_device'),
(56, 'Can view device', 14, 'view_device'),
(57, 'Can add driver', 15, 'add_driver'),
(58, 'Can change driver', 15, 'change_driver'),
(59, 'Can delete driver', 15, 'delete_driver'),
(60, 'Can view driver', 15, 'view_driver'),
(61, 'Can add mobile os', 16, 'add_mobileos'),
(62, 'Can change mobile os', 16, 'change_mobileos'),
(63, 'Can delete mobile os', 16, 'delete_mobileos'),
(64, 'Can view mobile os', 16, 'view_mobileos'),
(65, 'Can add platform os', 17, 'add_platformos'),
(66, 'Can change platform os', 17, 'change_platformos'),
(67, 'Can delete platform os', 17, 'delete_platformos'),
(68, 'Can view platform os', 17, 'view_platformos'),
(69, 'Can add test environment', 18, 'add_testenvironment'),
(70, 'Can change test environment', 18, 'change_testenvironment'),
(71, 'Can delete test environment', 18, 'delete_testenvironment'),
(72, 'Can view test environment', 18, 'view_testenvironment'),
(73, 'Can add test suite', 19, 'add_testsuite'),
(74, 'Can change test suite', 19, 'change_testsuite'),
(75, 'Can delete test suite', 19, 'delete_testsuite'),
(76, 'Can view test suite', 19, 'view_testsuite'),
(77, 'Can add role', 20, 'add_role'),
(78, 'Can change role', 20, 'change_role'),
(79, 'Can delete role', 20, 'delete_role'),
(80, 'Can view role', 20, 'view_role');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$150000$1poFIxbbSVRr$Lf4+UFJUwxqRPP4T4kjny41NpzgcN2lLBbGonvjt/w4=', '2020-08-14 10:31:40.455521', 1, 'bo', '', '', 'jbsv43@sina.com', 1, 1, '2020-03-10 11:54:34.975765'),
(2, 'pbkdf2_sha256$150000$jVMmmL22a0aB$ndl4bB6SkCp4ugj+jHh3IeRb2KQYGRGRBpc+uRlVuA0=', '2020-08-11 13:12:57.295512', 0, 'basic', '', '', 'basic@test.com', 0, 1, '2020-04-16 15:38:00.000000');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2020-08-10 11:16:58.191358', '1', 'project_owner', 1, '[{\"added\": {}}]', 3, 1),
(2, '2020-08-10 11:17:19.677639', '2', 'basic', 2, '[{\"changed\": {\"fields\": [\"groups\"]}}]', 4, 1),
(3, '2020-08-10 11:18:22.051029', '2', 'basic', 2, '[{\"changed\": {\"fields\": [\"groups\"]}}]', 4, 1),
(4, '2020-08-10 11:23:11.952405', '2', 'basic', 2, '[{\"changed\": {\"fields\": [\"groups\"]}}]', 4, 1),
(5, '2020-08-10 17:35:50.955094', '2', 'basic', 2, '[{\"changed\": {\"fields\": [\"groups\"]}}]', 4, 1),
(6, '2020-08-14 11:20:20.876817', '2', 'debug', 1, '[{\"added\": {}}]', 3, 1),
(7, '2020-08-14 13:36:29.072235', '3', 'debug2', 1, '[{\"added\": {}}]', 3, 1),
(8, '2020-08-14 13:57:33.290527', '2', 'debug', 2, '[{\"changed\": {\"fields\": [\"permissions\"]}}]', 3, 1),
(9, '2020-08-14 14:22:49.950222', '2', 'debug', 2, '[{\"changed\": {\"fields\": [\"permissions\"]}}]', 3, 1),
(10, '2020-08-14 14:24:51.119192', '2', 'debug', 2, '[{\"changed\": {\"fields\": [\"permissions\"]}}]', 3, 1),
(11, '2020-08-14 14:26:38.169378', '2', 'debug', 2, '[{\"changed\": {\"fields\": [\"permissions\"]}}]', 3, 1),
(12, '2020-08-17 11:05:53.463309', '2', 'debug', 2, '[{\"changed\": {\"fields\": [\"permissions\"]}}]', 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(7, 'authtoken', 'token'),
(5, 'contenttypes', 'contenttype'),
(13, 'execution', 'browser'),
(14, 'execution', 'device'),
(15, 'execution', 'driver'),
(16, 'execution', 'mobileos'),
(17, 'execution', 'platformos'),
(18, 'execution', 'testenvironment'),
(9, 'projects', 'automatedcase'),
(11, 'projects', 'function'),
(8, 'projects', 'project'),
(10, 'projects', 'script'),
(12, 'projects', 'scriptfunction'),
(19, 'projects', 'testsuite'),
(6, 'sessions', 'session'),
(20, 'users', 'role');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` int NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2020-03-10 11:53:43.178764'),
(2, 'auth', '0001_initial', '2020-03-10 11:53:43.320246'),
(3, 'admin', '0001_initial', '2020-03-10 11:53:43.575896'),
(4, 'admin', '0002_logentry_remove_auto_add', '2020-03-10 11:53:43.656966'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2020-03-10 11:53:43.666563'),
(6, 'contenttypes', '0002_remove_content_type_name', '2020-03-10 11:53:43.729292'),
(7, 'auth', '0002_alter_permission_name_max_length', '2020-03-10 11:53:43.762957'),
(8, 'auth', '0003_alter_user_email_max_length', '2020-03-10 11:53:43.791166'),
(9, 'auth', '0004_alter_user_username_opts', '2020-03-10 11:53:43.803545'),
(10, 'auth', '0005_alter_user_last_login_null', '2020-03-10 11:53:43.839428'),
(11, 'auth', '0006_require_contenttypes_0002', '2020-03-10 11:53:43.842119'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2020-03-10 11:53:43.852882'),
(13, 'auth', '0008_alter_user_username_max_length', '2020-03-10 11:53:43.892077'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2020-03-10 11:53:43.930780'),
(15, 'auth', '0010_alter_group_name_max_length', '2020-03-10 11:53:43.950344'),
(16, 'auth', '0011_update_proxy_permissions', '2020-03-10 11:53:43.961083'),
(17, 'authtoken', '0001_initial', '2020-03-10 11:53:43.979232'),
(18, 'authtoken', '0002_auto_20160226_1747', '2020-03-10 11:53:44.095745'),
(19, 'projects', '0001_initial', '2020-03-10 11:53:44.113485'),
(20, 'projects', '0002_project_owner', '2020-03-10 11:53:44.133020'),
(21, 'projects', '0003_auto_20200205_1745', '2020-03-10 11:53:44.415625'),
(22, 'projects', '0004_project_project_type', '2020-03-10 11:53:44.448831'),
(23, 'sessions', '0001_initial', '2020-03-10 11:53:44.466383'),
(24, 'projects', '0005_automatedcase_function_script', '2020-04-18 17:12:45.964242'),
(25, 'projects', '0005_automatedcase_script_scriptfunction', '2020-04-18 17:19:54.984252'),
(26, 'execution', '0001_initial', '2020-04-29 15:40:03.589104'),
(27, 'execution', '0002_device_driver', '2020-04-29 17:42:26.037943'),
(28, 'execution', '0003_mobileos_platformos_testenvironment', '2020-04-30 10:24:39.557474'),
(29, 'projects', '0006_testsuite', '2020-06-22 11:37:04.736688'),
(30, 'projects', '0007_auto_20200813_1750', '2020-08-13 17:50:46.015774'),
(34, 'users', '0001_initial', '2020-08-14 10:26:39.564104'),
(35, 'projects', '0008_remove_project_owner', '2020-08-17 11:28:32.901122'),
(36, 'projects', '0009_auto_20201023_1407', '2020-10-23 14:07:41.363411');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('3qwwv2at2xfsbzpwsehnmake5ytc6p3r', 'YTkzZjU3YzI0NzA1NzhiYmYxMDAxODFkMjYxYzA5YjRlM2NmYWY0ZDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2ZTc1NzA2YTExNjUxN2Q1MDYzYTBiNTkwMTUyOTRhM2Q4MmM4MjU2In0=', '2020-08-26 11:09:04.492410'),
('5geyo1kdbd7a20y90osbs7yyat2xy2mo', 'YTkzZjU3YzI0NzA1NzhiYmYxMDAxODFkMjYxYzA5YjRlM2NmYWY0ZDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2ZTc1NzA2YTExNjUxN2Q1MDYzYTBiNTkwMTUyOTRhM2Q4MmM4MjU2In0=', '2020-08-28 10:31:40.457972'),
('a4t8wzwhzbnvtwv1c75drbogrgfcakpl', 'YTkzZjU3YzI0NzA1NzhiYmYxMDAxODFkMjYxYzA5YjRlM2NmYWY0ZDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2ZTc1NzA2YTExNjUxN2Q1MDYzYTBiNTkwMTUyOTRhM2Q4MmM4MjU2In0=', '2020-04-30 15:37:20.584006'),
('g2gmw252r98slfsqztw7nh7c68ch3ke7', 'YTkzZjU3YzI0NzA1NzhiYmYxMDAxODFkMjYxYzA5YjRlM2NmYWY0ZDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2ZTc1NzA2YTExNjUxN2Q1MDYzYTBiNTkwMTUyOTRhM2Q4MmM4MjU2In0=', '2020-08-24 17:35:41.263311'),
('gqljwra585ifxiboj7ohamlt4skuq0yn', 'YTkzZjU3YzI0NzA1NzhiYmYxMDAxODFkMjYxYzA5YjRlM2NmYWY0ZDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2ZTc1NzA2YTExNjUxN2Q1MDYzYTBiNTkwMTUyOTRhM2Q4MmM4MjU2In0=', '2020-04-30 16:39:32.495621'),
('mx6o90opmxh9a7mx01sx3bux5dfjzrpt', 'NWU5MjRmYTRlNjI5ZWI4NGM2ODQ3Nzg1YWEzZDFlM2FiMzgyZDQ5NTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3MTA0YWQ2MmEwNWI1NWIwMjNkMmIzZmJiYjNhMDFkZjdjYjZjYTgwIn0=', '2020-08-25 13:12:57.300908'),
('qtjdqqz6qwlmdv1xmj6w3gk1lkxwzvqd', 'YTkzZjU3YzI0NzA1NzhiYmYxMDAxODFkMjYxYzA5YjRlM2NmYWY0ZDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2ZTc1NzA2YTExNjUxN2Q1MDYzYTBiNTkwMTUyOTRhM2Q4MmM4MjU2In0=', '2020-06-26 13:51:45.159511'),
('v4hje7v6z3emhnj81y6jsnwtewytdkj7', 'YTkzZjU3YzI0NzA1NzhiYmYxMDAxODFkMjYxYzA5YjRlM2NmYWY0ZDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2ZTc1NzA2YTExNjUxN2Q1MDYzYTBiNTkwMTUyOTRhM2Q4MmM4MjU2In0=', '2020-08-24 10:13:21.512618'),
('vos0u5udje1t9f3ksvenwerfm25nf5qj', 'YTkzZjU3YzI0NzA1NzhiYmYxMDAxODFkMjYxYzA5YjRlM2NmYWY0ZDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2ZTc1NzA2YTExNjUxN2Q1MDYzYTBiNTkwMTUyOTRhM2Q4MmM4MjU2In0=', '2020-04-30 15:33:33.272380');

-- --------------------------------------------------------

--
-- Table structure for table `execution_browser`
--

CREATE TABLE `execution_browser` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `alias` varchar(100) NOT NULL,
  `version` varchar(100) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `execution_browser`
--

INSERT INTO `execution_browser` (`id`, `name`, `alias`, `version`, `create_time`, `update_time`) VALUES
(1, 'Chrome', 'chrome', '75.0.3770.142', '2019-07-31 02:46:21.000000', '2019-07-31 02:46:21.000000'),
(2, 'Firefox', 'firefox', '67.0.4', '2019-07-31 02:48:37.000000', '2019-07-31 02:48:37.000000'),
(3, 'Safari', 'Safari', '12.1.2', '2019-07-31 02:49:54.000000', '2019-07-31 02:49:54.000000'),
(4, 'IE', 'internet explorer', '11', '2019-07-31 02:53:20.000000', '2019-07-31 02:53:20.000000'),
(5, 'Edge', 'MicrosoftEdge', '42.17134.1.0', '2019-07-31 02:54:49.000000', '2019-07-31 02:54:49.000000'),
(6, 'MobileBrowser', 'chrome', '75.0.3770.142', '2019-07-31 02:56:31.000000', '2019-07-31 02:56:31.000000'),
(7, 'Chrome', 'chrome', '76.0.3809.100', '2019-10-27 04:06:59.000000', '2019-10-27 04:06:59.000000'),
(8, 'Chrome', 'chrome', '80.0.3987.132', '2020-03-10 06:23:05.000000', '2020-03-10 06:23:05.000000'),
(9, 'Chrome', 'chrome', 'unknown', '2020-03-21 02:05:19.000000', '2020-03-21 02:05:19.000000'),
(10, 'Chrome', 'chrome', '80.0.3987.149', '2020-03-21 02:09:52.000000', '2020-03-21 02:09:52.000000');

-- --------------------------------------------------------

--
-- Table structure for table `execution_device`
--

CREATE TABLE `execution_device` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `execution_device`
--

INSERT INTO `execution_device` (`id`, `name`, `create_time`, `update_time`) VALUES
(1, 'Simulator', '2019-07-31 06:26:04.000000', '2019-07-31 06:26:04.000000'),
(2, 'Emulator', '2019-07-31 06:26:24.000000', '2019-07-31 06:26:24.000000'),
(3, 'MiPlus', '2019-07-31 06:26:43.000000', '2019-07-31 06:26:43.000000'),
(4, 'STF', '2019-07-31 06:26:49.000000', '2019-07-31 06:26:49.000000');

-- --------------------------------------------------------

--
-- Table structure for table `execution_driver`
--

CREATE TABLE `execution_driver` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `version` varchar(100) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `comment` varchar(2000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `execution_driver`
--

INSERT INTO `execution_driver` (`id`, `name`, `version`, `create_time`, `update_time`, `comment`) VALUES
(1, 'chromedriver', '74.0.3729.6', '2019-07-31 03:07:15.000000', '2019-07-31 03:07:15.000000', 'test on macos, chrome 74 and 75.0.3770.142'),
(2, 'geckodriver', '0.24.0', '2019-07-31 03:08:09.000000', '2019-07-31 03:08:09.000000', 'test on macos, firefox 67.0'),
(3, 'safaridriver', '12607.3.10', '2019-07-31 03:08:38.000000', '2019-07-31 03:08:38.000000', 'test on macos, safari 12.1.2'),
(4, 'IEDriver', '3.9.0.0', '2019-07-31 03:09:00.000000', '2019-07-31 03:09:00.000000', 'test on win10, ie 11.706.17134.0'),
(5, 'MicrosoftWebDriver\r\n', '17.17134', '2019-07-31 03:09:23.000000', '2019-07-31 03:09:23.000000', 'test on win10, Edge 17134'),
(6, 'appium', '1.11.1', '2019-07-31 03:11:13.000000', '2019-07-31 03:11:13.000000', 'test on macos 10.12.6, android 4.4.4 & 5.0.2 & 8.1.0, ios 11.2'),
(7, 'appium', '1.13.0', '2019-07-31 03:34:04.000000', '2019-07-31 03:34:04.000000', 'test on macos 10.14.6, android 8.1.0, ios 12.2 & 12.4');

-- --------------------------------------------------------

--
-- Table structure for table `execution_environment`
--

CREATE TABLE `execution_environment` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `execution_environment`
--

INSERT INTO `execution_environment` (`id`, `name`) VALUES
(1, 'INT'),
(2, 'QA'),
(3, 'Regression'),
(4, 'Staging'),
(5, 'Production');

-- --------------------------------------------------------

--
-- Table structure for table `execution_mobile_os`
--

CREATE TABLE `execution_mobile_os` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `version` varchar(100) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `execution_mobile_os`
--

INSERT INTO `execution_mobile_os` (`id`, `name`, `version`, `create_time`, `update_time`) VALUES
(1, 'iOS', '12.4', '2019-07-31 03:21:50.000000', '2019-07-31 03:21:50.000000'),
(2, 'Android', '8.1.0', '2019-07-31 03:22:49.000000', '2019-07-31 03:22:49.000000'),
(3, 'iOS', 'unknown', '2020-03-21 02:02:59.000000', '2020-03-21 02:02:59.000000');

-- --------------------------------------------------------

--
-- Table structure for table `execution_platform_os`
--

CREATE TABLE `execution_platform_os` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `version` varchar(100) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `execution_platform_os`
--

INSERT INTO `execution_platform_os` (`id`, `name`, `version`, `create_time`, `update_time`) VALUES
(1, 'Windows', 'Windows-10-10.0.17134-SP0', '2019-07-31 06:24:15.000000', '2019-07-31 06:24:15.000000'),
(2, 'Macos', 'Darwin-16.7.0-x86_64-i386-64bit', '2019-07-31 06:24:38.000000', '2019-07-31 06:24:38.000000'),
(3, 'Macos', 'Darwin-18.7.0-x86_64-i386-64bit', '2019-10-27 03:49:54.000000', '2019-10-27 03:49:54.000000'),
(4, 'Macos', 'Darwin-18.6.0-x86_64-i386-64bit', '2020-03-10 06:23:06.000000', '2020-03-10 06:23:06.000000');

-- --------------------------------------------------------

--
-- Table structure for table `projects_automated_case`
--

CREATE TABLE `projects_automated_case` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `script_function_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `projects_automated_case`
--

INSERT INTO `projects_automated_case` (`id`, `name`, `create_time`, `update_time`, `script_function_id`) VALUES
(1, 'RA-1: post comment amount 0', '2019-10-27 03:50:02.000000', '2019-10-27 03:50:02.000000', 1),
(2, 'RA-2: post comment amount 1', '2019-10-27 03:50:06.000000', '2019-10-27 03:50:06.000000', 2),
(3, 'RA-3: post comment amount 2', '2019-10-27 03:50:10.000000', '2019-10-27 03:50:10.000000', 3),
(4, 'RA-4: posts amount', '2019-10-27 03:50:15.000000', '2019-10-27 03:50:15.000000', 4),
(5, 'RA-5: create new post and check new amount', '2019-10-27 03:50:19.000000', '2019-10-27 03:50:19.000000', 5),
(6, 'ByBlog-3: only user who have logged in can see the posts view dropdown in post list page', '2019-10-27 04:07:09.000000', '2019-10-27 04:07:09.000000', 6),
(7, 'ByBlog-2: user is able to view posts when jump page', '2019-10-27 04:07:14.000000', '2019-10-27 04:07:14.000000', 7),
(8, 'ByBlog-4: details page url contains post id', '2019-10-27 04:07:18.000000', '2019-10-27 04:07:18.000000', 8),
(9, 'ByBlog-1: user is able to search posts and view the search result', '2019-10-27 04:07:21.000000', '2019-10-27 04:07:21.000000', 9),
(10, 'MWeb-1: user is able to search posts and view the search result', '2019-10-27 04:10:36.000000', '2019-10-27 04:10:36.000000', 10);

-- --------------------------------------------------------

--
-- Table structure for table `projects_project`
--

CREATE TABLE `projects_project` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `project_type` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `projects_project`
--

INSERT INTO `projects_project` (`id`, `name`, `create_time`, `update_time`, `project_type`) VALUES
(1, 'rest_api', '2019-10-27 11:49:55.000000', '2019-10-27 11:49:55.000000', 'internal'),
(2, 'byblog', '2019-10-27 12:07:03.000000', '2019-10-27 12:07:03.000000', 'internal'),
(3, 'mobile_web', '2019-10-27 12:10:29.000000', '2019-10-27 12:10:29.000000', 'internal');

-- --------------------------------------------------------

--
-- Table structure for table `projects_script`
--

CREATE TABLE `projects_script` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `project_id` int NOT NULL,
  `author` varchar(100) NOT NULL,
  `file_created` date DEFAULT NULL,
  `file_updated` date DEFAULT NULL,
  `maintainer` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  `tag` varchar(100) NOT NULL,
  `version` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `projects_script`
--

INSERT INTO `projects_script` (`id`, `name`, `create_time`, `update_time`, `project_id`, `author`, `file_created`, `file_updated`, `maintainer`, `status`, `tag`, `version`) VALUES
(1, 'test_post_comment', '2019-10-27 03:49:59.000000', '2019-10-27 03:49:59.000000', 1, 'Bob', '2019-10-25', '2019-10-25', 'Bob', 'Completed', 'API, Comment', '1.1'),
(2, 'test_posts', '2019-10-27 03:50:12.000000', '2019-10-27 03:50:12.000000', 1, 'Bob', '2019-10-25', '2019-10-25', 'Bob', 'Completed', 'API, Posts', '1.1'),
(3, 'test_permission', '2019-10-27 04:07:06.000000', '2019-10-27 04:07:06.000000', 2, 'Bob', '2019-10-27', '2019-10-27', 'Bob', 'Completed', 'Web, Blog, Permission', '1.1'),
(4, 'test_view_posts', '2019-10-27 04:07:11.000000', '2019-10-27 04:07:11.000000', 2, 'Bob', '2019-10-27', '2019-10-27', 'Bob', 'Completed', 'Web, Blog, Posts', '1.1'),
(5, 'test_view_posts', '2019-10-27 04:10:33.000000', '2019-10-27 04:10:33.000000', 3, 'Bob', '2019-10-27', '2019-10-27', 'Bob', 'Completed', 'Mobile, Blog, Posts', '1.1');

-- --------------------------------------------------------

--
-- Table structure for table `projects_script_function`
--

CREATE TABLE `projects_script_function` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `script_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `projects_script_function`
--

INSERT INTO `projects_script_function` (`id`, `name`, `create_time`, `update_time`, `script_id`) VALUES
(1, 'test_post_comment_amount_0', '2019-10-27 03:50:00.000000', '2019-10-27 03:50:00.000000', 1),
(2, 'test_post_comment_amount_1', '2019-10-27 03:50:04.000000', '2019-10-27 03:50:04.000000', 1),
(3, 'test_post_comment_amount_2', '2019-10-27 03:50:08.000000', '2019-10-27 03:50:08.000000', 1),
(4, 'test_posts_amount', '2019-10-27 03:50:13.000000', '2019-10-27 03:50:13.000000', 2),
(5, 'test_create_new_post', '2019-10-27 03:50:17.000000', '2019-10-27 03:50:17.000000', 2),
(6, 'test_sort_posts_only_available_for_logged_in_user', '2019-10-27 04:07:07.000000', '2019-10-27 04:07:07.000000', 3),
(7, 'test_view_posts_when_jump_page', '2019-10-27 04:07:12.000000', '2019-10-27 04:07:12.000000', 4),
(8, 'test_post_id_in_detail_page_url', '2019-10-27 04:07:16.000000', '2019-10-27 04:07:16.000000', 4),
(9, 'test_view_posts_in_search_result', '2019-10-27 04:07:20.000000', '2019-10-27 04:07:20.000000', 4),
(10, 'test_view_posts_in_search_result', '2019-10-27 04:10:34.000000', '2019-10-27 04:10:34.000000', 5);

-- --------------------------------------------------------

--
-- Table structure for table `projects_test_suite`
--

CREATE TABLE `projects_test_suite` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `project_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `projects_test_suite_script`
--

CREATE TABLE `projects_test_suite_script` (
  `id` int NOT NULL,
  `testsuite_id` int NOT NULL,
  `script_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users_role`
--

CREATE TABLE `users_role` (
  `id` int NOT NULL,
  `group_id` int NOT NULL,
  `project_id` int NOT NULL,
  `user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `users_role`
--

INSERT INTO `users_role` (`id`, `group_id`, `project_id`, `user_id`) VALUES
(3, 2, 1, 2),
(1, 3, 1, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `authtoken_token`
--
ALTER TABLE `authtoken_token`
  ADD PRIMARY KEY (`key`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `execution_browser`
--
ALTER TABLE `execution_browser`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `execution_device`
--
ALTER TABLE `execution_device`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `execution_driver`
--
ALTER TABLE `execution_driver`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `execution_environment`
--
ALTER TABLE `execution_environment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `execution_mobile_os`
--
ALTER TABLE `execution_mobile_os`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `execution_platform_os`
--
ALTER TABLE `execution_platform_os`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `projects_automated_case`
--
ALTER TABLE `projects_automated_case`
  ADD PRIMARY KEY (`id`),
  ADD KEY `projects_automated_c_script_function_id_cb37cf96_fk_projects_` (`script_function_id`);

--
-- Indexes for table `projects_project`
--
ALTER TABLE `projects_project`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `projects_project_name_1ecf4961_uniq` (`name`);

--
-- Indexes for table `projects_script`
--
ALTER TABLE `projects_script`
  ADD PRIMARY KEY (`id`),
  ADD KEY `projects_script_project_id_df0c5d0e_fk_projects_project_id` (`project_id`);

--
-- Indexes for table `projects_script_function`
--
ALTER TABLE `projects_script_function`
  ADD PRIMARY KEY (`id`),
  ADD KEY `projects_script_func_script_id_1bdbe953_fk_projects_` (`script_id`);

--
-- Indexes for table `projects_test_suite`
--
ALTER TABLE `projects_test_suite`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `projects_test_suite_name_project_id_e22b1fae_uniq` (`name`,`project_id`),
  ADD KEY `projects_test_suite_project_id_32cabb10_fk_projects_project_id` (`project_id`);

--
-- Indexes for table `projects_test_suite_script`
--
ALTER TABLE `projects_test_suite_script`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `projects_test_suite_script_testsuite_id_script_id_a616849b_uniq` (`testsuite_id`,`script_id`),
  ADD KEY `projects_test_suite__script_id_693c565c_fk_projects_` (`script_id`);

--
-- Indexes for table `users_role`
--
ALTER TABLE `users_role`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_role_group_id_project_id_user_id_a6884194_uniq` (`group_id`,`project_id`,`user_id`),
  ADD KEY `users_role_project_id_2837f877_fk_projects_project_id` (`project_id`),
  ADD KEY `users_role_user_id_cbcc337e_fk_auth_user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `execution_browser`
--
ALTER TABLE `execution_browser`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `execution_device`
--
ALTER TABLE `execution_device`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `execution_driver`
--
ALTER TABLE `execution_driver`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `execution_environment`
--
ALTER TABLE `execution_environment`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `execution_mobile_os`
--
ALTER TABLE `execution_mobile_os`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `execution_platform_os`
--
ALTER TABLE `execution_platform_os`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `projects_automated_case`
--
ALTER TABLE `projects_automated_case`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `projects_project`
--
ALTER TABLE `projects_project`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `projects_script`
--
ALTER TABLE `projects_script`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `projects_script_function`
--
ALTER TABLE `projects_script_function`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `projects_test_suite`
--
ALTER TABLE `projects_test_suite`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `projects_test_suite_script`
--
ALTER TABLE `projects_test_suite_script`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users_role`
--
ALTER TABLE `users_role`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `authtoken_token`
--
ALTER TABLE `authtoken_token`
  ADD CONSTRAINT `authtoken_token_user_id_35299eff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `projects_automated_case`
--
ALTER TABLE `projects_automated_case`
  ADD CONSTRAINT `projects_automated_c_script_function_id_cb37cf96_fk_projects_` FOREIGN KEY (`script_function_id`) REFERENCES `projects_script_function` (`id`);

--
-- Constraints for table `projects_script`
--
ALTER TABLE `projects_script`
  ADD CONSTRAINT `projects_script_project_id_df0c5d0e_fk_projects_project_id` FOREIGN KEY (`project_id`) REFERENCES `projects_project` (`id`);

--
-- Constraints for table `projects_script_function`
--
ALTER TABLE `projects_script_function`
  ADD CONSTRAINT `projects_script_func_script_id_1bdbe953_fk_projects_` FOREIGN KEY (`script_id`) REFERENCES `projects_script` (`id`);

--
-- Constraints for table `projects_test_suite`
--
ALTER TABLE `projects_test_suite`
  ADD CONSTRAINT `projects_test_suite_project_id_32cabb10_fk_projects_project_id` FOREIGN KEY (`project_id`) REFERENCES `projects_project` (`id`);

--
-- Constraints for table `projects_test_suite_script`
--
ALTER TABLE `projects_test_suite_script`
  ADD CONSTRAINT `projects_test_suite__script_id_693c565c_fk_projects_` FOREIGN KEY (`script_id`) REFERENCES `projects_script` (`id`),
  ADD CONSTRAINT `projects_test_suite__testsuite_id_1e061133_fk_projects_` FOREIGN KEY (`testsuite_id`) REFERENCES `projects_test_suite` (`id`);

--
-- Constraints for table `users_role`
--
ALTER TABLE `users_role`
  ADD CONSTRAINT `users_role_group_id_2bec884d_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `users_role_project_id_2837f877_fk_projects_project_id` FOREIGN KEY (`project_id`) REFERENCES `projects_project` (`id`),
  ADD CONSTRAINT `users_role_user_id_cbcc337e_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
