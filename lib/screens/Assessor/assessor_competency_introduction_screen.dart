import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import 'assessor_dashboard_screen.dart';
import '../guides_screen.dart';
import 'assessor_help_screen.dart';
import 'assessor_competencies_screen.dart';

class AssessorCompetencyIntroductionScreen extends StatefulWidget {
  final String competencyTitle;

  const AssessorCompetencyIntroductionScreen({
    super.key,
    required this.competencyTitle,
  });

  @override
  State<AssessorCompetencyIntroductionScreen> createState() => _AssessorCompetencyIntroductionScreenState();
}

class _AssessorCompetencyIntroductionScreenState extends State<AssessorCompetencyIntroductionScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _scenarios = [
    {
      'image': 'images/oxygen.jpg',
      'title': 'Emergency Response',
      'body': 'In emergency situations, proper oxygen administration can be the difference between life and death. This competency ensures you can safely and effectively deliver oxygen to patients in critical need.',
    },
    {
      'image': 'images/drug-administration.jpg',
      'title': 'Patient Safety',
      'body': 'Oxygen therapy requires careful attention to safety protocols. You\'ll learn to assess patient needs, monitor vital signs, and prevent complications during oxygen delivery.',
    },
    {
      'image': 'images/coral_diving.jpg',
      'title': 'Professional Standards',
      'body': 'As a healthcare professional, you must maintain the highest standards of care. This competency prepares you to meet regulatory requirements and deliver evidence-based practice.',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Why this competency matters',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryGradientStart,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Understanding the importance of proper oxygen administration',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),

                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: _scenarios.length,
                        onPageChanged: (index) => setState(() => _currentPage = index),
                        padEnds: true,
                        clipBehavior: Clip.none,
                        itemBuilder: (context, index) {
                          final s = _scenarios[index];
                          return _ScenarioCard(
                            imagePath: s['image']!,
                            title: s['title']!,
                            body: s['body']!,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    _DotsIndicator(count: _scenarios.length, index: _currentPage),
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
                  'Introduction',
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
              widget.competencyTitle,
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
}

class _ScenarioCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String body;

  const _ScenarioCard({
    required this.imagePath,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.asset(
              imagePath,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryGradientStart,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        body,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[700],
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DotsIndicator extends StatelessWidget {
  final int count;
  final int index;

  const _DotsIndicator({
    required this.count,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        final bool isActive = i == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 18 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: isActive ? AppTheme.primaryGradientStart : Colors.grey[400],
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
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
