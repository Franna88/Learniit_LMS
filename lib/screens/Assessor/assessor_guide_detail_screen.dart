import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import 'assessor_dashboard_screen.dart';
import '../guides_screen.dart';
import 'assessor_help_screen.dart';
import 'assessor_competencies_screen.dart';

class AssessorGuideDetailScreen extends StatelessWidget {
  final String guideTitle;
  final String guideDescription;

  const AssessorGuideDetailScreen({
    super.key,
    required this.guideTitle,
    required this.guideDescription,
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
                      guideDescription,
                      style: GoogleFonts.poppins(fontSize: 13, color: AppTheme.primaryGradientStart.withOpacity(0.8)),
                    ),
                    const SizedBox(height: 12),
                    _buildGuideStepCard({
                      'title': 'Step 1: Preparation',
                      'icon': Icons.settings,
                      'points': [
                        'Ensure all equipment is clean and in working order',
                        'Check oxygen cylinder pressure and flow rate',
                        'Verify patient identification and consent',
                        'Prepare monitoring equipment',
                      ],
                    }),
                    const SizedBox(height: 12),
                    _buildGuideStepCard({
                      'title': 'Step 2: Patient Assessment',
                      'icon': Icons.person,
                      'points': [
                        'Assess patient\'s respiratory status',
                        'Check oxygen saturation levels',
                        'Evaluate patient\'s level of consciousness',
                        'Review medical history and allergies',
                      ],
                    }),
                    const SizedBox(height: 12),
                    _buildGuideStepCard({
                      'title': 'Step 3: Equipment Setup',
                      'icon': Icons.build,
                      'points': [
                        'Connect oxygen tubing to flow meter',
                        'Set appropriate flow rate (2-15 L/min)',
                        'Attach nasal cannula or mask',
                        'Test equipment functionality',
                      ],
                    }),
                    const SizedBox(height: 12),
                    _buildGuideStepCard({
                      'title': 'Step 4: Administration',
                      'icon': Icons.healing,
                      'points': [
                        'Position patient comfortably',
                        'Apply oxygen delivery device',
                        'Monitor patient response',
                        'Document administration details',
                      ],
                    }),
                    const SizedBox(height: 12),
                    _buildGuideStepCard({
                      'title': 'Step 5: Monitoring',
                      'icon': Icons.monitor_heart,
                      'points': [
                        'Continuously monitor oxygen saturation',
                        'Observe for signs of improvement or deterioration',
                        'Check for equipment complications',
                        'Maintain patient comfort and safety',
                      ],
                    }),
                    const SizedBox(height: 12),
                    _buildGuideStepCard({
                      'title': 'Step 6: Documentation',
                      'icon': Icons.assignment,
                      'points': [
                        'Record oxygen flow rate and delivery method',
                        'Document patient response and vital signs',
                        'Note any complications or adverse effects',
                        'Update care plan as needed',
                      ],
                    }),
                    
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _AssessorBottomBar(
        selectedIndex: 2, // Guides tab
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

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppTheme.mainGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                Text(
                  'Guide',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppTheme.highlightColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Icon(Icons.person, color: Colors.white),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              guideTitle,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
          ],
        ),
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
