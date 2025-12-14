class User {
  final int? id;
  final String email;
  final String role; // 'ADMIN' or 'CHEF'
  final String? firstName;
  final String? lastName;

  User({
    this.id,
    required this.email,
    required this.role,
    this.firstName,
    this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['userId'] != null ? (json['userId'] is int ? json['userId'] : int.parse(json['userId'].toString())) : null,
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }

  bool get isAdmin => role == 'ADMIN';
  bool get isChef => role == 'CHEF';
}

