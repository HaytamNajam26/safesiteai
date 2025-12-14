import 'site.dart';
import 'user.dart';

enum IncidentType {
  observation,
  incident,
  nonConformite,
  accident;

  static IncidentType fromString(String value) {
    switch (value.toUpperCase()) {
      case 'OBSERVATION':
        return IncidentType.observation;
      case 'INCIDENT':
        return IncidentType.incident;
      case 'NON_CONFORMITE':
        return IncidentType.nonConformite;
      case 'ACCIDENT':
        return IncidentType.accident;
      default:
        return IncidentType.observation;
    }
  }

  String toApiString() {
    switch (this) {
      case IncidentType.observation:
        return 'OBSERVATION';
      case IncidentType.incident:
        return 'INCIDENT';
      case IncidentType.nonConformite:
        return 'NON_CONFORMITE';
      case IncidentType.accident:
        return 'ACCIDENT';
    }
  }
}

enum Severity {
  faible,
  moyenne,
  elevee;

  static Severity fromString(String value) {
    switch (value.toUpperCase()) {
      case 'FAIBLE':
        return Severity.faible;
      case 'MOYENNE':
        return Severity.moyenne;
      case 'ELEVEE':
        return Severity.elevee;
      default:
        return Severity.moyenne;
    }
  }

  String toApiString() {
    switch (this) {
      case Severity.faible:
        return 'FAIBLE';
      case Severity.moyenne:
        return 'MOYENNE';
      case Severity.elevee:
        return 'ELEVEE';
    }
  }
}

class Incident {
  final int? id;
  final IncidentType type;
  final String description;
  final Severity severity;
  final String? location;
  final String? photoUrl;
  final int? siteId;
  final Site? site;
  final int? reportedById;
  final User? reportedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Incident({
    this.id,
    required this.type,
    required this.description,
    required this.severity,
    this.location,
    this.photoUrl,
    this.siteId,
    this.site,
    this.reportedById,
    this.reportedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Incident.fromJson(Map<String, dynamic> json) {
    return Incident(
      id: json['id'],
      type: IncidentType.fromString(json['type'] ?? 'OBSERVATION'),
      description: json['description'] ?? '',
      severity: Severity.fromString(json['severity'] ?? 'MOYENNE'),
      location: json['location'],
      photoUrl: json['photoUrl'],
      siteId: json['site'] != null ? json['site']['id'] : json['siteId'],
      site: json['site'] != null ? Site.fromJson(json['site']) : null,
      reportedById: json['reportedBy'] != null
          ? json['reportedBy']['id']
          : json['reportedById'],
      reportedBy:
          json['reportedBy'] != null ? User.fromJson(json['reportedBy']) : null,
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
      'type': type.toApiString(),
      'description': description,
      'severity': severity.toApiString(),
      'location': location,
      'photoUrl': photoUrl,
      'site': siteId != null ? {'id': siteId} : site?.toJson(),
    };
  }
}

