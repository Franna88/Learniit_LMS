import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import 'assessor_assessment_intro_screen.dart';
import '../guides_screen.dart';
import 'assessor_dashboard_screen.dart';
import 'assessor_help_screen.dart';
import 'assessor_competencies_screen.dart';
import 'assessor_assessment_list_screen.dart';

class AssessorCompetencyLearnersScreen extends StatefulWidget {
  final String category;
  final String title;
  final String? backgroundImageAssetPath;

  const AssessorCompetencyLearnersScreen({
    super.key,
    required this.category,
    required this.title,
    this.backgroundImageAssetPath,
  });

  @override
  State<AssessorCompetencyLearnersScreen> createState() => _AssessorCompetencyLearnersScreenState();
}

class _AssessorCompetencyLearnersScreenState extends State<AssessorCompetencyLearnersScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedBottomIndex = 0;

  final List<_LearnerItem> _learners = const [
    _LearnerItem(name: 'Jane Diver', status: '3 WPAs due this month', color: Color(0xFFFFB3B3)),
    _LearnerItem(name: 'Michael McDiver', status: '3 WPAs due this month', color: Color(0xFFFFB3B3)),
    _LearnerItem(name: 'Ponnappa Priya', status: '3 WPAs due this month', color: Color(0xFFFFB3B3)),
    _LearnerItem(name: 'Andrew Kazantzis', status: '2 WPAs due within 2 months', color: Color(0xFFFFD59E)),
    _LearnerItem(name: 'Maureen M. Smith', status: 'Up to date', color: Color(0xFFB9F6CA)),
    _LearnerItem(name: 'Hayman Andrews', status: 'Up to date', color: Color(0xFFB9F6CA)),
  ];

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
            _buildHeader(),
            _buildInstruction(),
            _buildSearchBar(),
            Expanded(child: _buildLearnersList()),
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
          // Background image
          Positioned.fill(
            child: widget.backgroundImageAssetPath != null
                ? Image.asset(
                    widget.backgroundImageAssetPath!,
                    fit: BoxFit.cover,
                  )
                : Container(color: AppTheme.primaryGradientStart),
          ),
          // Blue transparent overlay (gradient)
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
          // Content
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
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
                Text(
                  widget.category,
                  style: AppTheme.caption.copyWith(color: Colors.white.withOpacity(0.9)),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.title,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstruction() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Select a learner to assess from the list below.',
          style: AppTheme.bodyText.copyWith(color: AppTheme.primaryGradientStart),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: TextField(
        controller: _searchController,
        decoration: AppTheme.inputDecoration.copyWith(
          hintText: 'Search',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () {},
          ),
        ),
      ),
    );
  }

  Widget _buildLearnersList() {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      itemCount: _learners.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final learner = _learners[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AssessorAssessmentIntroScreen(
                  category: widget.category,
                  title: widget.title,
                  learnerName: learner.name,
                  assessorName: 'Michael McDiver',
                  backgroundImageAssetPath: widget.backgroundImageAssetPath,
                ),
              ),
            );
          },
          child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: learner.color.withOpacity(0.7),
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
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
              Expanded(
                child: Text(
                  learner.name,
                  style: AppTheme.bodyText.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  learner.status,
                  style: AppTheme.caption.copyWith(
                    fontWeight: FontWeight.w600,
                    color: _statusTextColor(learner.status),
                  ),
                ),
              ),
            ],
          ),
        ));
      },
    );
  }

  Color _statusTextColor(String status) {
    final s = status.toLowerCase();
    if (s.contains('up to date')) {
      return Colors.green[700]!;
    }
    if (s.contains('within 2 months')) {
      return Colors.orange[700]!;
    }
    if (s.contains('due')) {
      return Colors.red[600]!;
    }
    return AppTheme.primaryGradientStart;
  }
}

class _LearnerItem {
  final String name;
  final String status;
  final Color color;
  const _LearnerItem({
    required this.name,
    required this.status,
    required this.color,
  });
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


