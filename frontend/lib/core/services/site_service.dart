import '../config/api_config.dart';
import '../models/site.dart';
import 'api_service.dart';

class SiteService {
  // Récupérer tous les sites
  static Future<List<Site>> getAllSites() async {
    try {
      final response = await ApiService.getList(ApiConfig.sites);
      return response.map((json) => Site.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Erreur lors de la récupération des sites: $e');
    }
  }

  // Récupérer les sites d'un projet
  static Future<List<Site>> getSitesByProject(int projectId) async {
    try {
      final response = await ApiService.getList('${ApiConfig.sites}/project/$projectId');
      return response.map((json) => Site.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Erreur lors de la récupération des sites du projet: $e');
    }
  }

  // Récupérer un site par ID
  static Future<Site> getSiteById(int id) async {
    try {
      final response = await ApiService.get('${ApiConfig.sites}/$id');
      return Site.fromJson(response);
    } catch (e) {
      throw Exception('Erreur lors de la récupération du site: $e');
    }
  }

  // Créer un site
  static Future<Site> createSite(Site site) async {
    try {
      final response = await ApiService.post(ApiConfig.sites, site.toJson());
      return Site.fromJson(response);
    } catch (e) {
      throw Exception('Erreur lors de la création du site: $e');
    }
  }

  // Mettre à jour un site
  static Future<Site> updateSite(int id, Site site) async {
    try {
      final response = await ApiService.put('${ApiConfig.sites}/$id', site.toJson());
      return Site.fromJson(response);
    } catch (e) {
      throw Exception('Erreur lors de la mise à jour du site: $e');
    }
  }

  // Supprimer un site
  static Future<void> deleteSite(int id) async {
    try {
      await ApiService.delete('${ApiConfig.sites}/$id');
    } catch (e) {
      throw Exception('Erreur lors de la suppression du site: $e');
    }
  }
}

