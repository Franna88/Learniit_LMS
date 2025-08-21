import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'assessment_detail_screen.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  String _selectedFilter = 'Competent';
  int? _expandedIndex;

  // Sample data - replace with actual data from your backend
  final List<AssessmentResult> _assessmentResults = [
    AssessmentResult(
      category: 'Clinical procedures',
      title: 'Drug administration',
      grade: 'Competent',
      score: 75,
      isExpanded: true,
    ),
    AssessmentResult(
      category: 'Diving accident management',
      title: 'Neurological assessment',
      grade: 'Competent',
      score: 82,
      isExpanded: false,
    ),
  ];

  final List<PendingAssessment> _pendingAssessments = [
    PendingAssessment(
      category: 'Clinical procedures',
      title: 'Fluid resuscitation',
      dueDate: '2 weeks',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAssessmentResultsSection(),
                    const SizedBox(height: 24),
                    _buildPendingResultsSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
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
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  // TODO: Navigate to profile
                },
                icon: const Icon(Icons.person, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.highlightColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.assignment_turned_in,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Results',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssessmentResultsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Assessment results',
              style: AppTheme.heading3,
            ),
            _buildFilterDropdown(),
          ],
        ),
        const SizedBox(height: 16),
        ..._assessmentResults.asMap().entries.map((entry) {
          final index = entry.key;
          final result = entry.value;
          return _buildAssessmentResultCard(result, index);
        }).toList(),
      ],
    );
  }

  Widget _buildFilterDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _selectedFilter,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          Icon(Icons.keyboard_arrow_down, color: Colors.grey[600], size: 16),
        ],
      ),
    );
  }

  Widget _buildAssessmentResultCard(AssessmentResult result, int index) {
    final isExpanded = _expandedIndex == index;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: AppTheme.cardDecoration,
      child: Stack(
        children: [
          Column(
            children: [
              // Header section
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (_expandedIndex == index) {
                      _expandedIndex = null;
                    } else {
                      _expandedIndex = index;
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  result.category,
                                  style: AppTheme.caption.copyWith(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  result.title,
                                  style: AppTheme.heading3.copyWith(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: _getGradeColor(result.grade),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              result.grade,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.checklist,
                            color: AppTheme.primaryGradientStart,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.expand_more,
                            color: AppTheme.primaryGradientStart,
                            size: 24,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Expanded content with green background
              if (isExpanded) ...[
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _getGradeColor(result.grade).withOpacity(0.3),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        result.grade,
                        style: AppTheme.heading3.copyWith(
                          color: AppTheme.primaryGradientStart,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Column(
                            children: [
                                                              SizedBox(
                                  width: 140,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AssessmentDetailScreen(
                                            assessmentTitle: result.title,
                                            assessor: 'Michael McDiver',
                                            learner: 'Jane Diver',
                                            dateAssessed: '15/12/2024',
                                            nextRefresherDue: '15/12/2025',
                                            grade: result.grade,
                                            overallScore: result.score,
                                            assessmentItems: [
                                              AssessmentItem(
                                                name: 'Administration of oxygen',
                                                score: 95,
                                                grade: 'Competent',
                                              ),
                                              AssessmentItem(
                                                name: 'Identify the pillar valve and pressure regulator',
                                                score: 95,
                                                grade: 'Competent',
                                              ),
                                              AssessmentItem(
                                                name: 'Selection of oxygen delivery device',
                                                score: 95,
                                                grade: 'Competent',
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  icon: const Icon(Icons.info_outline, size: 14),
                                  label: const Text('Learn more >', style: TextStyle(fontSize: 12)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.primaryGradientStart,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: 140,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    // TODO: Download result
                                  },
                                  icon: const Icon(Icons.download, size: 14),
                                  label: const Text('Download', style: TextStyle(fontSize: 12)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.primaryGradientStart,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 40),
                          _buildProgressBar(result.score),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),

        ],
      ),
    );
  }

  Widget _buildProgressBar(int score) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        children: [
          CustomPaint(
            size: const Size(120, 120),
            painter: ProgressBarPainter(
              progress: score / 100,
              color: _getGradeColor(_assessmentResults[_expandedIndex!].grade),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$score%',
                  style: AppTheme.heading3.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Overall\nCompetency\nScore',
                  style: AppTheme.caption.copyWith(
                    fontSize: 11,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingResultsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pending results',
          style: AppTheme.heading3,
        ),
        const SizedBox(height: 16),
        ..._pendingAssessments.map((pending) => _buildPendingAssessmentCard(pending)).toList(),
      ],
    );
  }

  Widget _buildPendingAssessmentCard(PendingAssessment pending) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: AppTheme.cardDecoration,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pending.category,
                  style: AppTheme.caption.copyWith(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  pending.title,
                  style: AppTheme.heading3.copyWith(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.schedule, color: Colors.grey[600], size: 14),
                    const SizedBox(width: 4),
                    Text(
                      'Assessment due in ${pending.dueDate}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.checklist,
                    color: AppTheme.primaryGradientStart,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: AppTheme.primaryGradientStart,
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getGradeColor(String grade) {
    switch (grade.toLowerCase()) {
      case 'competent':
        return Colors.green;
      case 'knowledge gap':
        return Colors.orange;
      case 'skills gap':
        return Colors.yellow[700]!;
      case 'not yet competent':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

class AssessmentResult {
  final String category;
  final String title;
  final String grade;
  final int score;
  final bool isExpanded;

  AssessmentResult({
    required this.category,
    required this.title,
    required this.grade,
    required this.score,
    required this.isExpanded,
  });
}

class PendingAssessment {
  final String category;
  final String title;
  final String dueDate;

  PendingAssessment({
    required this.category,
    required this.title,
    required this.dueDate,
  });
}

class ProgressBarPainter extends CustomPainter {
  final double progress;
  final Color color;

  ProgressBarPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 12) / 2;

    // Draw background circle (open side facing down)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      3.14159, // Start angle (180 degrees)
      3.14159, // Sweep angle (180 degrees)
      false,
      paint,
    );

    // Draw progress arc (open side facing down)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      3.14159, // Start angle (180 degrees)
      progress * 3.14159, // Sweep angle (progress * 180 degrees)
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
