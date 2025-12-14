import 'project.dart';

class Site {
  final int? id;
  final String name;
  final String? siteType;
  final String? description;
  final int? projectId;
  final Project? project;
  final List<String>? photoUrls;
  final double? riskScore;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Site({
    this.id,
    required this.name,
    this.siteType,
    this.description,
    this.projectId,
    this.project,
    this.photoUrls,
    this.riskScore,
    this.createdAt,
    this.updatedAt,
  });

  factory Site.fromJson(Map<String, dynamic> json) {
    return Site(
      id: json['id'],
      name: json['name'] ?? '',
      siteType: json['siteType'],
      description: json['description'],
      projectId: json['project'] != null ? json['project']['id'] : json['projectId'],
      project: json['project'] != null ? Project.fromJson(json['project']) : null,
      photoUrls: json['photoUrls'] != null
          ? List<String>.from(json['photoUrls'])
          : null,
      riskScore: json['riskScore'] != null
          ? (json['riskScore'] is double
              ? json['riskScore']
              : double.tryParse(json['riskScore'].toString()))
          : null,
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
      'siteType': siteType,
      'description': description,
      'project': projectId != null ? {'id': projectId} : project?.toJson(),
      'photoUrls': photoUrls,
      'riskScore': riskScore,
    };
  }
}

