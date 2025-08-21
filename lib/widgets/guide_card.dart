import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GuideCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isBookmarked;
  final VoidCallback? onTap;

  const GuideCard({
    super.key,
    required this.icon,
    required this.title,
    this.isBookmarked = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          // Main card container
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Row(
                children: [
                  // Dark blue left section with icon
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGradientStart,
                    ),
                    child: Center(
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  // White right section with text
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          title,
                          style: AppTheme.bodyText.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Golden bookmark icon in top-right corner (if bookmarked)
          if (isBookmarked)
            Positioned(
              top: 2,
              right: 2,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.highlightColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.bookmark,
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
