import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_navigation.dart';
import 'main_navigation_screen.dart';

class CompetencyIntroductionScreen extends StatefulWidget {
  final String competencyTitle;
  const CompetencyIntroductionScreen({super.key, required this.competencyTitle});

  @override
  State<CompetencyIntroductionScreen> createState() => _CompetencyIntroductionScreenState();
}

class _CompetencyIntroductionScreenState extends State<CompetencyIntroductionScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _scenarios = [
    {
      'image': 'images/oxygen.jpg',
      'title': 'You are called to the dive shack.',
      'body': 'Marko, a support crew member, is feeling faint and short of breath after working in the hot pump room. His skin is clammy. He can barely speak in full sentences.'
    },
    {
      'image': 'images/drug-administration.jpg',
      'title': 'You gather information.',
      'body': 'You quickly assess the scene for safety and perform a primary survey. You note increased respiratory rate and cool, clammy skin.'
    },
    {
      'image': 'images/oxygen.jpg',
      'title': 'You prepare oxygen.',
      'body': 'You set up the portable oxygen kit following safety procedures and prepare a non-rebreather mask.'
    },
    {
      'image': 'images/drug-administration.jpg',
      'title': 'You start treatment.',
      'body': 'You deliver high-flow oxygen while monitoring response and plan for further medical evaluation.'
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Scenario', style: AppTheme.heading3.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    Text(
                      "Let's look at a real-world situation to see how this skill applies on the job.",
                      style: AppTheme.caption,
                    ),
                    const SizedBox(height: 8),
                    Text('Swipe to learn more', style: GoogleFonts.poppins(fontSize: 11, fontStyle: FontStyle.italic, color: Colors.grey[700])),
                    const SizedBox(height: 12),

                    SizedBox(
                      height: 360,
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
      bottomNavigationBar: BottomNavigation(
        selectedIndex: 1,
        onItemTapped: (index) {
          if (index == 1) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainNavigationScreen(initialIndex: index)),
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
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const Icon(Icons.person, color: Colors.white),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'Introduction',
              style: GoogleFonts.poppins(fontSize: 14, color: AppTheme.highlightColor, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Text(
              widget.competencyTitle,
              style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white),
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

  const _ScenarioCard({required this.imagePath, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      decoration: AppTheme.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            child: Container(
              height: 160,
              width: double.infinity,
              color: AppTheme.secondaryButton,
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTheme.heading3.copyWith(fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text(body, style: AppTheme.caption),
              ],
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
  const _DotsIndicator({required this.count, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isActive = i == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 20 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? AppTheme.primaryGradientStart : Colors.grey[400],
            borderRadius: BorderRadius.circular(8),
          ),
        );
      }),
    );
  }
}


