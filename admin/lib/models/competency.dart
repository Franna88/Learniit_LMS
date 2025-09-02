import 'package:flutter/material.dart';

class Competency {
  final String id;
  final String category;
  final String title;
  final String description;
  final int progressPercent;
  final String imageAssetPath;
  final String dueDateLabel;
  final DateTime createdAt;
  final DateTime updatedAt;

  Competency({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.progressPercent,
    required this.imageAssetPath,
    required this.dueDateLabel,
    required this.createdAt,
    required this.updatedAt,
  });

  Competency copyWith({
    String? id,
    String? category,
    String? title,
    String? description,
    int? progressPercent,
    String? imageAssetPath,
    String? dueDateLabel,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Competency(
      id: id ?? this.id,
      category: category ?? this.category,
      title: title ?? this.title,
      description: description ?? this.description,
      progressPercent: progressPercent ?? this.progressPercent,
      imageAssetPath: imageAssetPath ?? this.imageAssetPath,
      dueDateLabel: dueDateLabel ?? this.dueDateLabel,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'title': title,
      'description': description,
      'progressPercent': progressPercent,
      'imageAssetPath': imageAssetPath,
      'dueDateLabel': dueDateLabel,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Competency.fromJson(Map<String, dynamic> json) {
    return Competency(
      id: json['id'],
      category: json['category'],
      title: json['title'],
      description: json['description'],
      progressPercent: json['progressPercent'],
      imageAssetPath: json['imageAssetPath'],
      dueDateLabel: json['dueDateLabel'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  @override
  String toString() {
    return 'Competency{id: $id, title: $title, category: $category}';
  }
}


