import '../config/api_config.dart';
import '../models/observation.dart';
import 'api_service.dart';

class ObservationService {
  // Récupérer toutes les observations
  static Future<List<Observation>> getAllObservations() async {
    try {
      final response = await ApiService.getList(ApiConfig.observations);
      return response.map((json) => Observation.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Erreur lors de la récupération des observations: $e');
    }
  }

  // Récupérer les observations d'un site
  static Future<List<Observation>> getObservationsBySite(int siteId) async {
    try {
      final response = await ApiService.getList('${ApiConfig.observations}/site/$siteId');
      return response.map((json) => Observation.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Erreur lors de la récupération des observations du site: $e');
    }
  }

  // Récupérer les observations de l'utilisateur connecté
  static Future<List<Observation>> getObservationsByUser() async {
    try {
      final response = await ApiService.getList('${ApiConfig.observations}/user');
      return response.map((json) => Observation.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Erreur lors de la récupération des observations de l\'utilisateur: $e');
    }
  }

  // Récupérer une observation par ID
  static Future<Observation> getObservationById(int id) async {
    try {
      final response = await ApiService.get('${ApiConfig.observations}/$id');
      return Observation.fromJson(response);
    } catch (e) {
      throw Exception('Erreur lors de la récupération de l\'observation: $e');
    }
  }

  // Créer une observation
  static Future<Observation> createObservation(Observation observation) async {
    try {
      final response = await ApiService.post(ApiConfig.observations, observation.toJson());
      return Observation.fromJson(response);
    } catch (e) {
      throw Exception('Erreur lors de la création de l\'observation: $e');
    }
  }

  // Mettre à jour une observation
  static Future<Observation> updateObservation(int id, Observation observation) async {
    try {
      final response = await ApiService.put('${ApiConfig.observations}/$id', observation.toJson());
      return Observation.fromJson(response);
    } catch (e) {
      throw Exception('Erreur lors de la mise à jour de l\'observation: $e');
    }
  }

  // Supprimer une observation
  static Future<void> deleteObservation(int id) async {
    try {
      await ApiService.delete('${ApiConfig.observations}/$id');
    } catch (e) {
      throw Exception('Erreur lors de la suppression de l\'observation: $e');
    }
  }
}

