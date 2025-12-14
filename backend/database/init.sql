-- Script d'initialisation de la base de données SafeSite
-- Ce script est optionnel car Hibernate crée automatiquement les tables
-- avec ddl-auto=update

-- Créer la base de données (à exécuter dans MySQL Workbench)
CREATE DATABASE IF NOT EXISTS safesite_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE safesite_db;

-- Les utilisateurs seront créés automatiquement par DataInitializer au démarrage
-- Admin: admin@safesite.ai / admin123
-- Chef: chef@safesite.ai / chef123

