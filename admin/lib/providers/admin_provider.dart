import 'package:flutter/material.dart';
import '../models/competency.dart';
import '../models/guide.dart';
import '../models/assessment.dart';

class AdminProvider with ChangeNotifier {
  // Data lists
  List<Competency> _competencies = [];
  List<Guide> _guides = [];
  List<Assessment> _assessments = [];

  // Loading states
  bool _isLoadingCompetencies = false;
  bool _isLoadingGuides = false;
  bool _isLoadingAssessments = false;

  // Getters
  List<Competency> get competencies => _competencies;
  List<Guide> get guides => _guides;
  List<Assessment> get assessments => _assessments;

  bool get isLoadingCompetencies => _isLoadingCompetencies;
  bool get isLoadingGuides => _isLoadingGuides;
  bool get isLoadingAssessments => _isLoadingAssessments;

  // Initialize with sample data (in real app, this would come from API/database)
  AdminProvider() {
    _initializeSampleData();
  }

  void _initializeSampleData() {
    _competencies = [
      Competency(
        id: '1',
        category: 'Airway management and oxygen administration',
        title: 'Cardiac chest pain',
        description: 'This competency covers the safe setup, delivery, and discontinuation of portable oxygen in emergency situations.',
        progressPercent: 25,
        imageAssetPath: 'images/oxygen.jpg',
        dueDateLabel: 'Assessment due in 2 weeks',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Competency(
        id: '2',
        category: 'Airway management and oxygen administration',
        title: 'Portable oxygen administration',
        description: 'This competency covers the safe setup, delivery, and discontinuation of portable oxygen in emergency situations.',
        progressPercent: 50,
        imageAssetPath: 'images/oxygen.jpg',
        dueDateLabel: 'Assessment due in 2 weeks',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Competency(
        id: '3',
        category: 'Clinical procedures',
        title: 'Drug administration',
        description: 'This competency covers safe drug preparation and administration procedures for common emergency scenarios.',
        progressPercent: 50,
        imageAssetPath: 'images/drug-administration.jpg',
        dueDateLabel: 'Assessment due in 2 weeks',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    _guides = [
      Guide(
        id: '1',
        title: 'Key Terminology',
        icon: Icons.search,
        description: 'Essential medical terminology and definitions for diving professionals.',
        isBookmarked: true,
        steps: [
          GuideStep(
            id: '1',
            title: 'Basic Medical Terms',
            points: ['Define common medical abbreviations', 'Understand anatomical terminology', 'Learn emergency response terms'],
            icon: Icons.book,
          ),
        ],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Guide(
        id: '2',
        title: 'Oxygen Administration',
        icon: Icons.airline_seat_flat,
        description: 'Use this practical skill sheet to ensure you are well prepared for your workplace assessment.',
        isBookmarked: false,
        steps: [
          GuideStep(
            id: '1',
            title: 'Safety First',
            points: ['Locate open the carry case', 'Ensure your hands are clean', 'No open flames or sparks'],
            icon: Icons.shield,
          ),
          GuideStep(
            id: '2',
            title: 'Check the cylinder',
            points: ['Check colour coding and in date', 'Verify pressure gauge reading', 'Inspect for any visible damage'],
            icon: Icons.build,
          ),
        ],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    _assessments = [
      Assessment(
        id: '1',
        competencyId: '1',
        title: 'Cardiac Chest Pain Assessment',
        description: 'Workplace assessment for cardiac chest pain competency',
        steps: [
          AssessmentStep(
            id: '1',
            title: 'Pre-Assessment Checklist',
            description: 'Complete all readiness requirements before booking assessment',
            type: AssessmentStepType.checklist,
          ),
          AssessmentStep(
            id: '2',
            title: 'Book Assessment',
            description: 'Schedule your workplace assessment with a qualified assessor',
            type: AssessmentStepType.booking,
          ),
          AssessmentStep(
            id: '3',
            title: 'Upload Evidence',
            description: 'Submit your assessment evidence and documentation',
            type: AssessmentStepType.upload,
          ),
        ],
        status: AssessmentStatus.pending,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    notifyListeners();
  }

  // Competency CRUD operations
  Future<void> loadCompetencies() async {
    _isLoadingCompetencies = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    _isLoadingCompetencies = false;
    notifyListeners();
  }

  Future<void> addCompetency(Competency competency) async {
    _competencies.add(competency);
    notifyListeners();
  }

  Future<void> updateCompetency(String id, Competency updatedCompetency) async {
    final index = _competencies.indexWhere((c) => c.id == id);
    if (index != -1) {
      _competencies[index] = updatedCompetency;
      notifyListeners();
    }
  }

  Future<void> deleteCompetency(String id) async {
    _competencies.removeWhere((c) => c.id == id);
    notifyListeners();
  }

  // Guide CRUD operations
  Future<void> loadGuides() async {
    _isLoadingGuides = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    _isLoadingGuides = false;
    notifyListeners();
  }

  Future<void> addGuide(Guide guide) async {
    _guides.add(guide);
    notifyListeners();
  }

  Future<void> updateGuide(String id, Guide updatedGuide) async {
    final index = _guides.indexWhere((g) => g.id == id);
    if (index != -1) {
      _guides[index] = updatedGuide;
      notifyListeners();
    }
  }

  Future<void> deleteGuide(String id) async {
    _guides.removeWhere((g) => g.id == id);
    notifyListeners();
  }

  // Assessment CRUD operations
  Future<void> loadAssessments() async {
    _isLoadingAssessments = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    _isLoadingAssessments = false;
    notifyListeners();
  }

  Future<void> addAssessment(Assessment assessment) async {
    _assessments.add(assessment);
    notifyListeners();
  }

  Future<void> updateAssessment(String id, Assessment updatedAssessment) async {
    final index = _assessments.indexWhere((a) => a.id == id);
    if (index != -1) {
      _assessments[index] = updatedAssessment;
      notifyListeners();
    }
  }

  Future<void> deleteAssessment(String id) async {
    _assessments.removeWhere((a) => a.id == id);
    notifyListeners();
  }

  // Data export functionality
  Future<String> exportData() async {
    // In a real app, this would generate JSON/CSV export
    final data = {
      'competencies': _competencies.map((c) => c.toJson()).toList(),
      'guides': _guides.map((g) => g.toJson()).toList(),
      'assessments': _assessments.map((a) => a.toJson()).toList(),
      'exportedAt': DateTime.now().toIso8601String(),
    };

    // For now, return a sample JSON string
    return data.toString();
  }

  Future<void> importData(String jsonData) async {
    // In a real app, this would parse and import the JSON data
    // For now, just show that the import was attempted
    notifyListeners();
  }
}


