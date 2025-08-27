import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../widgets/competency_card.dart';
import '../profile_screen.dart';
import 'assessor_competency_detail_screen.dart';
import 'assessor_dashboard_screen.dart';
import '../guides_screen.dart';
import 'assessor_help_screen.dart';
import 'assessor_assessment_list_screen.dart';

class AssessorCompetenciesScreen extends StatefulWidget {
  const AssessorCompetenciesScreen({super.key});

  @override
  State<AssessorCompetenciesScreen> createState() => _AssessorCompetenciesScreenState();
}

class _AssessorCompetenciesScreenState extends State<AssessorCompetenciesScreen> {
  final TextEditingController _searchController = TextEditingController(text: 'Diver medic');
  int _selectedBottomIndex = 3; // Dashboard, Assess, Guides, Competencies, Help

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            // TODO: Implement menu functionality
                          },
                          icon: const Icon(Icons.menu, color: Colors.white, size: 24),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ProfileScreen()),
                            );
                          },
                          icon: const Icon(Icons.person, color: Colors.white, size: 24),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.my_location, color: AppTheme.highlightColor, size: 28),
                        const SizedBox(width: 8),
                        Text(
                          'Competencies',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Browse all competencies to review assessment criteria and standards.',
                      style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!, width: 1),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: const InputDecoration(
                                hintText: 'Search',
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          Icon(Icons.tune, color: Colors.grey[600], size: 20),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text('Diver Medic Technician', style: AppTheme.heading3.copyWith(fontSize: 18, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Text(
                      'Click on the competencies below to review assessment criteria and standards.',
                      style: AppTheme.caption,
                    ),
                    const SizedBox(height: 16),

                    CompetencyCard(
                      category: 'Airway management and oxygen administration',
                      title: 'Cardiac chest pain',
                      dueDateLabel: '4 learners ready',
                      progressPercent: 25,
                      imageAssetPath: 'images/oxygen.jpg',
                      onTap: () {
                                                 Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) => const AssessorCompetencyDetailScreen(
                               category: 'Airway management and oxygen administration',
                               title: 'Cardiac chest pain',
                               progressPercent: 25,
                               imageAssetPath: 'images/oxygen.jpg',
                               description: 'This competency covers the safe setup, delivery, and discontinuation of portable oxygen in emergency situations.',
                             ),
                           ),
                         );
                      },
                    ),
                    const SizedBox(height: 12),
                    CompetencyCard(
                      category: 'Airway management and oxygen administration',
                      title: 'Portable oxygen administration',
                      dueDateLabel: '3 learners ready',
                      progressPercent: 50,
                      imageAssetPath: 'images/oxygen.jpg',
                      onTap: () {
                                                 Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) => const AssessorCompetencyDetailScreen(
                               category: 'Airway management and oxygen administration',
                               title: 'Portable oxygen administration',
                               progressPercent: 50,
                               imageAssetPath: 'images/oxygen.jpg',
                               description: 'This competency covers the safe setup, delivery, and discontinuation of portable oxygen in emergency situations.',
                             ),
                           ),
                         );
                      },
                    ),
                    const SizedBox(height: 12),
                    CompetencyCard(
                      category: 'Clinical procedures',
                      title: 'Drug administration',
                      dueDateLabel: '2 learners ready',
                      progressPercent: 50,
                      imageAssetPath: 'images/drug-administration.jpg',
                      onTap: () {
                                                 Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) => const AssessorCompetencyDetailScreen(
                               category: 'Clinical procedures',
                               title: 'Drug administration',
                               progressPercent: 50,
                               imageAssetPath: 'images/drug-administration.jpg',
                               description: 'This competency covers safe drug preparation and administration procedures for common emergency scenarios.',
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
              // Navigate to assessment list
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
              setState(() => _selectedBottomIndex = 3);
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
