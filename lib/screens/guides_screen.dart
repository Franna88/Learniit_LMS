import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/guide_card.dart';
import 'profile_screen.dart';
import 'guide_detail_screen.dart';
import 'Assessor/assessor_dashboard_screen.dart';
import 'Assessor/assessor_help_screen.dart';

class GuidesScreen extends StatefulWidget {
  final bool useAssessorNav;

  const GuidesScreen({super.key, this.useAssessorNav = false});

  @override
  State<GuidesScreen> createState() => _GuidesScreenState();
}

class _GuidesScreenState extends State<GuidesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  int _assessorSelectedIndex = 1; // 0: Assess, 1: Guides, 2: Help

  // Sample guide data - in a real app, this would come from an API or database
  final List<Map<String, dynamic>> _allGuides = [
    {
      'title': 'Key Terminology', 
      'icon': Icons.search, 
      'isBookmarked': true,
      'description': 'Essential medical terminology and definitions for diving professionals.',
    },
    {
      'title': 'Primary Survey', 
      'icon': Icons.assignment, 
      'isBookmarked': true,
      'description': 'Step-by-step guide for conducting a primary survey assessment.',
    },
    {
      'title': 'Secondary Survey', 
      'icon': Icons.assignment, 
      'isBookmarked': true,
      'description': 'Comprehensive secondary assessment procedures and protocols.',
    },
    {
      'title': 'Documentation', 
      'icon': Icons.folder, 
      'isBookmarked': true,
      'description': 'Proper documentation procedures for medical incidents.',
    },
    {
      'title': 'Burns', 
      'icon': Icons.local_fire_department, 
      'isBookmarked': false,
      'description': 'Assessment and treatment protocols for burn injuries.',
    },
    {
      'title': 'Electrical injury', 
      'icon': Icons.electric_bolt, 
      'isBookmarked': false,
      'description': 'Emergency response procedures for electrical injuries.',
    },
    {
      'title': 'Poisonings', 
      'icon': Icons.science, 
      'isBookmarked': false,
      'description': 'Identification and treatment of poisoning cases.',
    },
    {
      'title': 'Chest trauma', 
      'icon': Icons.favorite, 
      'isBookmarked': false,
      'description': 'Assessment and management of chest trauma injuries.',
    },
    {
      'title': 'Cardiac', 
      'icon': Icons.favorite_border, 
      'isBookmarked': false,
      'description': 'Cardiac assessment and emergency response procedures.',
    },
    {
      'title': 'Blood', 
      'icon': Icons.bloodtype, 
      'isBookmarked': false,
      'description': 'Blood-related procedures and transfusion protocols.',
    },
    {
      'title': 'Airway Management', 
      'icon': Icons.air, 
      'isBookmarked': false,
      'description': 'Airway assessment and management techniques.',
    },
    {
      'title': 'Oxygen Administration', 
      'icon': Icons.airline_seat_flat, 
      'isBookmarked': false,
      'description': 'Use this practical skill sheet to ensure you are well prepared for your workplace assessment and can carry out all the steps.',
    },
    {
      'title': 'Drug Administration', 
      'icon': Icons.medication, 
      'isBookmarked': false,
      'description': 'Safe drug administration procedures and protocols.',
    },
    {
      'title': 'Neurological Assessment', 
      'icon': Icons.psychology, 
      'isBookmarked': false,
      'description': 'Neurological assessment procedures and evaluation techniques.',
    },
    {
      'title': 'Diving Accident Management', 
      'icon': Icons.water, 
      'isBookmarked': false,
      'description': 'Emergency response procedures for diving accidents.',
    },
    {
      'title': 'Emergency Response', 
      'icon': Icons.emergency, 
      'isBookmarked': false,
      'description': 'General emergency response protocols and procedures.',
    },
  ];

  List<Map<String, dynamic>> get _filteredGuides {
    if (_searchQuery.isEmpty) {
      return _allGuides;
    }
    return _allGuides.where((guide) =>
        guide['title'].toLowerCase().contains(_searchQuery.toLowerCase())).toList();
  }

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
                    // Top Row with Menu and Profile
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            // TODO: Implement menu functionality
                          },
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 24,
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
                    
                    // Title with Book Icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.book,
                          color: AppTheme.highlightColor,
                          size: 32,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Guides',
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Description
                    Text(
                      'Browse the guides below to review key procedures, terms, and emergency response steps.',
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
            
            // Main Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Search Bar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              onChanged: (value) {
                                setState(() {
                                  _searchQuery = value;
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: 'Search',
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.tune,
                            color: Colors.grey[600],
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Guides Grid
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.1,
                        ),
                        itemCount: _filteredGuides.length,
                        itemBuilder: (context, index) {
                          final guide = _filteredGuides[index];
                          return GuideCard(
                            icon: guide['icon'],
                            title: guide['title'],
                            isBookmarked: guide['isBookmarked'],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GuideDetailScreen(
                                    guideTitle: guide['title'],
                                    guideDescription: guide['description'],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: widget.useAssessorNav
          ? _AssessorBottomBar(
              selectedIndex: _assessorSelectedIndex,
              onItemTapped: (index) {
                switch (index) {
                  case 0:
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const AssessorDashboardScreen()),
                    );
                    break;
                  case 1:
                    setState(() => _assessorSelectedIndex = 1);
                    break;
                  case 2:
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const AssessorHelpScreen()),
                    );
                    break;
                }
              },
            )
          : null,
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
