class Manager {
  final int? id;
  final String firstName;
  final String lastName;
  final String? email;
  final String? phone;
  final String? department;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Manager({
    this.id,
    required this.firstName,
    required this.lastName,
    this.email,
    this.phone,
    this.department,
    this.createdAt,
    this.updatedAt,
  });

  factory Manager.fromJson(Map<String, dynamic> json) {
    return Manager(
      id: json['id'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'],
      phone: json['phone'],
      department: json['department'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'department': department,
    };
  }

  String get fullName => '$firstName $lastName';
}

