import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'guide_detail_screen.dart';
import 'competency_readiness_screen.dart';
import 'dart:math' as math;

class WorkplaceAssessmentScreen extends StatefulWidget {
  final String competencyTitle;
  final String imageAssetPath;

  const WorkplaceAssessmentScreen({
    super.key,
    required this.competencyTitle,
    required this.imageAssetPath,
  });

  @override
  State<WorkplaceAssessmentScreen> createState() => _WorkplaceAssessmentScreenState();
}

class _WorkplaceAssessmentScreenState extends State<WorkplaceAssessmentScreen> {
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
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Builder(builder: (context) {
              final double titleSize = math.max(16, math.min(22, height * 0.035));
              final double bodySize = math.max(12, math.min(16, height * 0.028));
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Instructions', style: GoogleFonts.poppins(fontSize: titleSize, fontWeight: FontWeight.w700, color: AppTheme.primaryGradientStart)),
                  const SizedBox(height: 8),
                  Text(
                    "Before starting your assessment, make sure you've done the following to set yourself up for success:",
                    style: GoogleFonts.poppins(fontSize: bodySize, color: AppTheme.primaryGradientStart.withOpacity(0.8)),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                        value: _readGuide,
                        onChanged: (v) => setState(() => _readGuide = v ?? false),
                        activeColor: AppTheme.primaryGradientStart,
                      ),
                      Expanded(
                        child: Text('Read through the ${widget.competencyTitle.toLowerCase()} guide', style: GoogleFonts.poppins(fontSize: bodySize, color: AppTheme.primaryGradientStart)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _passedReadiness,
                        onChanged: (v) => setState(() => _passedReadiness = v ?? false),
                        activeColor: AppTheme.primaryGradientStart,
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.poppins(fontSize: bodySize, color: AppTheme.primaryGradientStart),
                            children: const [
                              TextSpan(text: 'Completed the '),
                              TextSpan(text: 'readiness check ', style: TextStyle(fontWeight: FontWeight.w600)),
                              TextSpan(text: 'with a score above 80%'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (_readGuide && _passedReadiness)
                          ? () => setState(() => _stepIndex = 1)
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryGradientStart,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                      child: const Text('Continue >'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GuideDetailScreen(
                                  guideTitle: widget.competencyTitle,
                                  guideDescription:
                                      'Use this practical skill sheet to ensure you are well prepared and can carry out all the steps safely.',
                                ),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppTheme.primaryGradientStart,
                            side: const BorderSide(color: AppTheme.primaryGradientStart),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('View guide'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CompetencyReadinessScreen(
                                  competencyTitle: widget.competencyTitle,
                                  scenarioImagePath: widget.imageAssetPath,
                                  symptomsImagePath: widget.imageAssetPath,
                                ),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppTheme.primaryGradientStart,
                            side: const BorderSide(color: AppTheme.primaryGradientStart),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Readiness check'),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildBookingCard(double height) {
    return Container(
      height: height,
      decoration: AppTheme.cardDecoration,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Builder(builder: (context) {
              final double titleSize = math.max(18, math.min(22, height * 0.036));
              final double bodySize = math.max(12, math.min(16, height * 0.028));
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(color: AppTheme.secondaryButton, borderRadius: BorderRadius.circular(12)),
                    child: Stack(children: [
                      Positioned(
                        top: 4,
                        left: 4,
                        right: 4,
                        child: Container(height: 8, decoration: BoxDecoration(color: AppTheme.highlightColor, borderRadius: BorderRadius.circular(4))),
                      ),
                      const Center(child: Icon(Icons.assignment, color: AppTheme.primaryGradientStart)),
                    ]),
                  ),
                  const SizedBox(height: 16),
                  Text('Book your assessment', style: GoogleFonts.poppins(fontSize: titleSize, fontWeight: FontWeight.w700, color: AppTheme.primaryGradientStart)),
                  const SizedBox(height: 8),
                  Text(
                    'When you are confident in the steps and have passed the readiness check, speak to a supervisor or approved assessor to schedule your workplace assessment.\n\nAfter your assessment, return here to view your results and upload your evidence.',
                    style: GoogleFonts.poppins(fontSize: bodySize, color: AppTheme.primaryGradientStart.withOpacity(0.85)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey[300]!)),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Qualified assessors:', style: GoogleFonts.poppins(fontSize: bodySize, fontWeight: FontWeight.w600, color: AppTheme.primaryGradientStart)),
                        ),
                        const SizedBox(height: 8),
                        LayoutBuilder(
                          builder: (context, cons) {
                            final bool stack = cons.maxWidth < 360;
                            final Widget left = Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('• Michael McDiver', style: GoogleFonts.poppins(fontSize: bodySize, color: AppTheme.primaryGradientStart)),
                                Text('mcdiver@email.com', style: GoogleFonts.poppins(fontSize: bodySize, color: AppTheme.primaryGradientStart, decoration: TextDecoration.underline)),
                              ],
                            );
                            final Widget right = Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('• John Supervisor', style: GoogleFonts.poppins(fontSize: bodySize, color: AppTheme.primaryGradientStart)),
                                Text('johnsups@email.com', style: GoogleFonts.poppins(fontSize: bodySize, color: AppTheme.primaryGradientStart, decoration: TextDecoration.underline)),
                              ],
                            );
                            if (stack) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  left,
                                  const SizedBox(height: 8),
                                  right,
                                ],
                              );
                            }
                            return Row(
                              children: [
                                Expanded(child: left),
                                const SizedBox(width: 16),
                                Expanded(child: right),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => setState(() => _stepIndex = 2),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryGradientStart,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                      child: const Text('Continue >'),
                    ),
                  ),
                ],
              );
            }),
          ),
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
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Builder(builder: (context) {
              final double titleSize = math.max(16, math.min(20, height * 0.034));
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Submit your evidence for your workplace assessment here.',
                    style: GoogleFonts.poppins(fontSize: titleSize, fontWeight: FontWeight.w600, color: AppTheme.primaryGradientStart),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  _buildUploadField(),
                  const SizedBox(height: 8),
                  if (_uploadedFiles.isNotEmpty)
                    Container(
                      height: 22,
                      decoration: BoxDecoration(color: Colors.green[200], borderRadius: BorderRadius.circular(4)),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text('File uploaded successfully', style: GoogleFonts.poppins(fontSize: 11, color: Colors.green[900])),
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: 160,
                    child: ElevatedButton(
                      onPressed: _uploadedFiles.isEmpty
                          ? null
                          : () {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Evidence submitted')));
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryGradientStart,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(color: AppTheme.primaryGradientStart, borderRadius: BorderRadius.circular(6)),
            child: const Icon(Icons.cloud_upload, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _uploadedFiles.isEmpty ? 'No file chosen' : _uploadedFiles.last,
              style: AppTheme.caption,
            ),
          ),
          TextButton(
            onPressed: _simulateFilePick,
            child: const Text('Choose file'),
          ),
        ],
      ),
    );
  }

  void _simulateFilePick() async {
    // Simulate picking a file by adding a timestamped dummy name
    final filename = 'evidence_${DateTime.now().millisecondsSinceEpoch}.mp4';
    setState(() => _uploadedFiles.add(filename));
  }

  Widget _buildBottomBar() {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppTheme.mainGradient,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Center(
        child: Text(
          _stepIndex == 0
              ? 'Step 1 of 3'
              : _stepIndex == 1
                  ? 'Step 2 of 3'
                  : 'Step 3 of 3',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}


