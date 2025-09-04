import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'assessment_task_detail_screen.dart';
import 'profile_screen.dart';

class AssessmentDetailScreen extends StatelessWidget {
  final String assessmentTitle;
  final String assessor;
  final String learner;
  final String dateAssessed;
  final String nextRefresherDue;
  final String grade;
  final int overallScore;
  final List<AssessmentItem> assessmentItems;

  const AssessmentDetailScreen({
    super.key,
    required this.assessmentTitle,
    required this.assessor,
    required this.learner,
    required this.dateAssessed,
    required this.nextRefresherDue,
    required this.grade,
    required this.overallScore,
    required this.assessmentItems,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSummarySection(),
                    const SizedBox(height: 24),
                    _buildDetailedBreakdown(),
                  ],
                ),
              ),
              _buildFooter(context),
            ],
          ),
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
      child: Column(
        children: [
          // Top navigation row
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
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
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.person, color: Colors.white),
                ),
              ],
            ),
          ),
          // Title section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Text(
                  'Assessment report',
                  style: TextStyle(
                    color: AppTheme.highlightColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  assessmentTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Assessor: $assessor',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Learner: $learner',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
                     // Date and refresher info
           Container(
             margin: const EdgeInsets.symmetric(horizontal: 16),
             padding: const EdgeInsets.all(16),
             decoration: BoxDecoration(
               color: Colors.white.withOpacity(0.1),
               borderRadius: BorderRadius.circular(12),
             ),
             child: Column(
               children: [
                 Row(
                   children: [
                     const Icon(Icons.calendar_today, color: Colors.white, size: 16),
                     const SizedBox(width: 8),
                     Expanded(
                       child: Text(
                         'Date Assessed: $dateAssessed',
                         style: const TextStyle(
                           color: Colors.white,
                           fontSize: 12,
                         ),
                       ),
                     ),
                   ],
                 ),
                 const SizedBox(height: 8),
                 Row(
                   children: [
                     const Icon(Icons.schedule, color: Colors.white, size: 16),
                     const SizedBox(width: 8),
                     Expanded(
                       child: Text(
                         'Next refresher due: $nextRefresherDue',
                         style: const TextStyle(
                           color: Colors.white,
                           fontSize: 12,
                         ),
                       ),
                     ),
                   ],
                 ),
               ],
             ),
           ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSummarySection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _getGradeColor(grade).withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  grade,
                  style: AppTheme.heading2.copyWith(
                    color: _getGradeColor(grade),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Date Assessed: $dateAssessed',
                  style: AppTheme.caption.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          _buildProgressBar(overallScore),
        ],
      ),
    );
  }

  Widget _buildDetailedBreakdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Summary',
          style: AppTheme.heading2,
        ),
        const SizedBox(height: 16),
        ...assessmentItems.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildAssessmentItemCard(item),
        )).toList(),
      ],
    );
  }

  Widget _buildAssessmentItemCard(AssessmentItem item) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
                     // Left section - Task description (white background)
           Expanded(
             flex: 3,
             child: Container(
               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
               child: Text(
                 item.name,
                 style: AppTheme.bodyText.copyWith(
                   fontWeight: FontWeight.w500,
                   color: AppTheme.primaryGradientStart,
                   fontSize: 13,
                 ),
               ),
             ),
           ),
          // Middle section - Percentage (light green background)
          Container(
            width: 80,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: _getGradeColor(item.grade).withOpacity(0.1),
            ),
            child: Center(
              child: Text(
                '${item.score}%',
                style: AppTheme.heading3.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryGradientStart,
                ),
              ),
            ),
          ),
                     // Right section - Competency status (green background with rounded right corners)
           Container(
             constraints: const BoxConstraints(
               minWidth: 80,
               maxWidth: 120,
             ),
             height: double.infinity,
             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
             decoration: BoxDecoration(
               color: _getGradeColor(item.grade),
               borderRadius: const BorderRadius.only(
                 topRight: Radius.circular(10),
                 bottomRight: Radius.circular(10),
               ),
             ),
             child: Center(
               child: Text(
                 item.grade,
                 style: const TextStyle(
                   color: Colors.white,
                   fontSize: 10,
                   fontWeight: FontWeight.w600,
                 ),
                 textAlign: TextAlign.center,
                 overflow: TextOverflow.ellipsis,
               ),
             ),
           ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(int score) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        children: [
          CustomPaint(
            size: const Size(100, 100),
            painter: ProgressBarPainter(
              progress: score / 100,
              color: _getGradeColor(grade),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$score%',
                  style: AppTheme.heading3.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Overall\nCompetency\nScore',
                  style: AppTheme.caption.copyWith(
                    fontSize: 10,
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

  Widget _buildFooter(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppTheme.mainGradient,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Center(
                  child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AssessmentTaskDetailScreen(
                    assessmentTitle: assessmentTitle,
                    tasks: _getSampleTasks(),
                  ),
                ),
              );
            },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppTheme.primaryGradientStart,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: const Text(
            'View detailed',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
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

  List<AssessmentTask> _getSampleTasks() {
    return [
      AssessmentTask(
        number: 1,
        title: 'Safety first',
        icon: Icons.security,
        safetyPoints: [
          SafetyPoint(
            description: 'Safety - Ensures hands are clean and free from hand creams, oil and grease',
            status: 'Knowledge gap',
          ),
          SafetyPoint(
            description: 'Safety - Ensure no open flames or sparks in work area',
            status: 'Competent',
          ),
        ],
      ),
      AssessmentTask(
        number: 2,
        title: 'Check the cylinder',
        icon: Icons.air,
        safetyPoints: [
          SafetyPoint(
            description: 'Safety - Proper Position: Oxygen cylinder securely upright or lying down',
            status: 'Competent',
          ),
          SafetyPoint(
            description: 'Safety - no part of body over cylinder valve',
            status: 'Competent',
          ),
        ],
      ),
    ];
  }
}

class AssessmentItem {
  final String name;
  final int score;
  final String grade;

  AssessmentItem({
    required this.name,
    required this.score,
    required this.grade,
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
