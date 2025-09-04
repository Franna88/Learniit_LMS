import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/assessment.dart';

class AssessmentListItem extends StatelessWidget {
  final Assessment assessment;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const AssessmentListItem({
    super.key,
    required this.assessment,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AdminTheme.borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // Status indicator
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: assessment.status.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.assignment,
                size: 32,
                color: assessment.status.color,
              ),
            ),

            const SizedBox(width: 20),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        assessment.title,
                        style: AdminTheme.heading3.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: assessment.status.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          assessment.status.displayName,
                          style: AdminTheme.bodySmall.copyWith(
                            color: assessment.status.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    assessment.description,
                    style: AdminTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.list,
                        size: 16,
                        color: AdminTheme.textMuted,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${assessment.steps.length} steps',
                        style: AdminTheme.bodySmall.copyWith(
                          color: AdminTheme.textMuted,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: AdminTheme.textMuted,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatLastUpdated(assessment.updatedAt),
                        style: AdminTheme.bodySmall.copyWith(
                          color: AdminTheme.textMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 20),

            // Actions
            Column(
              children: [
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit),
                  tooltip: 'Edit assessment',
                  color: AdminTheme.primaryColor,
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete),
                  tooltip: 'Delete assessment',
                  color: AdminTheme.errorColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatLastUpdated(DateTime updatedAt) {
    final now = DateTime.now();
    final difference = now.difference(updatedAt);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}


