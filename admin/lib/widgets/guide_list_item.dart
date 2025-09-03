import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/guide.dart';

class GuideListItem extends StatelessWidget {
  final Guide guide;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const GuideListItem({
    super.key,
    required this.guide,
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
            // Icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AdminTheme.successColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                guide.icon,
                size: 32,
                color: AdminTheme.successColor,
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
                        guide.title,
                        style: AdminTheme.heading3.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 12),
                      if (guide.isBookmarked)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AdminTheme.warningColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.bookmark,
                                size: 12,
                                color: AdminTheme.warningColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Bookmarked',
                                style: AdminTheme.bodySmall.copyWith(
                                  color: AdminTheme.warningColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    guide.description,
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
                        '${guide.steps.length} steps',
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
                        _formatLastUpdated(guide.updatedAt),
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
                  tooltip: 'Edit guide',
                  color: AdminTheme.primaryColor,
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete),
                  tooltip: 'Delete guide',
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


