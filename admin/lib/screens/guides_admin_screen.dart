import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/admin_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/admin_sidebar.dart';
import '../widgets/guide_list_item.dart';
import '../models/guide.dart';

class GuidesAdminScreen extends StatefulWidget {
  const GuidesAdminScreen({super.key});

  @override
  State<GuidesAdminScreen> createState() => _GuidesAdminScreenState();
}

class _GuidesAdminScreenState extends State<GuidesAdminScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final adminProvider = context.watch<AdminProvider>();
    final guides = adminProvider.guides;

    // Filter guides based on search
    final filteredGuides = guides.where((guide) {
      return guide.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
             guide.description.toLowerCase().contains(_searchQuery.toLowerCase());
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
                            'Guides Management',
                            style: AdminTheme.heading2,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Manage step-by-step procedural guides',
                            style: AdminTheme.bodyMedium,
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () => _showAddGuideDialog(context),
                        icon: const Icon(Icons.add),
                        label: const Text('Add Guide'),
                        style: AdminTheme.primaryButtonStyle,
                      ),
                    ],
                  ),
                ),

                // Search
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
                            labelText: 'Search guides...',
                            hintText: 'Enter title or description',
                            prefixIcon: const Icon(Icons.search),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Content
                Expanded(
                  child: adminProvider.isLoadingGuides
                      ? const Center(child: CircularProgressIndicator())
                      : filteredGuides.isEmpty
                          ? _buildEmptyState()
                          : ListView.builder(
                              padding: const EdgeInsets.all(24),
                              itemCount: filteredGuides.length,
                              itemBuilder: (context, index) {
                                final guide = filteredGuides[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: GuideListItem(
                                    guide: guide,
                                    onEdit: () => _showEditGuideDialog(context, guide),
                                    onDelete: () => _showDeleteConfirmation(context, guide),
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
            Icons.menu_book,
            size: 64,
            color: AdminTheme.textMuted,
          ),
          const SizedBox(height: 16),
          Text(
            _searchQuery.isNotEmpty ? 'No guides found' : 'No guides yet',
            style: AdminTheme.heading3,
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isNotEmpty
                ? 'Try adjusting your search criteria'
                : 'Get started by adding your first guide',
            style: AdminTheme.bodyMedium.copyWith(
              color: AdminTheme.textMuted,
            ),
          ),
          const SizedBox(height: 24),
          if (_searchQuery.isEmpty)
            ElevatedButton.icon(
              onPressed: () => _showAddGuideDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('Add Guide'),
              style: AdminTheme.primaryButtonStyle,
            ),
        ],
      ),
    );
  }

  void _showAddGuideDialog(BuildContext context) {
    // TODO: Implement add guide dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Add Guide dialog - Coming Soon')),
    );
  }

  void _showEditGuideDialog(BuildContext context, Guide guide) {
    // TODO: Implement edit guide dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Edit ${guide.title} - Coming Soon')),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Guide guide) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Guide'),
        content: Text('Are you sure you want to delete "${guide.title}"? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<AdminProvider>().deleteGuide(guide.id);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${guide.title} deleted successfully')),
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


