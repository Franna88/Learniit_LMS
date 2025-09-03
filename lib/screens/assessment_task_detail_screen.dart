import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'profile_screen.dart';

class AssessmentTaskDetailScreen extends StatelessWidget {
  final String assessmentTitle;
  final List<AssessmentTask> tasks;

  const AssessmentTaskDetailScreen({
    super.key,
    required this.assessmentTitle,
    required this.tasks,
  });

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
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...tasks.map((task) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _buildTaskCard(task),
                        )),
                  ],
                ),
              ),
            ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detailed breakdown',
                  style: TextStyle(
                    color: AppTheme.highlightColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  assessmentTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(AssessmentTask task) {
    return Container(
      decoration: AppTheme.cardDecoration,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppTheme.primaryGradientStart,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  task.icon,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '${task.number}. ${task.title}',
                  style: AppTheme.heading3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...task.safetyPoints.asMap().entries.map((entry) {
            final int index = entry.key;
            final SafetyPoint point = entry.value;
            return Column(
              children: [
                _buildSafetyPointRow(point),
                if (index != task.safetyPoints.length - 1) ...[
                  const SizedBox(height: 12),
                  Divider(color: Colors.grey[200], height: 1),
                  const SizedBox(height: 12),
                ],
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSafetyPointRow(SafetyPoint point) {
    final Color statusColor = _getGradeColor(point.status);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            point.description,
            style: AppTheme.bodyText.copyWith(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            point.status,
            style: TextStyle(
              color: statusColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Color _getGradeColor(String status) {
    switch (status.toLowerCase()) {
      case 'competent':
        return Colors.green;
      case 'knowledge gap':
        return Colors.orange;
      case 'skills gap':
        return Colors.yellow;
      case 'not yet competent':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

class AssessmentTask {
  final int number;
  final String title;
  final IconData icon;
  final List<SafetyPoint> safetyPoints;

  AssessmentTask({
    required this.number,
    required this.title,
    required this.icon,
    required this.safetyPoints,
  });
}

class SafetyPoint {
  final String description;
  final String status;

  SafetyPoint({
    required this.description,
    required this.status,
  });
}
