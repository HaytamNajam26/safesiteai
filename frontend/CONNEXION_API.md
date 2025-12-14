# Guide de Connexion Frontend-Backend

## Configuration

Le frontend est maintenant connecté au backend Spring Boot via l'API REST.

### URL du Backend

L'URL du backend est configurée dans `lib/core/config/api_config.dart` :
```dart
static const String baseUrl = 'http://localhost:8080/api';
```

### Dépendances ajoutées

- `http: ^1.1.0` - Pour les requêtes HTTP
- `shared_preferences: ^2.2.2` - Pour stocker le token JWT localement

## Services créés

### 1. ApiService (`lib/core/services/api_service.dart`)
Service générique pour toutes les requêtes HTTP (GET, POST, PUT, DELETE)

### 2. AuthService (`lib/core/services/auth_service.dart`)
Service spécialisé pour l'authentification :
- `login()` - Connexion utilisateur
- `logout()` - Déconnexion
- `isLoggedIn()` - Vérifier si connecté
- `getToken()` - Obtenir le token JWT

### 3. StorageService (`lib/core/services/storage_service.dart`)
Service pour le stockage local :
- Sauvegarde du token JWT
- Sauvegarde des informations utilisateur
- Gestion de la session

## Modèles de données

- `User` - Modèle utilisateur
- `LoginRequest` - Requête de connexion
- `LoginResponse` - Réponse de connexion avec token

## Utilisation

### Connexion

L'écran de login (`lib/features/auth/login_screen.dart`) utilise maintenant l'API :

```dart
final request = LoginRequest(email: email, password: password);
final response = await AuthService.login(request);
```

### Utilisateurs de test

- **Admin** : `admin@safesite.ai` / `admin123`
- **Chef** : `chef@safesite.ai` / `chef123`

## Prochaines étapes

Pour connecter les autres écrans :

1. Créer des modèles pour chaque entité (Project, Site, Incident, etc.)
2. Créer des services pour chaque ressource
3. Mettre à jour les écrans pour utiliser ces services

Exemple pour les projets :
```dart
// Créer lib/core/models/project.dart
// Créer lib/core/services/project_service.dart
// Mettre à jour lib/features/projects/projects_list_screen.dart
```

## Test de la connexion

1. Démarrer le backend : `docker-compose up`
2. Démarrer le frontend : `flutter run -d chrome`
3. Se connecter avec les identifiants de test
4. Vérifier que le token est sauvegardé et que la redirection fonctionne

## Dépannage

### Erreur CORS
Vérifier que le backend accepte les requêtes depuis `http://localhost:3000`

### Erreur de connexion
- Vérifier que le backend est démarré sur le port 8080
- Vérifier l'URL dans `api_config.dart`
- Vérifier les logs du backend : `docker-compose logs backend`

### Token non sauvegardé
- Vérifier que `shared_preferences` est bien installé
- Vérifier les permissions de stockage

