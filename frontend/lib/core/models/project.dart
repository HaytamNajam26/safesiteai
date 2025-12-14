import 'manager.dart';

class Project {
  final int? id;
  final String name;
  final String? location;
  final String? description;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? estimatedSitesCount;
  final Manager? manager;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Project({
    this.id,
    required this.name,
    this.location,
    this.description,
    this.startDate,
    this.endDate,
    this.estimatedSitesCount,
    this.manager,
    this.createdAt,
    this.updatedAt,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'] ?? '',
      location: json['location'],
      description: json['description'],
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'])
          : null,
      endDate:
          json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      estimatedSitesCount: json['estimatedSitesCount'],
      manager: json['manager'] != null ? Manager.fromJson(json['manager']) : null,
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
      'name': name,
      'location': location,
      'description': description,
      'startDate': startDate?.toIso8601String().split('T')[0],
      'endDate': endDate?.toIso8601String().split('T')[0],
      'estimatedSitesCount': estimatedSitesCount,
      'manager': manager?.toJson(),
    };
  }
}

