import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/competency_card.dart';
import 'profile_screen.dart';
import 'competency_detail_screen.dart';

class CompetenciesScreen extends StatefulWidget {
  const CompetenciesScreen({super.key});

  @override
  State<CompetenciesScreen> createState() => _CompetenciesScreenState();
}

class _CompetenciesScreenState extends State<CompetenciesScreen> {
  final TextEditingController _searchController = TextEditingController(text: 'Diver medic');

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
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ProfileScreen()),
                            );
                          },
                          icon: const Icon(Icons.person, color: Colors.white),
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
                      'Browse all competencies  to find what you need.',
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
                      'Click on the competencies below to refresh your knowledge and prepare for assessments.',
                      style: AppTheme.caption,
                    ),
                    const SizedBox(height: 16),

                    CompetencyCard(
                      category: 'Airway management and oxygen administration',
                      title: 'Cardiac chest pain',
                      dueDateLabel: 'Assessment due in 2 weeks',
                      progressPercent: 25,
                      imageAssetPath: 'images/oxygen.jpg',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CompetencyDetailScreen(
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
                      dueDateLabel: 'Assessment due in 2 weeks',
                      progressPercent: 50,
                      imageAssetPath: 'images/oxygen.jpg',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CompetencyDetailScreen(
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
                      dueDateLabel: 'Assessment due in 2 weeks',
                      progressPercent: 50,
                      imageAssetPath: 'images/drug-administration.jpg',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CompetencyDetailScreen(
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
    );
  }
}


