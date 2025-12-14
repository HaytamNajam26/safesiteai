# Guide des Services et Modèles

## Modèles créés

Tous les modèles sont dans `lib/core/models/` :

1. **User** - Utilisateur (Admin/Chef)
2. **Project** - Projet/Chantier
3. **Manager** - Manager de site
4. **Site** - Site de construction
5. **Incident** - Incident/Non-conformité
6. **Observation** - Rapport journalier
7. **Report** - Rapport généré

## Services créés

Tous les services sont dans `lib/core/services/` :

1. **ProjectService** - Gestion des projets
2. **ManagerService** - Gestion des managers
3. **SiteService** - Gestion des sites
4. **IncidentService** - Gestion des incidents
5. **ObservationService** - Gestion des observations
6. **ReportService** - Gestion des rapports

## Utilisation

### Exemple : Récupérer tous les projets

```dart
import 'package:safesite_ai/core/services/project_service.dart';
import 'package:safesite_ai/core/models/models.dart';

// Dans votre widget
Future<void> loadProjects() async {
  try {
    final projects = await ProjectService.getAllProjects();
    // Utiliser les projets
  } catch (e) {
    // Gérer l'erreur
  }
}
```

### Exemple : Créer un projet

```dart
import 'package:safesite_ai/core/services/project_service.dart';
import 'package:safesite_ai/core/models/models.dart';

final project = Project(
  name: 'Nouveau Projet',
  location: 'Paris',
  description: 'Description du projet',
  startDate: DateTime.now(),
  endDate: DateTime.now().add(Duration(days: 365)),
  estimatedSitesCount: 5,
);

try {
  final createdProject = await ProjectService.createProject(project);
  // Projet créé avec succès
} catch (e) {
  // Gérer l'erreur
}
```

### Exemple : Créer un incident

```dart
import 'package:safesite_ai/core/services/incident_service.dart';
import 'package:safesite_ai/core/models/models.dart';

final incident = Incident(
  type: IncidentType.observation,
  description: 'Description de l\'incident',
  severity: Severity.moyenne,
  location: 'Zone A',
  siteId: 1,
);

try {
  final createdIncident = await IncidentService.createIncident(incident);
  // Incident créé avec succès
} catch (e) {
  // Gérer l'erreur
}
```

## Méthodes disponibles pour chaque service

### ProjectService
- `getAllProjects()` - Liste tous les projets
- `getProjectById(int id)` - Récupère un projet
- `createProject(Project project)` - Crée un projet
- `updateProject(int id, Project project)` - Met à jour un projet
- `deleteProject(int id)` - Supprime un projet

### ManagerService
- `getAllManagers()` - Liste tous les managers
- `getManagerById(int id)` - Récupère un manager
- `createManager(Manager manager)` - Crée un manager
- `updateManager(int id, Manager manager)` - Met à jour un manager
- `deleteManager(int id)` - Supprime un manager

### SiteService
- `getAllSites()` - Liste tous les sites
- `getSitesByProject(int projectId)` - Liste les sites d'un projet
- `getSiteById(int id)` - Récupère un site
- `createSite(Site site)` - Crée un site
- `updateSite(int id, Site site)` - Met à jour un site
- `deleteSite(int id)` - Supprime un site

### IncidentService
- `getAllIncidents()` - Liste tous les incidents
- `getIncidentsBySite(int siteId)` - Liste les incidents d'un site
- `getIncidentsByUser()` - Liste les incidents de l'utilisateur connecté
- `getIncidentById(int id)` - Récupère un incident
- `createIncident(Incident incident)` - Crée un incident
- `updateIncident(int id, Incident incident)` - Met à jour un incident
- `deleteIncident(int id)` - Supprime un incident

### ObservationService
- `getAllObservations()` - Liste toutes les observations
- `getObservationsBySite(int siteId)` - Liste les observations d'un site
- `getObservationsByUser()` - Liste les observations de l'utilisateur connecté
- `getObservationById(int id)` - Récupère une observation
- `createObservation(Observation observation)` - Crée une observation
- `updateObservation(int id, Observation observation)` - Met à jour une observation
- `deleteObservation(int id)` - Supprime une observation

### ReportService
- `getAllReports()` - Liste tous les rapports
- `getReportsByProject(int projectId)` - Liste les rapports d'un projet
- `getReportsBySite(int siteId)` - Liste les rapports d'un site
- `getReportsByUser()` - Liste les rapports de l'utilisateur connecté
- `getReportById(int id)` - Récupère un rapport
- `createReport(Report report)` - Crée un rapport
- `updateReport(int id, Report report)` - Met à jour un rapport
- `deleteReport(int id)` - Supprime un rapport

## Gestion des erreurs

Tous les services lancent des exceptions en cas d'erreur. Utilisez try-catch pour les gérer :

```dart
try {
  final projects = await ProjectService.getAllProjects();
  // Traiter les données
} catch (e) {
  // Afficher un message d'erreur à l'utilisateur
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Erreur: ${e.toString()}'),
      backgroundColor: Colors.red,
    ),
  );
}
```

## Prochaines étapes

Maintenant que tous les modèles et services sont créés, vous pouvez :

1. Mettre à jour les écrans pour utiliser ces services
2. Remplacer les données mockées par des appels API réels
3. Ajouter la gestion de chargement (loading states)
4. Ajouter la gestion d'erreurs dans l'UI

