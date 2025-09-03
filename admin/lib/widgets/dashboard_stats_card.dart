import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class DashboardStatsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final bool isLoading;

  const DashboardStatsCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.isLoading = false,
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
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AdminTheme.bodyMedium.copyWith(
                    color: AdminTheme.textSecondary,
                  ),
                ),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    size: 24,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (isLoading)
              const SizedBox(
                height: 32,
                child: CircularProgressIndicator(),
              )
            else
              Text(
                value,
                style: AdminTheme.heading1.copyWith(
                  fontSize: 32,
                  color: AdminTheme.textPrimary,
                ),
              ),
            const SizedBox(height: 8),
            Text(
              'items',
              style: AdminTheme.bodySmall.copyWith(
                color: AdminTheme.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


