import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CompetencyCard extends StatelessWidget {
  final String category;
  final String title;
  final String dueDateLabel;
  final int progressPercent;
  final String imageAssetPath;
  final VoidCallback? onTap;

  const CompetencyCard({
    super.key,
    required this.category,
    required this.title,
    required this.dueDateLabel,
    required this.progressPercent,
    required this.imageAssetPath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  imageAssetPath,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                  child: Container(color: Colors.transparent),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppTheme.primaryGradientStart.withOpacity(0.6),
                        AppTheme.primaryGradientEnd.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category,
                            style: AppTheme.caption.copyWith(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            title,
                            style: AppTheme.heading3.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 12,
                                color: Colors.white.withOpacity(0.8),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                dueDateLabel,
                                style: AppTheme.caption.copyWith(
                                  fontSize: 10,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 48,
                          height: 48,
                          child: Stack(
                            children: [
                              CustomPaint(
                                size: const Size(48, 48),
                                painter: _HalfCirclePainter(
                                  progress: 1.0,
                                  color: Colors.white.withOpacity(0.2),
                                  strokeWidth: 5,
                                ),
                              ),
                              CustomPaint(
                                size: const Size(48, 48),
                                painter: _HalfCirclePainter(
                                  progress: progressPercent / 100,
                                  color: AppTheme.highlightColor,
                                  strokeWidth: 5,
                                ),
                              ),
                              Center(
                                child: Text(
                                  '$progressPercent%',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HalfCirclePainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  _HalfCirclePainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(
      rect,
      3.14159,
      progress * 3.14159,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_HalfCirclePainter oldDelegate) {
    return oldDelegate.progress != progress ||
           oldDelegate.color != color ||
           oldDelegate.strokeWidth != strokeWidth;
  }
}


