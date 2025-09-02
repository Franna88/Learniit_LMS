import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/competency.dart';

class CompetencyListItem extends StatelessWidget {
  final Competency competency;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CompetencyListItem({
    super.key,
    required this.competency,
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
            // Image placeholder
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AdminTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.image,
                size: 32,
                color: AdminTheme.primaryColor,
              ),
            ),

            const SizedBox(width: 20),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    competency.title,
                    style: AdminTheme.heading3.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AdminTheme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      competency.category,
                      style: AdminTheme.bodySmall.copyWith(
                        color: AdminTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    competency.description,
                    style: AdminTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 16,
                        color: AdminTheme.textMuted,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        competency.dueDateLabel,
                        style: AdminTheme.bodySmall.copyWith(
                          color: AdminTheme.textMuted,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.trending_up,
                        size: 16,
                        color: AdminTheme.textMuted,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${competency.progressPercent}% Complete',
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
                  tooltip: 'Edit competency',
                  color: AdminTheme.primaryColor,
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete),
                  tooltip: 'Delete competency',
                  color: AdminTheme.errorColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


