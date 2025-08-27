import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import 'assessor_dashboard_screen.dart';
import '../guides_screen.dart';
import 'assessor_help_screen.dart';
import 'assessor_competencies_screen.dart';
import 'assessor_assessment_list_screen.dart';
import '../competency_readiness_screen.dart';
import 'dart:math' as math;

class AssessorWorkplaceAssessmentScreen extends StatefulWidget {
  final String competencyTitle;
  final String imageAssetPath;

  const AssessorWorkplaceAssessmentScreen({
    super.key,
    required this.competencyTitle,
    required this.imageAssetPath,
  });

  @override
  State<AssessorWorkplaceAssessmentScreen> createState() => _AssessorWorkplaceAssessmentScreenState();
}

class _AssessorWorkplaceAssessmentScreenState extends State<AssessorWorkplaceAssessmentScreen> {
  int _stepIndex = 0; // 0 checklist, 1 booking, 2 upload
  bool _readGuide = false;
  bool _passedReadiness = false;
  final List<String> _uploadedFiles = [];

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
                    final height = constraints.maxHeight;
                    switch (_stepIndex) {
                      case 0:
                        return _buildChecklistCard(height);
                      case 1:
                        return _buildBookingCard(height);
                      default:
                        return _buildUploadCard(height);
                    }
                  },
                ),
              ),
            ),
            _buildBottomBar(),
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
                  'Workplace assessment',
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

  Widget _buildChecklistCard(double height) {
    return Container(
      height: height,
      decoration: AppTheme.cardDecoration,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pre-Assessment Checklist',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryGradientStart,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildChecklistItem(
                      'Read the competency guide',
                      'Review the step-by-step guide for ${widget.competencyTitle}',
                      _readGuide,
                      (value) => setState(() => _readGuide = value),
                    ),
                    const SizedBox(height: 12),
                    _buildChecklistItem(
                      'Complete readiness check',
                      'Pass the knowledge assessment for ${widget.competencyTitle}',
                      _passedReadiness,
                      (value) => setState(() => _passedReadiness = value),
                    ),
                    const SizedBox(height: 12),
                    _buildChecklistItem(
                      'Prepare assessment environment',
                      'Ensure all required equipment and materials are available',
                      false,
                      (value) {},
                    ),
                    const SizedBox(height: 12),
                    _buildChecklistItem(
                      'Review assessment criteria',
                      'Familiarize yourself with the competency standards',
                      false,
                      (value) {},
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _readGuide && _passedReadiness ? () => setState(() => _stepIndex = 1) : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGradientStart,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Continue to Booking',
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

  Widget _buildChecklistItem(String title, String description, bool value, Function(bool) onChanged) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: (newValue) => onChanged(newValue ?? false),
            activeColor: AppTheme.primaryGradientStart,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryGradientStart,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(double height) {
    return Container(
      height: height,
      decoration: AppTheme.cardDecoration,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Schedule Assessment',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryGradientStart,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 48,
                          color: AppTheme.primaryGradientStart,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Assessment Booking',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryGradientStart,
                          ),
                        ),
                        const SizedBox(height: 8),
                                                 Text(
                           'Contact your assessor to schedule your workplace assessment for ${widget.competencyTitle}.',
                           style: GoogleFonts.poppins(
                             fontSize: 14,
                             color: Colors.grey[700],
                           ),
                           textAlign: TextAlign.center,
                         ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // TODO: Implement email functionality
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Email assessor')),
                                  );
                                },
                                icon: const Icon(Icons.email),
                                label: const Text('Email'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primaryGradientStart,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // TODO: Implement call functionality
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Call assessor')),
                                  );
                                },
                                icon: const Icon(Icons.phone),
                                label: const Text('Call'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primaryGradientStart,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => setState(() => _stepIndex = 2),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryGradientStart,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Continue to Upload',
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
          ],
        ),
      ),
    );
  }

  Widget _buildUploadCard(double height) {
    return Container(
      height: height,
      decoration: AppTheme.cardDecoration,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upload Evidence',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryGradientStart,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.cloud_upload,
                          size: 48,
                          color: AppTheme.primaryGradientStart,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Upload Assessment Evidence',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryGradientStart,
                          ),
                        ),
                        const SizedBox(height: 8),
                                                 Text(
                           'Upload photos, videos, or documents that demonstrate your competency in ${widget.competencyTitle}.',
                           style: GoogleFonts.poppins(
                             fontSize: 14,
                             color: Colors.grey[700],
                           ),
                           textAlign: TextAlign.center,
                         ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Implement file upload
                            setState(() {
                              _uploadedFiles.add('Evidence_${_uploadedFiles.length + 1}.jpg');
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('File uploaded')),
                            );
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Upload File'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryGradientStart,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_uploadedFiles.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Text(
                      'Uploaded Files:',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryGradientStart,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...(_uploadedFiles.map((file) => Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.file_present, color: AppTheme.primaryGradientStart),
                          const SizedBox(width: 8),
                          Expanded(child: Text(file)),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _uploadedFiles.remove(file);
                              });
                            },
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    ))),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Submit assessment
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Assessment submitted successfully!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGradientStart,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Submit Assessment',
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

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
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
              onPressed: _stepIndex > 0 ? () => setState(() => _stepIndex--) : null,
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          
          // Progress indicator
          Row(
            children: List.generate(3, (i) {
              final bool isActive = i == _stepIndex;
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
              onPressed: _stepIndex < 2 ? () => setState(() => _stepIndex++) : null,
              icon: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
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
