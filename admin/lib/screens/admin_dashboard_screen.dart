import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/admin_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/admin_sidebar.dart';
import '../widgets/dashboard_stats_card.dart';
import '../widgets/recent_activity_card.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  @override
  void initState() {
    super.initState();
    // Load data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminProvider>().loadCompetencies();
      context.read<AdminProvider>().loadGuides();
      context.read<AdminProvider>().loadAssessments();
    });
  }

  @override
  Widget build(BuildContext context) {
    final adminProvider = context.watch<AdminProvider>();

    return Scaffold(
      body: Row(
        children: [
          const AdminSidebar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dashboard',
                            style: AdminTheme.heading1,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Welcome to the Logit LMS Admin Panel',
                            style: AdminTheme.bodyMedium,
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          // TODO: Implement refresh functionality
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Refreshing data...')),
                          );
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Refresh'),
                        style: AdminTheme.secondaryButtonStyle,
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Stats Cards
                  Row(
                    children: [
                      Expanded(
                        child: DashboardStatsCard(
                          title: 'Total Competencies',
                          value: adminProvider.competencies.length.toString(),
                          icon: Icons.book,
                          color: AdminTheme.primaryColor,
                          isLoading: adminProvider.isLoadingCompetencies,
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: DashboardStatsCard(
                          title: 'Total Guides',
                          value: adminProvider.guides.length.toString(),
                          icon: Icons.menu_book,
                          color: AdminTheme.successColor,
                          isLoading: adminProvider.isLoadingGuides,
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: DashboardStatsCard(
                          title: 'Active Assessments',
                          value: adminProvider.assessments.length.toString(),
                          icon: Icons.assignment,
                          color: AdminTheme.warningColor,
                          isLoading: adminProvider.isLoadingAssessments,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Quick Actions
                  Card(
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
                          Text(
                            'Quick Actions',
                            style: AdminTheme.heading2,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _QuickActionButton(
                                  icon: Icons.add,
                                  label: 'Add Competency',
                                  onTap: () {
                                    // TODO: Navigate to add competency screen
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Add Competency - Coming Soon')),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _QuickActionButton(
                                  icon: Icons.menu_book,
                                  label: 'Add Guide',
                                  onTap: () {
                                    // TODO: Navigate to add guide screen
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Add Guide - Coming Soon')),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _QuickActionButton(
                                  icon: Icons.assignment,
                                  label: 'Create Assessment',
                                  onTap: () {
                                    // TODO: Navigate to create assessment screen
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Create Assessment - Coming Soon')),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _QuickActionButton(
                                  icon: Icons.download,
                                  label: 'Export Data',
                                  onTap: () {
                                    // TODO: Navigate to export screen
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Export Data - Coming Soon')),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Recent Activity
                  Row(
                    children: [
                      Expanded(
                        child: RecentActivityCard(
                          title: 'Recent Competencies',
                          items: adminProvider.competencies.take(3).map((competency) {
                            return ActivityItem(
                              title: competency.title,
                              subtitle: competency.category,
                              timestamp: competency.updatedAt,
                            );
                          }).toList(),
                          isLoading: adminProvider.isLoadingCompetencies,
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: RecentActivityCard(
                          title: 'Recent Guides',
                          items: adminProvider.guides.take(3).map((guide) {
                            return ActivityItem(
                              title: guide.title,
                              subtitle: '${guide.steps.length} steps',
                              timestamp: guide.updatedAt,
                            );
                          }).toList(),
                          isLoading: adminProvider.isLoadingGuides,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: AdminTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AdminTheme.primaryColor.withOpacity(0.2)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: AdminTheme.primaryColor,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: AdminTheme.bodySmall.copyWith(
                color: AdminTheme.primaryColor,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}


