# SafeSite Backend API

Backend Spring Boot pour l'application SafeSite AI.

## Prérequis

- Java 17 ou supérieur
- Maven 3.6+
- PostgreSQL 12+

## Configuration de la base de données

1. Installer PostgreSQL si ce n'est pas déjà fait
2. Créer une base de données :
```sql
CREATE DATABASE safesite_db;
```

3. Modifier les paramètres de connexion dans `src/main/resources/application.properties` :
```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/safesite_db
spring.datasource.username=postgres
spring.datasource.password=votre_mot_de_passe
```

## Installation et lancement

1. Compiler le projet :
```bash
mvn clean install
```

2. Lancer l'application :
```bash
mvn spring-boot:run
```

L'API sera accessible sur `http://localhost:8080`

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

⚠️ **Important** : Changez ces mots de passe en production !

## Endpoints API

### Authentification
- `POST /api/auth/login` - Connexion (retourne un JWT token)

### Projets
- `GET /api/projects` - Liste des projets
- `GET /api/projects/{id}` - Détails d'un projet
- `POST /api/projects` - Créer un projet
- `PUT /api/projects/{id}` - Modifier un projet
- `DELETE /api/projects/{id}` - Supprimer un projet

### Sites
- `GET /api/sites` - Liste des sites
- `GET /api/sites/project/{projectId}` - Sites d'un projet
- `GET /api/sites/{id}` - Détails d'un site
- `POST /api/sites` - Créer un site
- `PUT /api/sites/{id}` - Modifier un site
- `DELETE /api/sites/{id}` - Supprimer un site

### Managers
- `GET /api/managers` - Liste des managers
- `GET /api/managers/{id}` - Détails d'un manager
- `POST /api/managers` - Créer un manager
- `PUT /api/managers/{id}` - Modifier un manager
- `DELETE /api/managers/{id}` - Supprimer un manager

### Incidents
- `GET /api/incidents` - Liste des incidents
- `GET /api/incidents/site/{siteId}` - Incidents d'un site
- `GET /api/incidents/user` - Incidents de l'utilisateur connecté
- `GET /api/incidents/{id}` - Détails d'un incident
- `POST /api/incidents` - Créer un incident
- `PUT /api/incidents/{id}` - Modifier un incident
- `DELETE /api/incidents/{id}` - Supprimer un incident

### Observations
- `GET /api/observations` - Liste des observations
- `GET /api/observations/site/{siteId}` - Observations d'un site
- `GET /api/observations/user` - Observations de l'utilisateur connecté
- `GET /api/observations/{id}` - Détails d'une observation
- `POST /api/observations` - Créer une observation
- `PUT /api/observations/{id}` - Modifier une observation
- `DELETE /api/observations/{id}` - Supprimer une observation

### Rapports
- `GET /api/reports` - Liste des rapports
- `GET /api/reports/project/{projectId}` - Rapports d'un projet
- `GET /api/reports/site/{siteId}` - Rapports d'un site
- `GET /api/reports/user` - Rapports de l'utilisateur connecté
- `GET /api/reports/{id}` - Détails d'un rapport
- `POST /api/reports` - Créer un rapport
- `PUT /api/reports/{id}` - Modifier un rapport
- `DELETE /api/reports/{id}` - Supprimer un rapport

## Authentification

Tous les endpoints (sauf `/api/auth/login`) nécessitent un token JWT dans le header :
```
Authorization: Bearer <token>
```

Le token est obtenu lors de la connexion via `/api/auth/login`.

## Structure du projet

```
backend/
├── src/
│   ├── main/
│   │   ├── java/com/safesite/
│   │   │   ├── config/          # Configuration (Security, CORS, etc.)
│   │   │   ├── controller/     # Contrôleurs REST
│   │   │   ├── dto/            # Data Transfer Objects
│   │   │   ├── model/          # Entités JPA
│   │   │   ├── repository/     # Repositories JPA
│   │   │   ├── security/       # Filtres de sécurité
│   │   │   ├── service/        # Services métier
│   │   │   └── util/           # Utilitaires (JWT, etc.)
│   │   └── resources/
│   │       └── application.properties
│   └── test/
└── pom.xml
```

## Notes

- La base de données est créée automatiquement au premier lancement (Hibernate `ddl-auto=update`)
- Les mots de passe sont hashés avec BCrypt
- CORS est configuré pour permettre les requêtes depuis le frontend Flutter

