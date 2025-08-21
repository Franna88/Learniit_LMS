import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_navigation.dart';
import 'main_navigation_screen.dart';
import 'competency_quiz_screen.dart';

class CompetencyReadinessScreen extends StatefulWidget {
  final String competencyTitle;
  final String scenarioImagePath;
  final String symptomsImagePath;

  const CompetencyReadinessScreen({
    super.key,
    required this.competencyTitle,
    required this.scenarioImagePath,
    required this.symptomsImagePath,
  });

  @override
  State<CompetencyReadinessScreen> createState() => _CompetencyReadinessScreenState();
}

class _CompetencyReadinessScreenState extends State<CompetencyReadinessScreen> {
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
      bottomNavigationBar: BottomNavigation(
        selectedIndex: 1,
        onItemTapped: (index) {
          if (index == 1) return;
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
      default:
        return _buildSymptomsCard(height);
    }
  }

  Widget _buildIntroCard(double height) {
    return Container(
      height: height,
      decoration: AppTheme.cardDecoration,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppTheme.secondaryButton,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 6,
                  left: 6,
                  right: 6,
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppTheme.highlightColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const Center(
                  child: Icon(Icons.autorenew, color: AppTheme.primaryGradientStart, size: 28),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text('Introduction', style: AppTheme.heading3),
          const SizedBox(height: 8),
          Text(
            "This quick check helps you decide whether you're ready to request your workplace assessment.",
            style: AppTheme.caption,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          _primaryButton(label: 'Next', onPressed: _next),
        ],
      ),
    );
  }

  Widget _buildScenarioCard(double height) {
    return Container(
      height: height,
      decoration: AppTheme.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            child: Image.asset(widget.scenarioImagePath, height: 180, width: double.infinity, fit: BoxFit.cover),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Scenario', style: AppTheme.heading3.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Text(
                    'You are working on Platform X Factor in the Enormous Sea for Client Diveman. One of the operational 25-year-old male Bob Diver, has presented to the clinic.',
                    style: AppTheme.caption,
                  ),
                  const Spacer(),
                  Center(child: _primaryButton(label: 'Next', onPressed: _next)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSymptomsCard(double height) {
    return Container(
      height: height,
      decoration: AppTheme.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            child: Image.asset(widget.symptomsImagePath, height: 180, width: double.infinity, fit: BoxFit.cover),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Symptoms (present since yesterday):', style: AppTheme.heading3.copyWith(fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  _bullet('Tiredness'),
                  _bullet('Thirst'),
                  _bullet('Stomach cramps'),
                  const SizedBox(height: 12),
                  Text(
                    'He arrived 48 hours ago from South Africa to India. He has not dived yet.',
                    style: AppTheme.caption,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You are the designated healthcare provider.',
                    style: AppTheme.caption,
                  ),
                  const Spacer(),
                  Center(child: _primaryButton(label: 'Start', onPressed: _next)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _primaryButton({required String label, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryGradientStart,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        elevation: 2,
      ),
      child: Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 7),
            width: 5,
            height: 5,
            decoration: BoxDecoration(color: AppTheme.primaryGradientStart, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: AppTheme.caption)),
        ],
      ),
    );
  }
}


