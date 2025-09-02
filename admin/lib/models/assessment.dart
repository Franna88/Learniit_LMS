import 'package:flutter/material.dart';

enum AssessmentStepType {
  checklist,
  booking,
  upload,
}

enum AssessmentStatus {
  pending,
  inProgress,
  completed,
  failed,
}

extension AssessmentStepTypeExtension on AssessmentStepType {
  String get displayName {
    switch (this) {
      case AssessmentStepType.checklist:
        return 'Checklist';
      case AssessmentStepType.booking:
        return 'Booking';
      case AssessmentStepType.upload:
        return 'Upload';
    }
  }

  IconData get icon {
    switch (this) {
      case AssessmentStepType.checklist:
        return Icons.checklist;
      case AssessmentStepType.booking:
        return Icons.calendar_today;
      case AssessmentStepType.upload:
        return Icons.cloud_upload;
    }
  }
}

extension AssessmentStatusExtension on AssessmentStatus {
  String get displayName {
    switch (this) {
      case AssessmentStatus.pending:
        return 'Pending';
      case AssessmentStatus.inProgress:
        return 'In Progress';
      case AssessmentStatus.completed:
        return 'Completed';
      case AssessmentStatus.failed:
        return 'Failed';
    }
  }

  Color get color {
    switch (this) {
      case AssessmentStatus.pending:
        return Colors.grey;
      case AssessmentStatus.inProgress:
        return Colors.blue;
      case AssessmentStatus.completed:
        return Colors.green;
      case AssessmentStatus.failed:
        return Colors.red;
    }
  }
}

class AssessmentStep {
  final String id;
  final String title;
  final String description;
  final AssessmentStepType type;
  final bool isCompleted;
  final DateTime? completedAt;

  AssessmentStep({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    this.isCompleted = false,
    this.completedAt,
  });

  AssessmentStep copyWith({
    String? id,
    String? title,
    String? description,
    AssessmentStepType? type,
    bool? isCompleted,
    DateTime? completedAt,
  }) {
    return AssessmentStep(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type.index,
      'isCompleted': isCompleted,
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  factory AssessmentStep.fromJson(Map<String, dynamic> json) {
    return AssessmentStep(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      type: AssessmentStepType.values[json['type']],
      isCompleted: json['isCompleted'],
      completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt']) : null,
    );
  }
}

class Assessment {
  final String id;
  final String competencyId;
  final String title;
  final String description;
  final List<AssessmentStep> steps;
  final AssessmentStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Assessment({
    required this.id,
    required this.competencyId,
    required this.title,
    required this.description,
    required this.steps,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  Assessment copyWith({
    String? id,
    String? competencyId,
    String? title,
    String? description,
    List<AssessmentStep>? steps,
    AssessmentStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Assessment(
      id: id ?? this.id,
      competencyId: competencyId ?? this.competencyId,
      title: title ?? this.title,
      description: description ?? this.description,
      steps: steps ?? this.steps,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'competencyId': competencyId,
      'title': title,
      'description': description,
      'steps': steps.map((step) => step.toJson()).toList(),
      'status': status.index,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Assessment.fromJson(Map<String, dynamic> json) {
    return Assessment(
      id: json['id'],
      competencyId: json['competencyId'],
      title: json['title'],
      description: json['description'],
      steps: (json['steps'] as List).map((step) => AssessmentStep.fromJson(step)).toList(),
      status: AssessmentStatus.values[json['status']],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  @override
  String toString() {
    return 'Assessment{id: $id, title: $title, status: ${status.displayName}}';
  }
}


