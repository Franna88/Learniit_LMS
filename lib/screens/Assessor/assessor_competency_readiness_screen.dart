import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import 'assessor_dashboard_screen.dart';
import '../guides_screen.dart';
import 'assessor_help_screen.dart';
import 'assessor_competencies_screen.dart';
import '../competency_quiz_screen.dart';

class AssessorCompetencyReadinessScreen extends StatefulWidget {
  final String competencyTitle;
  final String scenarioImagePath;
  final String symptomsImagePath;

  const AssessorCompetencyReadinessScreen({
    super.key,
    required this.competencyTitle,
    required this.scenarioImagePath,
    required this.symptomsImagePath,
  });

  @override
  State<AssessorCompetencyReadinessScreen> createState() => _AssessorCompetencyReadinessScreenState();
}

class _AssessorCompetencyReadinessScreenState extends State<AssessorCompetencyReadinessScreen> {
  int _stepIndex = 0; // 0 = intro, 1 = scenario, 2 = symptoms

  void _next() {
    if (_stepIndex < 2) {
      setState(() => _stepIndex += 1);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CompetencyQuizScreen(competencyTitle: widget.competencyTitle),
        ),
      );
    }
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
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return _buildStepCard(constraints.maxHeight);
                  },
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
                  'Readiness check',
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

  Widget _buildStepCard(double height) {
    switch (_stepIndex) {
      case 0:
        return _buildIntroCard(height);
      case 1:
        return _buildScenarioCard(height);
      case 2:
        return _buildSymptomsCard(height);
      default:
        return _buildIntroCard(height);
    }
  }

  Widget _buildIntroCard(double height) {
    return Container(
      height: height,
      decoration: AppTheme.cardDecoration,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.psychology,
              size: 80,
              color: AppTheme.primaryGradientStart,
            ),
            const SizedBox(height: 24),
            Text(
              'Knowledge Check',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryGradientStart,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Test your understanding of ${widget.competencyTitle} before proceeding to the workplace assessment.',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[700],
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _next,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGradientStart,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Start Check',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScenarioCard(double height) {
    return Container(
      height: height,
      decoration: AppTheme.cardDecoration,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              'Scenario',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryGradientStart,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  widget.scenarioImagePath,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Review the scenario above and prepare to answer questions about the assessment criteria.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _next,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGradientStart,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Continue',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSymptomsCard(double height) {
    return Container(
      height: height,
      decoration: AppTheme.cardDecoration,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              'Assessment Criteria',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryGradientStart,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  widget.symptomsImagePath,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Review the assessment criteria and be ready to demonstrate your competency.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _next,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGradientStart,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Start Quiz',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
