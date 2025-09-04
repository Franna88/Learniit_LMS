import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final isVerySmallScreen = screenWidth < 320; // Very small phones
    final isSmallScreen = screenWidth < 360; // Small phones like iPhone SE

    return Container(
      decoration: BoxDecoration(
        gradient: AppTheme.mainGradient,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isVerySmallScreen ? 2 : (isSmallScreen ? 4 : 8),
          vertical: 12
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              flex: 1,
              child: _buildNavItem(0, Icons.lightbulb, screenWidth),
            ),
            Flexible(
              flex: 1,
              child: _buildNavItem(1, Icons.my_location, screenWidth),
            ),
            Flexible(
              flex: 1,
              child: _buildNavItem(2, Icons.book, screenWidth),
            ),
            Flexible(
              flex: 1,
              child: _buildNavItem(3, Icons.assignment, screenWidth),
            ),
            Flexible(
              flex: 1,
              child: _buildNavItem(4, Icons.help, screenWidth),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, double screenWidth) {
    final isSelected = selectedIndex == index;
    final isVerySmallScreen = screenWidth < 320;
    final isSmallScreen = screenWidth < 360;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isVerySmallScreen ? 4 : (isSmallScreen ? 6 : 12),
          vertical: 8
        ),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: isSelected ? AppTheme.highlightColor : Colors.white,
          size: isVerySmallScreen ? 18 : (isSmallScreen ? 20 : 24),
        ),
      ),
    );
  }
}
