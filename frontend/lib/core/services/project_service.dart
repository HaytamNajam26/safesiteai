import '../config/api_config.dart';
import '../models/project.dart';
import 'api_service.dart';

class ProjectService {
  // Récupérer tous les projets
  static Future<List<Project>> getAllProjects() async {
    try {
      final response = await ApiService.getList(ApiConfig.projects);
      return response.map((json) => Project.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Erreur lors de la récupération des projets: $e');
    }
  }

  // Récupérer un projet par ID
  static Future<Project> getProjectById(int id) async {
    try {
      final response = await ApiService.get('${ApiConfig.projects}/$id');
      return Project.fromJson(response);
    } catch (e) {
      throw Exception('Erreur lors de la récupération du projet: $e');
    }
  }

  // Créer un projet
  static Future<Project> createProject(Project project) async {
    try {
      final response = await ApiService.post(ApiConfig.projects, project.toJson());
      return Project.fromJson(response);
    } catch (e) {
      throw Exception('Erreur lors de la création du projet: $e');
    }
  }

  // Mettre à jour un projet
  static Future<Project> updateProject(int id, Project project) async {
    try {
      final response = await ApiService.put('${ApiConfig.projects}/$id', project.toJson());
      return Project.fromJson(response);
    } catch (e) {
      throw Exception('Erreur lors de la mise à jour du projet: $e');
    }
  }

  // Supprimer un projet
  static Future<void> deleteProject(int id) async {
    try {
      await ApiService.delete('${ApiConfig.projects}/$id');
    } catch (e) {
      throw Exception('Erreur lors de la suppression du projet: $e');
    }
  }
}

