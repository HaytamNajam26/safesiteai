import 'site.dart';
import 'user.dart';

class Observation {
  final int? id;
  final DateTime? observationDate;
  final int? siteId;
  final Site? site;
  final int? createdById;
  final User? createdBy;
  final double? temperature;
  final double? humidity;
  final int? workersPresent;
  final int? hoursWorked;
  final List<String>? activities;
  final double? epiCompliance;
  final double? equipmentState;
  final double? siteClean;
  final double? fatigueLevel;
  final int? minorIncidents;
  final int? majorIncidents;
  final String? notes;
  final List<String>? photoUrls;
  final String? aiAnalysis;
  final double? riskScore;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Observation({
    this.id,
    this.observationDate,
    this.siteId,
    this.site,
    this.createdById,
    this.createdBy,
    this.temperature,
    this.humidity,
    this.workersPresent,
    this.hoursWorked,
    this.activities,
    this.epiCompliance,
    this.equipmentState,
    this.siteClean,
    this.fatigueLevel,
    this.minorIncidents,
    this.majorIncidents,
    this.notes,
    this.photoUrls,
    this.aiAnalysis,
    this.riskScore,
    this.createdAt,
    this.updatedAt,
  });

  factory Observation.fromJson(Map<String, dynamic> json) {
    return Observation(
      id: json['id'],
      observationDate: json['observationDate'] != null
          ? DateTime.parse(json['observationDate'])
          : null,
      siteId: json['site'] != null ? json['site']['id'] : json['siteId'],
      site: json['site'] != null ? Site.fromJson(json['site']) : null,
      createdById:
          json['createdBy'] != null ? json['createdBy']['id'] : json['createdById'],
      createdBy:
          json['createdBy'] != null ? User.fromJson(json['createdBy']) : null,
      temperature: json['temperature'] != null
          ? (json['temperature'] is double
              ? json['temperature']
              : double.tryParse(json['temperature'].toString()))
          : null,
      humidity: json['humidity'] != null
          ? (json['humidity'] is double
              ? json['humidity']
              : double.tryParse(json['humidity'].toString()))
          : null,
      workersPresent: json['workersPresent'],
      hoursWorked: json['hoursWorked'],
      activities: json['activities'] != null
          ? List<String>.from(json['activities'])
          : null,
      epiCompliance: json['epiCompliance'] != null
          ? (json['epiCompliance'] is double
              ? json['epiCompliance']
              : double.tryParse(json['epiCompliance'].toString()))
          : null,
      equipmentState: json['equipmentState'] != null
          ? (json['equipmentState'] is double
              ? json['equipmentState']
              : double.tryParse(json['equipmentState'].toString()))
          : null,
      siteClean: json['siteClean'] != null
          ? (json['siteClean'] is double
              ? json['siteClean']
              : double.tryParse(json['siteClean'].toString()))
          : null,
      fatigueLevel: json['fatigueLevel'] != null
          ? (json['fatigueLevel'] is double
              ? json['fatigueLevel']
              : double.tryParse(json['fatigueLevel'].toString()))
          : null,
      minorIncidents: json['minorIncidents'],
      majorIncidents: json['majorIncidents'],
      notes: json['notes'],
      photoUrls: json['photoUrls'] != null
          ? List<String>.from(json['photoUrls'])
          : null,
      aiAnalysis: json['aiAnalysis'],
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
      'observationDate': observationDate?.toIso8601String().split('T')[0],
      'site': siteId != null ? {'id': siteId} : site?.toJson(),
      'temperature': temperature,
      'humidity': humidity,
      'workersPresent': workersPresent,
      'hoursWorked': hoursWorked,
      'activities': activities,
      'epiCompliance': epiCompliance,
      'equipmentState': equipmentState,
      'siteClean': siteClean,
      'fatigueLevel': fatigueLevel,
      'minorIncidents': minorIncidents,
      'majorIncidents': majorIncidents,
      'notes': notes,
      'photoUrls': photoUrls,
      'aiAnalysis': aiAnalysis,
      'riskScore': riskScore,
    };
  }
}

