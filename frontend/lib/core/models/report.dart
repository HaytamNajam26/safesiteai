import 'project.dart';
import 'site.dart';
import 'user.dart';

enum ReportType {
  daily,
  weekly,
  monthly,
  incident,
  safetyAudit;

  static ReportType fromString(String value) {
    switch (value.toUpperCase()) {
      case 'DAILY':
        return ReportType.daily;
      case 'WEEKLY':
        return ReportType.weekly;
      case 'MONTHLY':
        return ReportType.monthly;
      case 'INCIDENT':
        return ReportType.incident;
      case 'SAFETY_AUDIT':
        return ReportType.safetyAudit;
      default:
        return ReportType.daily;
    }
  }

  String toApiString() {
    switch (this) {
      case ReportType.daily:
        return 'DAILY';
      case ReportType.weekly:
        return 'WEEKLY';
      case ReportType.monthly:
        return 'MONTHLY';
      case ReportType.incident:
        return 'INCIDENT';
      case ReportType.safetyAudit:
        return 'SAFETY_AUDIT';
    }
  }
}

class Report {
  final int? id;
  final String title;
  final String? content;
  final ReportType reportType;
  final DateTime? reportDate;
  final int? projectId;
  final Project? project;
  final int? siteId;
  final Site? site;
  final int? createdById;
  final User? createdBy;
  final String? fileUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Report({
    this.id,
    required this.title,
    this.content,
    required this.reportType,
    this.reportDate,
    this.projectId,
    this.project,
    this.siteId,
    this.site,
    this.createdById,
    this.createdBy,
    this.fileUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      title: json['title'] ?? '',
      content: json['content'],
      reportType: ReportType.fromString(json['reportType'] ?? 'DAILY'),
      reportDate: json['reportDate'] != null
          ? DateTime.parse(json['reportDate'])
          : null,
      projectId:
          json['project'] != null ? json['project']['id'] : json['projectId'],
      project: json['project'] != null ? Project.fromJson(json['project']) : null,
      siteId: json['site'] != null ? json['site']['id'] : json['siteId'],
      site: json['site'] != null ? Site.fromJson(json['site']) : null,
      createdById:
          json['createdBy'] != null ? json['createdBy']['id'] : json['createdById'],
      createdBy:
          json['createdBy'] != null ? User.fromJson(json['createdBy']) : null,
      fileUrl: json['fileUrl'],
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
      'title': title,
      'content': content,
      'reportType': reportType.toApiString(),
      'reportDate': reportDate?.toIso8601String().split('T')[0],
      'project': projectId != null ? {'id': projectId} : project?.toJson(),
      'site': siteId != null ? {'id': siteId} : site?.toJson(),
      'fileUrl': fileUrl,
    };
  }
}

