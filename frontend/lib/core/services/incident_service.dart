import '../config/api_config.dart';
import '../models/incident.dart';
import 'api_service.dart';

class IncidentService {
  // Récupérer tous les incidents
  static Future<List<Incident>> getAllIncidents() async {
    try {
      final response = await ApiService.getList(ApiConfig.incidents);
      return response.map((json) => Incident.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Erreur lors de la récupération des incidents: $e');
    }
  }

  // Récupérer les incidents d'un site
  static Future<List<Incident>> getIncidentsBySite(int siteId) async {
    try {
      final response = await ApiService.getList('${ApiConfig.incidents}/site/$siteId');
      return response.map((json) => Incident.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Erreur lors de la récupération des incidents du site: $e');
    }
  }

  // Récupérer les incidents de l'utilisateur connecté
  static Future<List<Incident>> getIncidentsByUser() async {
    try {
      final response = await ApiService.getList('${ApiConfig.incidents}/user');
      return response.map((json) => Incident.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Erreur lors de la récupération des incidents de l\'utilisateur: $e');
    }
  }

  // Récupérer un incident par ID
  static Future<Incident> getIncidentById(int id) async {
    try {
      final response = await ApiService.get('${ApiConfig.incidents}/$id');
      return Incident.fromJson(response);
    } catch (e) {
      throw Exception('Erreur lors de la récupération de l\'incident: $e');
    }
  }

  // Créer un incident
  static Future<Incident> createIncident(Incident incident) async {
    try {
      final response = await ApiService.post(ApiConfig.incidents, incident.toJson());
      return Incident.fromJson(response);
    } catch (e) {
      throw Exception('Erreur lors de la création de l\'incident: $e');
    }
  }

  // Mettre à jour un incident
  static Future<Incident> updateIncident(int id, Incident incident) async {
    try {
      final response = await ApiService.put('${ApiConfig.incidents}/$id', incident.toJson());
      return Incident.fromJson(response);
    } catch (e) {
      throw Exception('Erreur lors de la mise à jour de l\'incident: $e');
    }
  }

  // Supprimer un incident
  static Future<void> deleteIncident(int id) async {
    try {
      await ApiService.delete('${ApiConfig.incidents}/$id');
    } catch (e) {
      throw Exception('Erreur lors de la suppression de l\'incident: $e');
    }
  }
}

