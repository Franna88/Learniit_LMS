import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import 'assessor_assessment_screen.dart';
import '../guides_screen.dart';
import 'assessor_dashboard_screen.dart';
import 'assessor_help_screen.dart';
import 'assessor_competencies_screen.dart';
import 'assessor_assessment_list_screen.dart';

class AssessorAssessmentIntroScreen extends StatefulWidget {
  final String category;
  final String title;
  final String learnerName;
  final String assessorName;
  final String? backgroundImageAssetPath;

  const AssessorAssessmentIntroScreen({
    super.key,
    required this.category,
    required this.title,
    required this.learnerName,
    required this.assessorName,
    this.backgroundImageAssetPath,
  });

  @override
  State<AssessorAssessmentIntroScreen> createState() => _AssessorAssessmentIntroScreenState();
}

class _AssessorAssessmentIntroScreenState extends State<AssessorAssessmentIntroScreen> {
  final PageController _pageController = PageController();
  int _pageIndex = 0;
  int _selectedBottomIndex = 0;

  final List<_IntroCard> _cards = const [
    _IntroCard(
      title: 'Candidate directive',
      description:
          'As the oxygen provider, administer oxygen to a fellow dive team member, who is alert and oriented and able to manage their own airway.',
    ),
    _IntroCard(
      title: 'Scenario overview',
      description:
          'You will brief the learner and observe the procedure steps. Provide no help unless safety is at risk.',
    ),
    _IntroCard(
      title: 'Rules and safety',
      description:
          'Ensure equipment checks are completed. Intervene only for safety concerns. Mark skills objectively.',
    ),
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
            _buildHeader(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Instructions', style: AppTheme.heading3),
                    const SizedBox(height: 6),
                    Text(
                      'Share the following information with the learner before you begin the assessment.\nSwipe to learn more.',
                      style: AppTheme.caption,
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: Container(
                        decoration: AppTheme.cardDecoration,
                        child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (i) => setState(() => _pageIndex = i),
                          itemCount: _cards.length,
                          itemBuilder: (context, i) {
                            final c = _cards[i];
                            return Padding(
                              padding: const EdgeInsets.all(20),
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  final bool tall = constraints.maxHeight > 420;
                                  final titleStyle = AppTheme.heading3.copyWith(
                                    fontSize: tall ? 22 : 18,
                                    fontWeight: FontWeight.w700,
                                  );
                                  final bodyStyle = AppTheme.caption.copyWith(
                                    color: Colors.grey[700],
                                    fontSize: tall ? 16 : 14,
                                    height: 1.4,
                                  );
                                  return Column(
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: ConstrainedBox(
                                            constraints: const BoxConstraints(maxWidth: 480),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(c.title, style: titleStyle, textAlign: TextAlign.center),
                                                const SizedBox(height: 16),
                                                Text(c.description, style: bodyStyle, textAlign: TextAlign.center),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      ElevatedButton(
                                        onPressed: i == _cards.length - 1
                                            ? () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => AssessorAssessmentScreen(
                                                      category: widget.category,
                                                      title: widget.title,
                                                      learnerName: widget.learnerName,
                                                      assessorName: widget.assessorName,
                                                      backgroundImageAssetPath: widget.backgroundImageAssetPath,
                                                    ),
                                                  ),
                                                );
                                              }
                                            : () => _pageController.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.easeInOut),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppTheme.primaryGradientStart,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                                        ),
                                        child: Text(i == _cards.length - 1 ? 'Start' : 'Next', style: AppTheme.buttonText),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(child: _buildPagerDots()),
                    const SizedBox(height: 12),
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

  Widget _buildHeader() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: widget.backgroundImageAssetPath != null
                ? Image.asset(widget.backgroundImageAssetPath!, fit: BoxFit.cover)
                : Container(color: AppTheme.primaryGradientStart),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.primaryGradientStart.withOpacity(0.88),
                    AppTheme.primaryGradientEnd.withOpacity(0.88),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(Icons.menu, color: Colors.white, size: 24),
                    Icon(Icons.person, color: Colors.white, size: 24),
                  ],
                ),
                const SizedBox(height: 16),
                Text('Workplace assessment', style: GoogleFonts.poppins(fontSize: 14, color: Colors.amber[200], fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Text(
                  '${widget.title} assesment',
                  style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white, height: 1.2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPagerDots() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(_cards.length, (i) {
        final bool isActive = i == _pageIndex;
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

class _IntroCard {
  final String title;
  final String description;
  const _IntroCard({required this.title, required this.description});
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


