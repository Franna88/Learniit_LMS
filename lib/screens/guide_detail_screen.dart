import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'profile_screen.dart';
import '../widgets/bottom_navigation.dart';
import 'main_navigation_screen.dart';
import 'Assessor/assessor_dashboard_screen.dart';
import 'Assessor/assessor_assessment_list_screen.dart';
import 'Assessor/assessor_competencies_screen.dart';
import 'Assessor/assessor_help_screen.dart';
import 'guides_screen.dart';

class GuideDetailScreen extends StatefulWidget {
  final String guideTitle;
  final String guideDescription;
  final int selectedTabIndex;
  final bool useAssessorNav;

  const GuideDetailScreen({
    super.key,
    required this.guideTitle,
    required this.guideDescription,
    this.selectedTabIndex = 2, // Default to guides tab (index 2)
    this.useAssessorNav = false, // Default to learner navigation
  });

  @override
  State<GuideDetailScreen> createState() => _GuideDetailScreenState();
}

class _GuideDetailScreenState extends State<GuideDetailScreen> {
  bool _isSaved = false;

  // Dummy data for the guide steps
  final List<Map<String, dynamic>> _guideSteps = [
    {
      'title': '1. Safety First',
      'points': [
        'Locate open the carry case.',
        'Ensure your hands are clean from creams, oils, grease',
        'No open flames or sparks',
      ],
      'icon': Icons.shield,
    },
    {
      'title': '2. Check the cylinder',
      'points': [
        'Check colour coding and in date',
        'Verify pressure gauge reading',
        'Inspect for any visible damage',
      ],
      'icon': Icons.build,
    },
    {
      'title': '3. Prepare the equipment',
      'points': [
        'Assemble the oxygen delivery system',
        'Check all connections are secure',
        'Test the flow regulator',
      ],
      'icon': Icons.settings,
    },
    {
      'title': '4. Assess the patient',
      'points': [
        'Check level of consciousness',
        'Assess breathing pattern and rate',
        'Monitor oxygen saturation levels',
      ],
      'icon': Icons.person,
    },
    {
      'title': '5. Administer oxygen',
      'points': [
        'Select appropriate delivery method',
        'Set correct flow rate',
        'Apply delivery device to patient',
      ],
      'icon': Icons.air,
    },
    {
      'title': '6. Monitor and document',
      'points': [
        'Continuously monitor patient response',
        'Record oxygen flow rate and duration',
        'Document any changes in condition',
      ],
      'icon': Icons.note,
    },
  ];

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
                    // Top Row with Menu, Guide label, and Profile
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
                          'Guide',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.highlightColor,
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
                    
                    // Main Title
                    Text(
                      widget.guideTitle,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Description
                    Text(
                      widget.guideDescription,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            
            // Save Guide Button (positioned to overlap with content)
            Transform.translate(
              offset: const Offset(0, -20),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _isSaved = !_isSaved;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(_isSaved ? 'Guide saved!' : 'Guide removed from saved'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.grey[300]!),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    icon: Icon(
                      _isSaved ? Icons.bookmark : Icons.bookmark_border,
                      size: 18,
                    ),
                    label: Text(
                      'Save guide',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
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
                    const SizedBox(height: 20), // Space for save button
                    
                    // Section Title
                    Text(
                      'Administration of oxygen - Conscious (responsive) and breathing',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryGradientStart,
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Divider line
                    Container(
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Introductory text
                    Text(
                      'Make sure you know this well in preparation for your practical assessment! Verbalise the steps as you go to show your level of knowledge and competence.',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Guide Steps
                    ..._guideSteps.map((step) => _buildGuideStepCard(step)).toList(),
                    
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: widget.useAssessorNav
          ? _AssessorBottomBar(
              selectedIndex: widget.selectedTabIndex,
              onItemTapped: (index) {
                if (index == widget.selectedTabIndex) {
                  return;
                }
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
            )
          : BottomNavigation(
              selectedIndex: widget.selectedTabIndex,
              onItemTapped: (index) {
                if (index == widget.selectedTabIndex) {
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

  Widget _buildGuideStepCard(Map<String, dynamic> step) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title and icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    step['title'],
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryGradientStart,
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGradientStart,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    step['icon'],
                    color: AppTheme.highlightColor,
                    size: 20,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Bullet points
            ...(step['points'] as List<String>).map((point) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6, right: 8),
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      point,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            )).toList(),
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
