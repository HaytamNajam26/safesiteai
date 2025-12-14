# SafeSite AI - Projet PFA

Application de gestion de sécurité sur les chantiers avec intelligence artificielle.

## Architecture

- **Frontend** : Flutter (Web)
- **Backend** : Spring Boot (REST API)
- **Base de données** : MySQL 8.0

## Prérequis

- Docker et Docker Compose installés
- Git

## Démarrage rapide avec Docker

### 1. Cloner le projet (si nécessaire)
```bash
git clone https://github.com/HaytamNajam26/safesiteai.git
cd safesiteai
```

### 2. Lancer tous les services
```bash
docker-compose up --build
```

Cette commande va :
- Construire les images Docker pour le frontend et le backend
- Démarrer MySQL avec la base de données `safesite_db`
- Démarrer le backend Spring Boot sur le port 8080
- Démarrer le frontend Flutter sur le port 3000

### 3. Accéder à l'application

- **Frontend** : http://localhost:3000
- **Backend API** : http://localhost:8080
- **MySQL** : localhost:3306

### 4. Arrêter les services
```bash
docker-compose down
```

Pour supprimer aussi les volumes (base de données) :
```bash
docker-compose down -v
```

## Utilisateurs par défaut

L'application crée automatiquement deux utilisateurs au démarrage :

- **Admin** :
  - Email: `admin@safesite.ai`
  - Password: `admin123`
  - Role: ADMIN

- **Chef** :
  - Email: `chef@safesite.ai`
  - Password: `chef123`
  - Role: CHEF

## Commandes Docker utiles

### Voir les logs
```bash
# Tous les services
docker-compose logs -f

# Un service spécifique
docker-compose logs -f backend
docker-compose logs -f frontend
docker-compose logs -f mysql
```

### Redémarrer un service
```bash
docker-compose restart backend
```

### Reconstruire après modification du code
```bash
docker-compose up --build
```

### Accéder au shell d'un conteneur
```bash
# Backend
docker-compose exec backend sh

# MySQL
docker-compose exec mysql mysql -u safesite_user -psafesite_password safesite_db
```

## Développement local (sans Docker)

### Backend

1. Installer Java 17 et Maven
2. Installer MySQL et créer la base de données
3. Modifier `backend/src/main/resources/application.properties`
4. Lancer :
```bash
cd backend
mvn spring-boot:run
```

### Frontend

1. Installer Flutter
2. Lancer :
```bash
cd frontend
flutter pub get
flutter run -d chrome
```

## Structure du projet

```
projet-pfa/
├── frontend/          # Application Flutter
│   ├── lib/
│   ├── Dockerfile
│   └── nginx.conf
├── backend/           # API Spring Boot
│   ├── src/
│   ├── Dockerfile
│   └── database/
└── docker-compose.yml # Orchestration Docker
```

## API Endpoints

Voir `backend/README.md` pour la documentation complète de l'API.

## Troubleshooting

### Le backend ne peut pas se connecter à MySQL
- Vérifiez que le conteneur MySQL est démarré : `docker-compose ps`
- Vérifiez les logs : `docker-compose logs mysql`

### Le frontend ne peut pas accéder au backend
- Vérifiez que le backend est démarré : `docker-compose ps`
- Vérifiez les logs : `docker-compose logs backend`
- Vérifiez la configuration CORS dans `application.properties`

### Ports déjà utilisés
Modifiez les ports dans `docker-compose.yml` si nécessaire.

## Support

Pour toute question ou problème, consultez la documentation dans les dossiers `frontend/` et `backend/`.

