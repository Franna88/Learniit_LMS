import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import '../../theme/app_theme.dart';
import '../../widgets/guide_card.dart';
import '../profile_screen.dart';
import '../guide_detail_screen.dart';
import 'assessor_competency_learners_screen.dart';
import '../guides_screen.dart';
import 'assessor_help_screen.dart';
import 'assessor_competencies_screen.dart';
import 'assessor_assessment_list_screen.dart';

class AssessorDashboardScreen extends StatefulWidget {
  const AssessorDashboardScreen({super.key});

  @override
  State<AssessorDashboardScreen> createState() => _AssessorDashboardScreenState();
}

class _AssessorDashboardScreenState extends State<AssessorDashboardScreen> {
  int _selectedBottomIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
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
                      // Top Row with Menu and Profile
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              // TODO: Implement menu functionality
                            },
                            icon: const Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ProfileScreen(),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Welcome Message
                      Text(
                        'Welcome to the\nAssessor Zone,',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Bridget',
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.highlightColor,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 30),

                      // Assessor Stats Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem('12', 'assessments\npending'),
                          _buildStatItem('8', 'learners\nready'),
                          _buildStatItem('5', 'assessments\ncompleted'),
                        ],
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              // Main Content
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Pending Assessments Section
                    Text(
                      'Pending assessments',
                      style: AppTheme.heading2,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'These learners are ready for assessment. Select one to begin the assessment process.',
                      style: AppTheme.caption,
                    ),
                    const SizedBox(height: 20),
                    
                    // Filter Buttons
                    LayoutBuilder(
                      builder: (context, constraints) {
                        // Calculate responsive padding based on screen width
                        final screenWidth = MediaQuery.of(context).size.width;
                        final buttonPadding = screenWidth < 400 ? 8.0 : 16.0;
                        final textStyle = AppTheme.bodyText.copyWith(
                          color: AppTheme.primaryGradientStart,
                          fontSize: screenWidth < 400 ? 14 : 16,
                        );

                        return Row(
                          children: [
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: buttonPadding, vertical: 12),
                                decoration: BoxDecoration(
                                  color: AppTheme.secondaryButton,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Qualification',
                                        style: textStyle,
                                        overflow: TextOverflow.ellipsis,
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
                            SizedBox(width: screenWidth < 400 ? 8 : 12),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: buttonPadding, vertical: 12),
                                decoration: BoxDecoration(
                                  color: AppTheme.secondaryButton,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Category',
                                        style: textStyle,
                                        overflow: TextOverflow.ellipsis,
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
                        );
                      },
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Assessment Cards
                    _buildAssessmentCard(
                      'Clinical procedures',
                      'Drug administration',
                      '4 learners ready',
                      'images/drug-administration.jpg',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AssessorCompetencyLearnersScreen(
                              category: 'Clinical procedures',
                              title: 'Drug administration',
                              backgroundImageAssetPath: 'images/drug-administration.jpg',
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildAssessmentCard(
                      'Airway management and oxygen administration',
                      'Portable oxygen administration',
                      '3 learners ready',
                      'images/oxygen.jpg',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AssessorCompetencyLearnersScreen(
                              category: 'Airway management and oxygen administration',
                              title: 'Portable oxygen administration',
                              backgroundImageAssetPath: 'images/oxygen.jpg',
                            ),
                          ),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // See More Link
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AssessorAssessmentListScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'See more',
                          style: AppTheme.caption.copyWith(
                            color: AppTheme.primaryGradientStart,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Recent Assessments Section
                    Text(
                      'Recent assessments',
                      style: AppTheme.heading2,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your recently completed assessments and their outcomes.',
                      style: AppTheme.caption,
                    ),
                    const SizedBox(height: 20),
                    
                    // Recent Assessment Cards
                    _buildRecentAssessmentCard(
                      'Jane Diver',
                      'Cardiac chest pain',
                      'Completed 2 days ago',
                      'Passed',
                      'images/competencie5.jpg',
                    ),
                    const SizedBox(height: 16),
                    _buildRecentAssessmentCard(
                      'Michael McDiver',
                      'Neurological assessment',
                      'Completed 1 week ago',
                      'Passed',
                      'images/competencie3.jpg',
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // See More Link
                    Center(
                      child: TextButton(
                        onPressed: () {
                          // TODO: Navigate to all recent assessments
                        },
                        child: Text(
                          'See more',
                          style: AppTheme.caption.copyWith(
                            color: AppTheme.primaryGradientStart,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Quick Access Guides Section
                    Text(
                      'Quick Access Guides',
                      style: AppTheme.heading2,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Essential guides for assessment procedures and standards.',
                      style: AppTheme.caption,
                    ),
                    const SizedBox(height: 20),
                    
                    // Quick Access Guides Grid
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.1,
                      children: [
                        GuideCard(
                          icon: Icons.assessment,
                          title: 'Assessment Standards',
                          isBookmarked: true,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GuideDetailScreen(
                                  guideTitle: 'Assessment Standards',
                                  guideDescription: 'Comprehensive guide to assessment standards and criteria for evaluating learner competencies.',
                                  selectedTabIndex: 2, // From guides section
                                  useAssessorNav: true,
                                ),
                              ),
                            );
                          },
                        ),
                        GuideCard(
                          icon: Icons.feedback,
                          title: 'Feedback Guidelines',
                          isBookmarked: true,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GuideDetailScreen(
                                  guideTitle: 'Feedback Guidelines',
                                  guideDescription: 'Best practices for providing constructive feedback to learners during assessments.',
                                  selectedTabIndex: 2, // From guides section
                                  useAssessorNav: true,
                                ),
                              ),
                            );
                          },
                        ),
                        GuideCard(
                          icon: Icons.document_scanner,
                          title: 'Documentation',
                          isBookmarked: true,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GuideDetailScreen(
                                  guideTitle: 'Documentation',
                                  guideDescription: 'Guidelines for proper assessment documentation and record keeping.',
                                  selectedTabIndex: 2, // From guides section
                                  useAssessorNav: true,
                                ),
                              ),
                            );
                          },
                        ),
                        GuideCard(
                          icon: Icons.safety_check,
                          title: 'Safety Protocols',
                          isBookmarked: true,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GuideDetailScreen(
                                  guideTitle: 'Safety Protocols',
                                  guideDescription: 'Safety protocols and procedures to follow during practical assessments.',
                                  selectedTabIndex: 2, // From guides section
                                  useAssessorNav: true,
                                ),
                              ),
                            );
                          },
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
      bottomNavigationBar: _AssessorBottomBar(
        selectedIndex: _selectedBottomIndex,
        onItemTapped: (index) {
          switch (index) {
            case 0:
              // Already on Dashboard
              setState(() => _selectedBottomIndex = 0);
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const AssessorAssessmentListScreen()),
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

  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.white70,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildAssessmentCard(String category, String title, String status, String imagePath, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                  imagePath,
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
                            category,
                            style: AppTheme.caption.copyWith(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Title text (larger, bold)
                          Text(
                            title,
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
                                status,
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

  Widget _buildRecentAssessmentCard(String learnerName, String competency, String date, String result, String imagePath) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.cardDecoration,
      child: Row(
        children: [
          // Left side - Learner avatar and info
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Center(
              child: Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primaryGradientStart,
                ),
                child: const Icon(Icons.person, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 12),
          
          // Center - Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  learnerName,
                  style: AppTheme.bodyText.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  competency,
                  style: AppTheme.caption.copyWith(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  date,
                  style: AppTheme.caption.copyWith(
                    color: Colors.grey[500],
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          
          // Right side - Result badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: result.toLowerCase() == 'passed' ? Colors.green[100] : Colors.red[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              result,
              style: AppTheme.caption.copyWith(
                fontWeight: FontWeight.w600,
                color: result.toLowerCase() == 'passed' ? Colors.green[700] : Colors.red[700],
              ),
            ),
          ),
        ],
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


