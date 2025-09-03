import 'package:flutter/material.dart';

class GuideStep {
  final String id;
  final String title;
  final List<String> points;
  final IconData icon;

  GuideStep({
    required this.id,
    required this.title,
    required this.points,
    required this.icon,
  });

  GuideStep copyWith({
    String? id,
    String? title,
    List<String>? points,
    IconData? icon,
  }) {
    return GuideStep(
      id: id ?? this.id,
      title: title ?? this.title,
      points: points ?? this.points,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'points': points,
      'icon': icon.codePoint, // Store icon code point
    };
  }

  factory GuideStep.fromJson(Map<String, dynamic> json) {
    return GuideStep(
      id: json['id'],
      title: json['title'],
      points: List<String>.from(json['points']),
      icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
    );
  }
}

class Guide {
  final String id;
  final String title;
  final IconData icon;
  final String description;
  final bool isBookmarked;
  final List<GuideStep> steps;
  final DateTime createdAt;
  final DateTime updatedAt;

  Guide({
    required this.id,
    required this.title,
    required this.icon,
    required this.description,
    required this.isBookmarked,
    required this.steps,
    required this.createdAt,
    required this.updatedAt,
  });

  Guide copyWith({
    String? id,
    String? title,
    IconData? icon,
    String? description,
    bool? isBookmarked,
    List<GuideStep>? steps,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Guide(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      description: description ?? this.description,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      steps: steps ?? this.steps,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'icon': icon.codePoint,
      'description': description,
      'isBookmarked': isBookmarked,
      'steps': steps.map((step) => step.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Guide.fromJson(Map<String, dynamic> json) {
    return Guide(
      id: json['id'],
      title: json['title'],
      icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
      description: json['description'],
      isBookmarked: json['isBookmarked'],
      steps: (json['steps'] as List).map((step) => GuideStep.fromJson(step)).toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  @override
  String toString() {
    return 'Guide{id: $id, title: $title, steps: ${steps.length}}';
  }
}


