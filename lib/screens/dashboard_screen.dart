import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import '../theme/app_theme.dart';
import '../widgets/guide_card.dart';
import 'profile_screen.dart';
import 'competency_detail_screen.dart';
import 'guide_detail_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate responsive values
    final isSmallScreen = screenHeight < 700;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top Gradient Header - Now Scrollable
              Container(
                decoration: const BoxDecoration(
                  gradient: AppTheme.mainGradient,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(isSmallScreen ? 16.0 : 20.0),
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
                        'Welcome to the\nLearning Zone,',
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

                      // User Stats Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem('40', 'competencies\nearned'),
                          _buildStatItem('23', 'competencies\noutstanding'),
                          _buildStatItem('12', 'assessments\ndue soon'),
                        ],
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              // Main Content - Now part of the scrollable area
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Upcoming Assessments Section
                    Text(
                      'Upcoming assessments',
                      style: AppTheme.heading2,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'These refresher assessments are due next. Select one to start preparing.',
                      style: AppTheme.caption,
                    ),
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
                                Expanded(
                                  child: Text(
                                    'Qualification',
                                    style: AppTheme.bodyText.copyWith(
                                      color: AppTheme.primaryGradientStart,
                                    ),
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
                                Expanded(
                                  child: Text(
                                    'Category',
                                    style: AppTheme.bodyText.copyWith(
                                      color: AppTheme.primaryGradientStart,
                                    ),
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
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Assessment Cards
                    _buildAssessmentCard(
                      'Clinical procedures',
                      'Drug administration',
                      'Assessment due in 2 weeks',
                    ),
                    const SizedBox(height: 16),
                    _buildAssessmentCard(
                      'Diving accident management',
                      'Neurological assessment',
                      'Assessment due in 2 weeks',
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // See More Link
                    Center(
                      child: TextButton(
                        onPressed: () {
                          // TODO: Navigate to all assessments
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
                    
                    // In Progress Competencies Section
                    Text(
                      'In progress competencies',
                      style: AppTheme.heading2,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'These are competencies you are busy brushing up on. Select one to continue.',
                      style: AppTheme.caption,
                    ),
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
                                Expanded(
                                  child: Text(
                                    'Qualification',
                                    style: AppTheme.bodyText.copyWith(
                                      color: AppTheme.primaryGradientStart,
                                    ),
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
                                Expanded(
                                  child: Text(
                                    'Category',
                                    style: AppTheme.bodyText.copyWith(
                                      color: AppTheme.primaryGradientStart,
                                    ),
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
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Competency Cards
                    _buildCompetencyCard(
                      'Airway management and oxygen administration',
                      'Portable oxygen administration',
                      'Assessment due in 2 weeks',
                      50,
                      'images/oxygen.jpg',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CompetencyDetailScreen(
                              category: 'Airway management and oxygen administration',
                              title: 'Portable oxygen administration',
                              progressPercent: 50,
                              imageAssetPath: 'images/oxygen.jpg',
                              description: 'Learn how to safely set up and deliver oxygen, including equipment checks and patient monitoring.',
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: isSmallScreen ? 12 : 16),
                    _buildCompetencyCard(
                      'Clinical procedures',
                      'Drug administration',
                      'Assessment due in 2 weeks',
                      75,
                      'images/drug-administration.jpg',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CompetencyDetailScreen(
                              category: 'Clinical procedures',
                              title: 'Drug administration',
                              progressPercent: 75,
                              imageAssetPath: 'images/drug-administration.jpg',
                              description: 'Refresh safe drug administration procedures and protocols before your assessment.',
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
                          // TODO: Navigate to all competencies
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
                    
                    // Saved Guides Section
                    Text(
                      'Saved Guides',
                      style: AppTheme.heading2,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Quick access to your saved learning guides and resources.',
                      style: AppTheme.caption,
                    ),
                    const SizedBox(height: 20),
                    
                                         // Saved Guides Grid
                     GridView.count(
                       shrinkWrap: true,
                       physics: const NeverScrollableScrollPhysics(),
                       crossAxisCount: 2,
                       crossAxisSpacing: 12,
                       mainAxisSpacing: 12,
                       childAspectRatio: 1.1,
                       children: [
                        GuideCard(
                          icon: Icons.search,
                          title: 'Key Terminology',
                          isBookmarked: true,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GuideDetailScreen(
                                  guideTitle: 'Key Terminology',
                                  guideDescription: _guideDescription('Key Terminology'),
                                  selectedTabIndex: 2, // From guides section on dashboard
                                ),
                              ),
                            );
                          },
                        ),
                        GuideCard(
                          icon: Icons.assignment,
                          title: 'Primary Survey',
                          isBookmarked: true,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GuideDetailScreen(
                                  guideTitle: 'Primary Survey',
                                  guideDescription: _guideDescription('Primary Survey'),
                                  selectedTabIndex: 2, // From guides section on dashboard
                                ),
                              ),
                            );
                          },
                        ),
                        GuideCard(
                          icon: Icons.assignment,
                          title: 'Secondary Survey',
                          isBookmarked: true,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GuideDetailScreen(
                                  guideTitle: 'Secondary Survey',
                                  guideDescription: _guideDescription('Secondary Survey'),
                                  selectedTabIndex: 2, // From guides section on dashboard
                                ),
                              ),
                            );
                          },
                        ),
                        GuideCard(
                          icon: Icons.folder,
                          title: 'Documentation',
                          isBookmarked: true,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GuideDetailScreen(
                                  guideTitle: 'Documentation',
                                  guideDescription: _guideDescription('Documentation'),
                                  selectedTabIndex: 2, // From guides section on dashboard
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

  Widget _buildCompetencyCard(String category, String title, String dueDate, int progress, String imagePath, {VoidCallback? onTap}) {
    // Get responsive values from current context
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 700;
    final competencyCardHeight = isSmallScreen ? 120.0 : 140.0;
    final competencyCardPadding = isSmallScreen ? 12.0 : 16.0;
    final progressCircleSize = isSmallScreen ? 40.0 : 48.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
      height: competencyCardHeight,
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
              padding: EdgeInsets.all(competencyCardPadding),
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
                            fontSize: isSmallScreen ? 10 : 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        // Title text (larger, bold)
                        Text(
                          title,
                          style: AppTheme.heading3.copyWith(
                            fontSize: isSmallScreen ? 14 : 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                  ),
                  
                  // Right side - Due date badge and progress circle
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Due date badge (top right)
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
                              Icons.access_time,
                              size: 12,
                              color: Colors.white.withOpacity(0.8),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              dueDate,
                              style: AppTheme.caption.copyWith(
                                fontSize: isSmallScreen ? 9 : 10,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                                                                    // Half-circle progress bar
                       SizedBox(
                         width: progressCircleSize,
                         height: progressCircleSize,
                         child: Stack(
                           children: [
                             // Background half-circle
                             CustomPaint(
                               size: Size(progressCircleSize, progressCircleSize),
                               painter: HalfCirclePainter(
                                 progress: 1.0,
                                 color: Colors.white.withOpacity(0.2),
                                 strokeWidth: 5,
                               ),
                             ),
                             // Progress half-circle
                             CustomPaint(
                               size: Size(progressCircleSize, progressCircleSize),
                               painter: HalfCirclePainter(
                                 progress: progress / 100,
                                 color: AppTheme.highlightColor,
                                 strokeWidth: 5,
                               ),
                             ),
                                                           // Percentage text
                              Center(
                                child: Text(
                                  '$progress%',
                                  style: GoogleFonts.poppins(
                                    fontSize: isSmallScreen ? 9 : 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                           ],
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

    Widget _buildAssessmentCard(String category, String title, String dueDate) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.cardDecoration,
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
                    color: Colors.grey[600],
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
                  ),
                ),
              ],
            ),
          ),
          
          // Right side - Due date badge and icon
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Due date badge (top right)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 12,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      dueDate,
                      style: AppTheme.caption.copyWith(
                        fontSize: 10,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Clipboard icon with golden top
              Container(
                width: 24,
                height: 32,
                decoration: BoxDecoration(
                  color: AppTheme.primaryGradientStart,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Stack(
                  children: [
                    // Main clipboard body
                    Positioned(
                      top: 4,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.primaryGradientStart,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(4),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 12,
                              height: 1,
                              color: Colors.white.withOpacity(0.3),
                            ),
                            const SizedBox(height: 2),
                            Container(
                              width: 12,
                              height: 1,
                              color: Colors.white.withOpacity(0.3),
                            ),
                            const SizedBox(height: 2),
                            Container(
                              width: 12,
                              height: 1,
                              color: Colors.white.withOpacity(0.3),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Golden top clip
                    Positioned(
                      top: 0,
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
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
     );
  }

  String _guideDescription(String title) {
    final key = title.toLowerCase();
    if (key.contains('terminology')) {
      return 'Glossary of key terms to help you understand common language used throughout your training.';
    }
    if (key.contains('primary')) {
      return 'A concise guide to performing a primary survey: identify and manage immediate life threats.';
    }
    if (key.contains('secondary')) {
      return 'Steps for a thorough head-to-toe assessment after life threats are addressed.';
    }
    if (key.contains('document')) {
      return 'Best practices for accurate, clear, and complete clinical documentation.';
    }
    return 'Learning guide.';
  }


}

class HalfCirclePainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  HalfCirclePainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Draw the half-circle arc (from π to 2π radians, which is 180 to 360 degrees)
    // This creates a half-circle with the full part at the top
    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(
      rect,
      3.14159, // Start angle (180 degrees)
      progress * 3.14159, // Sweep angle (progress * 180 degrees)
      false, // Use center
      paint,
    );
  }

  @override
  bool shouldRepaint(HalfCirclePainter oldDelegate) {
    return oldDelegate.progress != progress ||
           oldDelegate.color != color ||
           oldDelegate.strokeWidth != strokeWidth;
  }
}
