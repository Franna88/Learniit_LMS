import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/admin_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/admin_sidebar.dart';
import '../widgets/assessment_list_item.dart';
import '../models/assessment.dart';

class AssessmentsAdminScreen extends StatefulWidget {
  const AssessmentsAdminScreen({super.key});

  @override
  State<AssessmentsAdminScreen> createState() => _AssessmentsAdminScreenState();
}

class _AssessmentsAdminScreenState extends State<AssessmentsAdminScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  AssessmentStatus? _selectedStatus;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final adminProvider = context.watch<AdminProvider>();
    final assessments = adminProvider.assessments;

    // Filter assessments based on search and status
    final filteredAssessments = assessments.where((assessment) {
      final matchesSearch = assessment.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                           assessment.description.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesStatus = _selectedStatus == null || assessment.status == _selectedStatus;
      return matchesSearch && matchesStatus;
    }).toList();

    return Scaffold(
      body: Row(
        children: [
          const AdminSidebar(),
          Expanded(
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: AdminTheme.surfaceColor,
                    border: Border(
                      bottom: BorderSide(color: AdminTheme.borderColor),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Assessments Management',
                            style: AdminTheme.heading2,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Manage workplace assessment workflows',
                            style: AdminTheme.bodyMedium,
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () => _showAddAssessmentDialog(context),
                        icon: const Icon(Icons.add),
                        label: const Text('Create Assessment'),
                        style: AdminTheme.primaryButtonStyle,
                      ),
                    ],
                  ),
                ),

                // Filters
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: AdminTheme.surfaceColor,
                    border: Border(
                      bottom: BorderSide(color: AdminTheme.borderColor),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                          },
                          decoration: AdminTheme.inputDecoration(
                            labelText: 'Search assessments...',
                            hintText: 'Enter title or description',
                            prefixIcon: const Icon(Icons.search),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      DropdownButton<AssessmentStatus?>(
                        value: _selectedStatus,
                        onChanged: (value) {
                          setState(() {
                            _selectedStatus = value;
                          });
                        },
                        items: [
                          const DropdownMenuItem<AssessmentStatus?>(
                            value: null,
                            child: Text('All Statuses'),
                          ),
                          ...AssessmentStatus.values.map((status) {
                            return DropdownMenuItem(
                              value: status,
                              child: Text(status.displayName),
                            );
                          }),
                        ],
                        style: AdminTheme.bodyMedium,
                        underline: Container(
                          height: 1,
                          color: AdminTheme.borderColor,
                        ),
                      ),
                    ],
                  ),
                ),

                // Content
                Expanded(
                  child: adminProvider.isLoadingAssessments
                      ? const Center(child: CircularProgressIndicator())
                      : filteredAssessments.isEmpty
                          ? _buildEmptyState()
                          : ListView.builder(
                              padding: const EdgeInsets.all(24),
                              itemCount: filteredAssessments.length,
                              itemBuilder: (context, index) {
                                final assessment = filteredAssessments[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: AssessmentListItem(
                                    assessment: assessment,
                                    onEdit: () => _showEditAssessmentDialog(context, assessment),
                                    onDelete: () => _showDeleteConfirmation(context, assessment),
                                  ),
                                );
                              },
                            ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.assignment,
            size: 64,
            color: AdminTheme.textMuted,
          ),
          const SizedBox(height: 16),
          Text(
            _searchQuery.isNotEmpty ? 'No assessments found' : 'No assessments yet',
            style: AdminTheme.heading3,
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isNotEmpty
                ? 'Try adjusting your search criteria'
                : 'Get started by creating your first assessment',
            style: AdminTheme.bodyMedium.copyWith(
              color: AdminTheme.textMuted,
            ),
          ),
          const SizedBox(height: 24),
          if (_searchQuery.isEmpty)
            ElevatedButton.icon(
              onPressed: () => _showAddAssessmentDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('Create Assessment'),
              style: AdminTheme.primaryButtonStyle,
            ),
        ],
      ),
    );
  }

  void _showAddAssessmentDialog(BuildContext context) {
    // TODO: Implement add assessment dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Create Assessment dialog - Coming Soon')),
    );
  }

  void _showEditAssessmentDialog(BuildContext context, Assessment assessment) {
    // TODO: Implement edit assessment dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Edit ${assessment.title} - Coming Soon')),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Assessment assessment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Assessment'),
        content: Text('Are you sure you want to delete "${assessment.title}"? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<AdminProvider>().deleteAssessment(assessment.id);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${assessment.title} deleted successfully')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: AdminTheme.errorColor),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}


