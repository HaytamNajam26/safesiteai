import '../config/api_config.dart';
import '../models/report.dart';
import 'api_service.dart';

class ReportService {
  // Récupérer tous les rapports
  static Future<List<Report>> getAllReports() async {
    try {
      final response = await ApiService.getList(ApiConfig.reports);
      return response.map((json) => Report.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Erreur lors de la récupération des rapports: $e');
    }
  }

  // Récupérer les rapports d'un projet
  static Future<List<Report>> getReportsByProject(int projectId) async {
    try {
      final response = await ApiService.getList('${ApiConfig.reports}/project/$projectId');
      return response.map((json) => Report.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Erreur lors de la récupération des rapports du projet: $e');
    }
  }

  // Récupérer les rapports d'un site
  static Future<List<Report>> getReportsBySite(int siteId) async {
    try {
      final response = await ApiService.getList('${ApiConfig.reports}/site/$siteId');
      return response.map((json) => Report.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Erreur lors de la récupération des rapports du site: $e');
    }
  }

  // Récupérer les rapports de l'utilisateur connecté
  static Future<List<Report>> getReportsByUser() async {
    try {
      final response = await ApiService.getList('${ApiConfig.reports}/user');
      return response.map((json) => Report.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Erreur lors de la récupération des rapports de l\'utilisateur: $e');
    }
  }

  // Récupérer un rapport par ID
  static Future<Report> getReportById(int id) async {
    try {
      final response = await ApiService.get('${ApiConfig.reports}/$id');
      return Report.fromJson(response);
    } catch (e) {
      throw Exception('Erreur lors de la récupération du rapport: $e');
    }
  }

  // Créer un rapport
  static Future<Report> createReport(Report report) async {
    try {
      final response = await ApiService.post(ApiConfig.reports, report.toJson());
      return Report.fromJson(response);
    } catch (e) {
      throw Exception('Erreur lors de la création du rapport: $e');
    }
  }

  // Mettre à jour un rapport
  static Future<Report> updateReport(int id, Report report) async {
    try {
      final response = await ApiService.put('${ApiConfig.reports}/$id', report.toJson());
      return Report.fromJson(response);
    } catch (e) {
      throw Exception('Erreur lors de la mise à jour du rapport: $e');
    }
  }

  // Supprimer un rapport
  static Future<void> deleteReport(int id) async {
    try {
      await ApiService.delete('${ApiConfig.reports}/$id');
    } catch (e) {
      throw Exception('Erreur lors de la suppression du rapport: $e');
    }
  }
}

