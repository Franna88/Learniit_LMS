import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'profile_screen.dart';

class GuideDetailScreen extends StatefulWidget {
  final String guideTitle;
  final String guideDescription;

  const GuideDetailScreen({
    super.key,
    required this.guideTitle,
    required this.guideDescription,
  });

  @override
  State<GuideDetailScreen> createState() => _GuideDetailScreenState();
}

class _GuideDetailScreenState extends State<GuideDetailScreen> {
  bool _isSaved = false;

  // Dummy data for the guide steps
  final List<Map<String, dynamic>> _guideSteps = [
    {
      'title': '1. Safety First',
      'points': [
        'Locate open the carry case.',
        'Ensure your hands are clean from creams, oils, grease',
        'No open flames or sparks',
      ],
      'icon': Icons.shield,
    },
    {
      'title': '2. Check the cylinder',
      'points': [
        'Check colour coding and in date',
        'Verify pressure gauge reading',
        'Inspect for any visible damage',
      ],
      'icon': Icons.build,
    },
    {
      'title': '3. Prepare the equipment',
      'points': [
        'Assemble the oxygen delivery system',
        'Check all connections are secure',
        'Test the flow regulator',
      ],
      'icon': Icons.settings,
    },
    {
      'title': '4. Assess the patient',
      'points': [
        'Check level of consciousness',
        'Assess breathing pattern and rate',
        'Monitor oxygen saturation levels',
      ],
      'icon': Icons.person,
    },
    {
      'title': '5. Administer oxygen',
      'points': [
        'Select appropriate delivery method',
        'Set correct flow rate',
        'Apply delivery device to patient',
      ],
      'icon': Icons.air,
    },
    {
      'title': '6. Monitor and document',
      'points': [
        'Continuously monitor patient response',
        'Record oxygen flow rate and duration',
        'Document any changes in condition',
      ],
      'icon': Icons.note,
    },
  ];

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
                    // Top Row with Menu, Guide label, and Profile
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        Text(
                          'Guide',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.highlightColor,
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
                    
                    // Main Title
                    Text(
                      widget.guideTitle,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Description
                    Text(
                      widget.guideDescription,
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
            
            // Save Guide Button (positioned to overlap with content)
            Transform.translate(
              offset: const Offset(0, -20),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _isSaved = !_isSaved;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(_isSaved ? 'Guide saved!' : 'Guide removed from saved'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.grey[300]!),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    icon: Icon(
                      _isSaved ? Icons.bookmark : Icons.bookmark_border,
                      size: 18,
                    ),
                    label: Text(
                      'Save guide',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20), // Space for save button
                    
                    // Section Title
                    Text(
                      'Administration of oxygen - Conscious (responsive) and breathing',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryGradientStart,
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Divider line
                    Container(
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Introductory text
                    Text(
                      'Make sure you know this well in preparation for your practical assessment! Verbalise the steps as you go to show your level of knowledge and competence.',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Guide Steps
                    ..._guideSteps.map((step) => _buildGuideStepCard(step)).toList(),
                    
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildGuideStepCard(Map<String, dynamic> step) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title and icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    step['title'],
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryGradientStart,
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGradientStart,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    step['icon'],
                    color: AppTheme.highlightColor,
                    size: 20,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Bullet points
            ...(step['points'] as List<String>).map((point) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6, right: 8),
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      point,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        gradient: AppTheme.mainGradient,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Previous button
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppTheme.primaryGradientStart,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {
                  // TODO: Navigate to previous step
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Previous step')),
                  );
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            
            // Next button
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppTheme.primaryGradientStart,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {
                  // TODO: Navigate to next step
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Next step')),
                  );
                },
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
