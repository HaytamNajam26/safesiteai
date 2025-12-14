import '../config/api_config.dart';
import '../models/manager.dart';
import 'api_service.dart';

class ManagerService {
  // Récupérer tous les managers
  static Future<List<Manager>> getAllManagers() async {
    try {
      final response = await ApiService.getList(ApiConfig.managers);
      return response.map((json) => Manager.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Erreur lors de la récupération des managers: $e');
    }
  }

  // Récupérer un manager par ID
  static Future<Manager> getManagerById(int id) async {
    try {
      final response = await ApiService.get('${ApiConfig.managers}/$id');
      return Manager.fromJson(response);
    } catch (e) {
      throw Exception('Erreur lors de la récupération du manager: $e');
    }
  }

  // Créer un manager
  static Future<Manager> createManager(Manager manager) async {
    try {
      final response = await ApiService.post(ApiConfig.managers, manager.toJson());
      return Manager.fromJson(response);
    } catch (e) {
      throw Exception('Erreur lors de la création du manager: $e');
    }
  }

  // Mettre à jour un manager
  static Future<Manager> updateManager(int id, Manager manager) async {
    try {
      final response = await ApiService.put('${ApiConfig.managers}/$id', manager.toJson());
      return Manager.fromJson(response);
    } catch (e) {
      throw Exception('Erreur lors de la mise à jour du manager: $e');
    }
  }

  // Supprimer un manager
  static Future<void> deleteManager(int id) async {
    try {
      await ApiService.delete('${ApiConfig.managers}/$id');
    } catch (e) {
      throw Exception('Erreur lors de la suppression du manager: $e');
    }
  }
}

