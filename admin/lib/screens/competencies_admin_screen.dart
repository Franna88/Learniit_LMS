import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/admin_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/admin_sidebar.dart';
import '../widgets/competency_list_item.dart';
import '../models/competency.dart';

class CompetenciesAdminScreen extends StatefulWidget {
  const CompetenciesAdminScreen({super.key});

  @override
  State<CompetenciesAdminScreen> createState() => _CompetenciesAdminScreenState();
}

class _CompetenciesAdminScreenState extends State<CompetenciesAdminScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final adminProvider = context.watch<AdminProvider>();
    final competencies = adminProvider.competencies;

    // Filter competencies based on search and category
    final filteredCompetencies = competencies.where((competency) {
      final matchesSearch = competency.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                           competency.category.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'All' || competency.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    // Get unique categories
    final categories = ['All', ...competencies.map((c) => c.category).toSet().toList()];

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
                            'Competencies Management',
                            style: AdminTheme.heading2,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Manage diving competencies and learning modules',
                            style: AdminTheme.bodyMedium,
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () => _showAddCompetencyDialog(context),
                        icon: const Icon(Icons.add),
                        label: const Text('Add Competency'),
                        style: AdminTheme.primaryButtonStyle,
                      ),
                    ],
                  ),
                ),

                // Filters and Search
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
                            labelText: 'Search competencies...',
                            hintText: 'Enter title or category',
                            prefixIcon: const Icon(Icons.search),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      DropdownButton<String>(
                        value: _selectedCategory,
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value!;
                          });
                        },
                        items: categories.map((category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
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
                  child: adminProvider.isLoadingCompetencies
                      ? const Center(child: CircularProgressIndicator())
                      : filteredCompetencies.isEmpty
                          ? _buildEmptyState()
                          : ListView.builder(
                              padding: const EdgeInsets.all(24),
                              itemCount: filteredCompetencies.length,
                              itemBuilder: (context, index) {
                                final competency = filteredCompetencies[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: CompetencyListItem(
                                    competency: competency,
                                    onEdit: () => _showEditCompetencyDialog(context, competency),
                                    onDelete: () => _showDeleteConfirmation(context, competency),
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
            Icons.book,
            size: 64,
            color: AdminTheme.textMuted,
          ),
          const SizedBox(height: 16),
          Text(
            _searchQuery.isNotEmpty ? 'No competencies found' : 'No competencies yet',
            style: AdminTheme.heading3,
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isNotEmpty
                ? 'Try adjusting your search criteria'
                : 'Get started by adding your first competency',
            style: AdminTheme.bodyMedium.copyWith(
              color: AdminTheme.textMuted,
            ),
          ),
          const SizedBox(height: 24),
          if (_searchQuery.isEmpty)
            ElevatedButton.icon(
              onPressed: () => _showAddCompetencyDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('Add Competency'),
              style: AdminTheme.primaryButtonStyle,
            ),
        ],
      ),
    );
  }

  void _showAddCompetencyDialog(BuildContext context) {
    // TODO: Implement add competency dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Add Competency dialog - Coming Soon')),
    );
  }

  void _showEditCompetencyDialog(BuildContext context, Competency competency) {
    // TODO: Implement edit competency dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Edit ${competency.title} - Coming Soon')),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Competency competency) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Competency'),
        content: Text('Are you sure you want to delete "${competency.title}"? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<AdminProvider>().deleteCompetency(competency.id);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${competency.title} deleted successfully')),
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


