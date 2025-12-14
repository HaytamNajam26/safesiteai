import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import 'storage_service.dart';

class ApiService {
  // Méthode générique pour les requêtes GET
  static Future<Map<String, dynamic>> get(String endpoint) async {
    final token = await StorageService.getToken();
    final response = await http.get(
      Uri.parse(endpoint),
      headers: ApiConfig.getHeaders(token),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  // Méthode générique pour les requêtes GET qui retournent une liste
  static Future<List<dynamic>> getList(String endpoint) async {
    final token = await StorageService.getToken();
    final response = await http.get(
      Uri.parse(endpoint),
      headers: ApiConfig.getHeaders(token),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as List<dynamic>;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  // Méthode générique pour les requêtes POST
  static Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    final token = await StorageService.getToken();
    final response = await http.post(
      Uri.parse(endpoint),
      headers: ApiConfig.getHeaders(token),
      body: json.encode(data),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return {};
      }
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      final errorBody = response.body.isNotEmpty
          ? json.decode(response.body)
          : {'message': 'Unknown error'};
      throw Exception(
        errorBody['message'] ?? 'Failed to post data: ${response.statusCode}',
      );
    }
  }

  // Méthode générique pour les requêtes PUT
  static Future<Map<String, dynamic>> put(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    final token = await StorageService.getToken();
    final response = await http.put(
      Uri.parse(endpoint),
      headers: ApiConfig.getHeaders(token),
      body: json.encode(data),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return {};
      }
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to update data: ${response.statusCode}');
    }
  }

  // Méthode générique pour les requêtes DELETE
  static Future<void> delete(String endpoint) async {
    final token = await StorageService.getToken();
    final response = await http.delete(
      Uri.parse(endpoint),
      headers: ApiConfig.getHeaders(token),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Failed to delete data: ${response.statusCode}');
    }
  }
}

