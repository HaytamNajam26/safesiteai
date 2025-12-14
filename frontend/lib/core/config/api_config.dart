class ApiConfig {
  // URL du backend - changez selon votre environnement
  static const String baseUrl = 'http://localhost:8080/api';
  
  // Endpoints
  static const String login = '$baseUrl/auth/login';
  static const String projects = '$baseUrl/projects';
  static const String sites = '$baseUrl/sites';
  static const String managers = '$baseUrl/managers';
  static const String incidents = '$baseUrl/incidents';
  static const String observations = '$baseUrl/observations';
  static const String reports = '$baseUrl/reports';
  
  // Headers
  static Map<String, String> getHeaders(String? token) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    
    return headers;
  }
}

