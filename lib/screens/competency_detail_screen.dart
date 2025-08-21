import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'guide_detail_screen.dart';
import '../widgets/bottom_navigation.dart';
import 'main_navigation_screen.dart';
import 'competency_introduction_screen.dart';
import 'competency_readiness_screen.dart';
import 'workplace_assessment_screen.dart';

class CompetencyDetailScreen extends StatelessWidget {
  final String category;
  final String title;
  final int progressPercent;
  final String imageAssetPath;
  final String description;

  const CompetencyDetailScreen({
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
                            builder: (context) => CompetencyIntroductionScreen(
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
                            builder: (context) => GuideDetailScreen(
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
                            builder: (context) => CompetencyReadinessScreen(
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
                      description: 'Checklist and guidance for your workplace-based assessment.',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WorkplaceAssessmentScreen(
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
      bottomNavigationBar: BottomNavigation(
        selectedIndex: 1,
        onItemTapped: (index) {
          if (index == 1) {
            return;
          }
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainNavigationScreen(initialIndex: index),
            ),
          );
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
                  const SizedBox(height: 6),
                  Text(
                    category,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('Progress', style: GoogleFonts.poppins(fontSize: 10, color: Colors.white70)),
                  const SizedBox(height: 6),
                  _ProgressBar(percent: progressPercent),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final int percent;
  const _ProgressBar({required this.percent});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
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


