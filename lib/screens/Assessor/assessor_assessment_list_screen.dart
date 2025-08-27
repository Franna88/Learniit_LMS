import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import '../../theme/app_theme.dart';
import 'assessor_competency_learners_screen.dart';
import 'assessor_dashboard_screen.dart';
import '../guides_screen.dart';
import 'assessor_help_screen.dart';
import 'assessor_competencies_screen.dart';

class AssessorAssessmentListScreen extends StatefulWidget {
  const AssessorAssessmentListScreen({super.key});

  @override
  State<AssessorAssessmentListScreen> createState() => _AssessorAssessmentListScreenState();
}

class _AssessorAssessmentListScreenState extends State<AssessorAssessmentListScreen> {
  int _selectedBottomIndex = 1;
  final TextEditingController _searchController = TextEditingController();

  final List<_AssessmentCategory> _assessmentCategories = const [
    _AssessmentCategory(
      category: 'Clinical procedures',
      title: 'Drug administration',
      learnersReady: 4,
      imagePath: 'images/drug-administration.jpg',
    ),
    _AssessmentCategory(
      category: 'Airway management and oxygen administration',
      title: 'Portable oxygen administration',
      learnersReady: 3,
      imagePath: 'images/oxygen.jpg',
    ),
    _AssessmentCategory(
      category: 'Diving accident management',
      title: 'Neurological assessment',
      learnersReady: 2,
      imagePath: 'images/competencie3.jpg',
    ),
    _AssessmentCategory(
      category: 'Cardiac care',
      title: 'Cardiac chest pain',
      learnersReady: 1,
      imagePath: 'images/competencie5.jpg',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top Gradient Header
            Container(
              decoration: const BoxDecoration(
                gradient: AppTheme.mainGradient,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Top Row with Back and Profile
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        Text(
                          'Assessments',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 48), // Balance the layout
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Search Bar
                    TextField(
                      controller: _searchController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Search assessments...',
                        hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                        prefixIcon: const Icon(Icons.search, color: Colors.white70),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            
            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Available Assessments',
                      style: AppTheme.heading2,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Select a competency to view learners ready for assessment.',
                      style: AppTheme.caption,
                    ),
                    const SizedBox(height: 20),
                    
                    // Assessment Categories
                    ..._assessmentCategories.map((category) => 
                      _buildAssessmentCategoryCard(category)
                    ).toList(),
                    
                    const SizedBox(height: 20),
                    
                    // Filter Buttons
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: AppTheme.secondaryButton,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Qualification',
                                  style: AppTheme.bodyText.copyWith(
                                    color: AppTheme.primaryGradientStart,
                                  ),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: AppTheme.primaryGradientStart,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: AppTheme.secondaryButton,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Status',
                                  style: AppTheme.bodyText.copyWith(
                                    color: AppTheme.primaryGradientStart,
                                  ),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: AppTheme.primaryGradientStart,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _AssessorBottomBar(
        selectedIndex: _selectedBottomIndex,
        onItemTapped: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const AssessorDashboardScreen()),
              );
              break;
            case 1:
              // Already on Assessment List
              setState(() => _selectedBottomIndex = 1);
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const GuidesScreen(useAssessorNav: true)),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const AssessorCompetenciesScreen()),
              );
              break;
            case 4:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const AssessorHelpScreen()),
              );
              break;
          }
        },
      ),
    );
  }

  Widget _buildAssessmentCategoryCard(_AssessmentCategory category) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AssessorCompetencyLearnersScreen(
              category: category.category,
              title: category.title,
              backgroundImageAssetPath: category.imagePath,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Background image with blur
              Positioned.fill(
                child: Image.asset(
                  category.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              // Blur overlay
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
              // Dark blue gradient overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppTheme.primaryGradientStart.withOpacity(0.6),
                        AppTheme.primaryGradientEnd.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Left side - Text content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category text (top left)
                          Text(
                            category.category,
                            style: AppTheme.caption.copyWith(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Title text (larger, bold)
                          Text(
                            category.title,
                            style: AppTheme.heading3.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Right side - Status badge and assessment icon
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Status badge (top right)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.group,
                                size: 12,
                                color: Colors.white.withOpacity(0.8),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${category.learnersReady} learners ready',
                                style: AppTheme.caption.copyWith(
                                  fontSize: 10,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Assessment icon
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppTheme.highlightColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.assessment,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AssessmentCategory {
  final String category;
  final String title;
  final int learnersReady;
  final String imagePath;

  const _AssessmentCategory({
    required this.category,
    required this.title,
    required this.learnersReady,
    required this.imagePath,
  });
}

class _AssessorBottomBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const _AssessorBottomBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppTheme.mainGradient,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.lightbulb, 'Dashboard'),
            _buildNavItem(1, Icons.edit, 'Assess'),
            _buildNavItem(2, Icons.menu_book, 'Guides'),
            _buildNavItem(3, Icons.my_location, 'Competencies'),
            _buildNavItem(4, Icons.help, 'Help'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppTheme.highlightColor : Colors.white,
              size: 20,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppTheme.highlightColor : Colors.white70,
                fontSize: 8,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
