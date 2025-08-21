import 'package:flutter/material.dart';

class PhoneFrame extends StatelessWidget {
  final String imageAssetPath;
  final IconData fallbackIcon;

  const PhoneFrame({super.key, required this.imageAssetPath, required this.fallbackIcon});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 9 / 19.5,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double outerRadius = 36;
          final double innerRadius = 28;
          final double bezel = 10;

          return Stack(
            children: [
              // Outer device shell
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(outerRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.black, Color(0xFF1A1A1A)],
                  ),
                ),
              ),

              // Buttons (volume/power)
              Positioned(
                left: 2,
                top: constraints.maxHeight * 0.18,
                child: _sideButton(height: 48),
              ),
              Positioned(
                left: 2,
                top: constraints.maxHeight * 0.30,
                child: _sideButton(height: 32),
              ),
              Positioned(
                right: 2,
                top: constraints.maxHeight * 0.22,
                child: _sideButton(height: 56),
              ),

              // Inner screen with bezel padding
              Padding(
                padding: EdgeInsets.all(bezel),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(innerRadius),
                  child: Container(
                    color: Colors.black,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          imageAssetPath,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stack) {
                            return Container(
                              color: Colors.black,
                              child: Icon(fallbackIcon, size: 54, color: Colors.white70),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Notch (speaker & camera)
              Positioned(
                top: bezel + 6,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 120,
                    height: 26,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 44,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.white24,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _sideButton({required double height}) {
    return Container(
      width: 4,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(1, 1),
          ),
        ],
      ),
    );
  }
}


