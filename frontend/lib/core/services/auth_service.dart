import '../config/api_config.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import 'api_service.dart';
import 'storage_service.dart';

class AuthService {
  // Connexion
  static Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await ApiService.post(
        ApiConfig.login,
        request.toJson(),
      );

      final loginResponse = LoginResponse.fromJson(response);

      // Sauvegarder le token et les infos utilisateur
      await StorageService.saveToken(loginResponse.token);
      await StorageService.saveUserInfo(
        email: loginResponse.user.email,
        role: loginResponse.user.role,
        userId: loginResponse.user.id ?? 0,
      );

      return loginResponse;
    } catch (e) {
      throw Exception('Erreur de connexion: ${e.toString()}');
    }
  }

  // Déconnexion
  static Future<void> logout() async {
    await StorageService.logout();
  }

  // Vérifier si l'utilisateur est connecté
  static Future<bool> isLoggedIn() async {
    return await StorageService.isLoggedIn();
  }

  // Obtenir le token actuel
  static Future<String?> getToken() async {
    return await StorageService.getToken();
  }
}

