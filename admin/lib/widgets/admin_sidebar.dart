import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../screens/admin_dashboard_screen.dart';
import '../screens/competencies_admin_screen.dart';
import '../screens/guides_admin_screen.dart';
import '../screens/assessments_admin_screen.dart';
import '../screens/data_export_screen.dart';

class AdminSidebar extends StatefulWidget {
  const AdminSidebar({super.key});

  @override
  State<AdminSidebar> createState() => _AdminSidebarState();
}

class _AdminSidebarState extends State<AdminSidebar> {
  String _selectedRoute = '/';

  final List<_MenuItem> _menuItems = [
    _MenuItem(
      title: 'Dashboard',
      icon: Icons.dashboard,
      route: '/',
      screen: const AdminDashboardScreen(),
    ),
    _MenuItem(
      title: 'Competencies',
      icon: Icons.book,
      route: '/competencies',
      screen: const CompetenciesAdminScreen(),
    ),
    _MenuItem(
      title: 'Guides',
      icon: Icons.menu_book,
      route: '/guides',
      screen: const GuidesAdminScreen(),
    ),
    _MenuItem(
      title: 'Assessments',
      icon: Icons.assignment,
      route: '/assessments',
      screen: const AssessmentsAdminScreen(),
    ),
    _MenuItem(
      title: 'Data Export',
      icon: Icons.download,
      route: '/export',
      screen: const DataExportScreen(),
    ),
  ];

  void _navigateToRoute(String route) {
    setState(() {
      _selectedRoute = route;
    });

    final menuItem = _menuItems.firstWhere((item) => item.route == route);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => menuItem.screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: const BoxDecoration(
        color: AdminTheme.surfaceColor,
        border: Border(
          right: BorderSide(color: AdminTheme.borderColor),
        ),
      ),
      child: Column(
        children: [
          // Logo/Header
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: AdminTheme.primaryColor,
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.book,
                    color: AdminTheme.primaryColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Logit Admin',
                      style: AdminTheme.heading3.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'LMS Management',
                      style: AdminTheme.bodySmall.copyWith(
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Navigation Menu
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: ListView.builder(
                itemCount: _menuItems.length,
                itemBuilder: (context, index) {
                  final item = _menuItems[index];
                  final isSelected = _selectedRoute == item.route;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: InkWell(
                      onTap: () => _navigateToRoute(item.route),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AdminTheme.primaryColor.withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              item.icon,
                              size: 20,
                              color: isSelected
                                  ? AdminTheme.primaryColor
                                  : AdminTheme.textSecondary,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              item.title,
                              style: AdminTheme.bodyMedium.copyWith(
                                color: isSelected
                                    ? AdminTheme.primaryColor
                                    : AdminTheme.textSecondary,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Footer
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AdminTheme.backgroundColor,
              border: const Border(
                top: BorderSide(color: AdminTheme.borderColor),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AdminTheme.successColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.check_circle,
                        size: 16,
                        color: AdminTheme.successColor,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'System Status',
                            style: AdminTheme.bodySmall.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'All systems operational',
                            style: AdminTheme.bodySmall.copyWith(
                              color: AdminTheme.textMuted,
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
    );
  }
}

class _MenuItem {
  final String title;
  final IconData icon;
  final String route;
  final Widget screen;

  _MenuItem({
    required this.title,
    required this.icon,
    required this.route,
    required this.screen,
  });
}


