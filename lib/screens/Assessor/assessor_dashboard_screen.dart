import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import 'assessor_competency_learners_screen.dart';
import '../guides_screen.dart';
import 'assessor_help_screen.dart';
import '../profile_screen.dart';

class AssessorDashboardScreen extends StatefulWidget {
  const AssessorDashboardScreen({super.key});

  @override
  State<AssessorDashboardScreen> createState() => _AssessorDashboardScreenState();
}

class _AssessorDashboardScreenState extends State<AssessorDashboardScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  int _selectedBottomIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
            const SizedBox(height: 8),
            _buildIntroText(),
            _buildTabs(context),
            const SizedBox(height: 12),
            _buildSearchBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _CompetenciesTab(),
                  _LearnersTab(),
                ],
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
              // Already on Assessor Dashboard
              if (_selectedBottomIndex != 0) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const AssessorDashboardScreen()),
                );
              }
              setState(() => _selectedBottomIndex = 0);
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const GuidesScreen(useAssessorNav: true)),
              );
              break;
            case 2:
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
    return Container(
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
                const Icon(Icons.menu, color: Colors.white, size: 24),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfileScreen()),
                    );
                  },
                  child: const Icon(Icons.person, color: Colors.white, size: 24),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Welcome to the\nAssessor Zone,',
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
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Select a competency to assess from the list below.',
          style: AppTheme.bodyText.copyWith(color: Colors.black87),
        ),
      ),
    );
  }

  Widget _buildTabs(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 44,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Custom animated indicator to better match the design
            AnimatedBuilder(
              animation: _tabController.animation!,
              builder: (context, _) {
                final double t = _tabController.animation!.value;
                final double left = 4 + (t * ((MediaQuery.of(context).size.width - 32 - 8) / 2));
                return Positioned(
                  left: left,
                  top: 4,
                  bottom: 4,
                  width: ((MediaQuery.of(context).size.width - 32 - 8) / 2) - 0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: AppTheme.mainGradient,
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                );
              },
            ),
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: AppTheme.primaryGradientStart,
              labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              tabs: const [
                Tab(text: 'Competencies'),
                Tab(text: 'Learners'),
              ],
            ),
          ],
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
}

class _CompetenciesTab extends StatelessWidget {
  final List<_CompetencyItem> _items = const [
    _CompetencyItem(
      category: 'Airway management and oxygen administration',
      title: 'Portable oxygen administration',
      learnersReady: 4,
      imageAssetPath: 'images/oxygen.jpg',
    ),
    _CompetencyItem(
      category: 'Clinical procedures',
      title: 'Drug administration',
      learnersReady: 3,
      imageAssetPath: 'images/drug-administration.jpg',
    ),
    _CompetencyItem(
      category: 'Clinical procedures',
      title: 'Cardiac chest pain',
      learnersReady: 2,
      imageAssetPath: 'images/competencie5.jpg',
    ),
  ];

  const _CompetenciesTab();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      itemCount: _items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = _items[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: AppTheme.cardDecoration,
          child: Row(
            children: [
              // Left: category + title, matching the assessment card layout
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.category,
                      style: AppTheme.caption.copyWith(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.title,
                      style: AppTheme.heading3.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              // Right: grey badge + small action icon (referencing assessment card pattern)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
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
                          Icons.group,
                          size: 12,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${item.learnersReady} learners ready',
                          style: AppTheme.caption.copyWith(
                            fontSize: 10,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AssessorCompetencyLearnersScreen(
                            category: item.category,
                            title: item.title,
                            backgroundImageAssetPath: item.imageAssetPath,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryGradientStart,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(Icons.list_alt, color: Colors.white, size: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LearnersTab extends StatelessWidget {
  final List<_LearnerItem> _learners = const [
    _LearnerItem(name: 'Jane Diver', status: '3 WPAs due this month', color: Color(0xFFFFB3B3)),
    _LearnerItem(name: 'Michael McDiver', status: '3 WPAs due this month', color: Color(0xFFFFB3B3)),
    _LearnerItem(name: 'Ponnappa Priya', status: '3 WPAs due this month', color: Color(0xFFFFB3B3)),
    _LearnerItem(name: 'Andrew Kazantzis', status: '2 WPAs due within 2 months', color: Color(0xFFFFD59E)),
    _LearnerItem(name: 'Maureen M. Smith', status: 'Up to date', color: Color(0xFFB9F6CA)),
  ];

  const _LearnersTab();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      itemCount: _learners.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final learner = _learners[index];
        return Container(
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
        );
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
            _buildNavItem(0, Icons.edit, 'Assess'),
            _buildNavItem(1, Icons.menu_book, 'Guides'),
            _buildNavItem(2, Icons.help, 'Help'),
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppTheme.highlightColor : Colors.white70,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompetencyItem {
  final String category;
  final String title;
  final int learnersReady;
  final String imageAssetPath;
  const _CompetencyItem({
    required this.category,
    required this.title,
    required this.learnersReady,
    required this.imageAssetPath,
  });
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


