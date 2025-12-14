# Guide de dépannage - Erreurs de connexion

## Erreur "Failed to fetch" ou "ClientFailed to fetch"

### Problème
Le frontend Flutter web ne peut pas se connecter au backend Spring Boot.

### Solutions

#### 1. Vérifier que le backend est démarré
```bash
docker-compose ps
```

Le backend doit être en statut "Up" et "healthy".

#### 2. Vérifier les logs du backend
```bash
docker-compose logs backend
```

#### 3. Vérifier l'URL du backend
Dans `frontend/lib/core/config/api_config.dart`, l'URL doit être :
```dart
static const String baseUrl = 'http://localhost:8080/api';
```

#### 4. Problème de CORS
Si vous voyez des erreurs CORS dans la console du navigateur :
- Le backend a été configuré pour accepter toutes les origines en développement
- Redémarrer le backend : `docker-compose restart backend`

#### 5. Vérifier que le port 8080 n'est pas utilisé
```bash
netstat -ano | findstr :8080
```

#### 6. Tester l'API directement
Ouvrez votre navigateur et allez sur :
```
http://localhost:8080/api/auth/login
```

Vous devriez voir une erreur (c'est normal, c'est une requête GET), mais cela confirme que le backend répond.

#### 7. Reconstruire les conteneurs
Si les changements ne sont pas pris en compte :
```bash
docker-compose down
docker-compose up --build -d
```

### Erreurs courantes

#### "Request method 'GET' is not supported"
- Le backend reçoit une requête GET au lieu de POST
- Vérifier que le code frontend utilise bien `ApiService.post()`

#### "Connection refused"
- Le backend n'est pas démarré
- Vérifier avec `docker-compose ps`

#### "CORS policy"
- Le backend n'accepte pas l'origine du frontend
- Vérifier la configuration CORS dans `SecurityConfig.java`

### Test de connexion

Pour tester si le backend répond :
```bash
# PowerShell
Invoke-WebRequest -Uri "http://localhost:8080/api/auth/login" -Method OPTIONS
```

Si cela fonctionne, le backend est accessible.

