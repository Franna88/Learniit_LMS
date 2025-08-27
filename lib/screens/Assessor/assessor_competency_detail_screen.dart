import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import 'assessor_guide_detail_screen.dart';
import 'assessor_dashboard_screen.dart';
import '../guides_screen.dart';
import 'assessor_help_screen.dart';
import 'assessor_competencies_screen.dart';
import 'assessor_competency_introduction_screen.dart';
import 'assessor_competency_readiness_screen.dart';
import 'assessor_workplace_assessment_screen.dart';

class AssessorCompetencyDetailScreen extends StatelessWidget {
  final String category;
  final String title;
  final int progressPercent;
  final String imageAssetPath;
  final String description;

  const AssessorCompetencyDetailScreen({
    super.key,
    required this.category,
    required this.title,
    required this.progressPercent,
    required this.imageAssetPath,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      description,
                      style: GoogleFonts.poppins(fontSize: 13, color: AppTheme.primaryGradientStart.withOpacity(0.8)),
                    ),
                    const SizedBox(height: 12),
                    _OptionTile(
                      icon: Icons.lightbulb_outline,
                      title: 'Introduction',
                      description: 'Giving oxygen properly can prevent serious complications. Learn why doing it well matters.',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AssessorCompetencyIntroductionScreen(
                              competencyTitle: title,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    _OptionTile(
                      icon: Icons.menu_book_outlined,
                      title: 'Guide',
                      description: 'A step-by-step cheat sheet for setting up and delivering oxygen safely.',
                      onTap: () {
                        final guide = _getRelatedGuideFor(title);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AssessorGuideDetailScreen(
                              guideTitle: guide['title']!,
                              guideDescription: guide['description']!,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    _OptionTile(
                      icon: Icons.autorenew,
                      title: 'Readiness check',
                      description: 'Test your knowledge to prepare for your workplace assessment.',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AssessorCompetencyReadinessScreen(
                              competencyTitle: title,
                              scenarioImagePath: imageAssetPath,
                              symptomsImagePath: imageAssetPath,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    _OptionTile(
                      icon: Icons.assignment_turned_in_outlined,
                      title: 'Workplace assessment',
                      description: 'Complete your workplace assessment to demonstrate your competency.',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AssessorWorkplaceAssessmentScreen(
                              competencyTitle: title,
                              imageAssetPath: imageAssetPath,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _AssessorBottomBar(
        selectedIndex: 3, // Competencies tab
        onItemTapped: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const AssessorDashboardScreen()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const AssessorDashboardScreen()),
              );
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

  Map<String, String> _getRelatedGuideFor(String competencyTitle) {
    // Dummy mapping for now; in a real app this would come from backend/content model
    if (competencyTitle.toLowerCase().contains('oxygen')) {
      return {
        'title': 'Oxygen Administration',
        'description': 'Use this practical skill sheet to ensure you are well prepared and can carry out all the steps safely.'
      };
    }
    if (competencyTitle.toLowerCase().contains('drug')) {
      return {
        'title': 'Drug Administration',
        'description': 'Safe drug administration procedures and protocols.'
      };
    }
    return {
      'title': 'Airway Management',
      'description': 'Airway assessment and management techniques.'
    };
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 220,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(imageAssetPath, fit: BoxFit.cover),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                child: Container(color: Colors.transparent),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.primaryGradientStart.withOpacity(0.85),
                      AppTheme.primaryGradientEnd.withOpacity(0.85),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.person, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildProgressIndicator(progressPercent),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(int percent) {
    return Row(
      children: [
        Container(
          width: 60,
          child: Container(
            height: 8,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth * (percent / 100);
                return Stack(
                  children: [
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                        color: AppTheme.highlightColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text('$percent%', style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}

class _OptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback? onTap;

  const _OptionTile({
    required this.icon,
    required this.title,
    required this.description,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: AppTheme.cardDecoration,
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.secondaryButton,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 2,
                    left: 2,
                    right: 2,
                    child: Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppTheme.highlightColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Center(
                    child: Icon(icon, color: AppTheme.primaryGradientStart),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTheme.heading3.copyWith(fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(description, style: AppTheme.caption),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
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
