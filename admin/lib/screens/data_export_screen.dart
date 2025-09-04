import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;
import '../providers/admin_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/admin_sidebar.dart';

class DataExportScreen extends StatefulWidget {
  const DataExportScreen({super.key});

  @override
  State<DataExportScreen> createState() => _DataExportScreenState();
}

class _DataExportScreenState extends State<DataExportScreen> {
  bool _isExporting = false;
  bool _isImporting = false;

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
                  Text(
                    'Data Export & Import',
                    style: AdminTheme.heading1,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Export your content data or import from another system',
                    style: AdminTheme.bodyMedium,
                  ),
                  const SizedBox(height: 32),

                  // Export Section
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
                          Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: AdminTheme.successColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.download,
                                  size: 24,
                                  color: AdminTheme.successColor,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Export Data',
                                      style: AdminTheme.heading3,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Download all your competencies, guides, and assessments as JSON files',
                                      style: AdminTheme.bodyMedium.copyWith(
                                        color: AdminTheme.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          const Divider(),
                          const SizedBox(height: 24),

                          // Export options
                          Text(
                            'What to export:',
                            style: AdminTheme.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 16),

                          _buildExportOption(
                            title: 'All Data',
                            description: 'Competencies, Guides, and Assessments',
                            itemCount: adminProvider.competencies.length +
                                      adminProvider.guides.length +
                                      adminProvider.assessments.length,
                            onExport: () => _exportAllData(adminProvider),
                          ),

                          const SizedBox(height: 12),

                          _buildExportOption(
                            title: 'Competencies Only',
                            description: 'Learning modules and competencies',
                            itemCount: adminProvider.competencies.length,
                            onExport: () => _exportCompetencies(adminProvider),
                          ),

                          const SizedBox(height: 12),

                          _buildExportOption(
                            title: 'Guides Only',
                            description: 'Step-by-step procedural guides',
                            itemCount: adminProvider.guides.length,
                            onExport: () => _exportGuides(adminProvider),
                          ),

                          const SizedBox(height: 12),

                          _buildExportOption(
                            title: 'Assessments Only',
                            description: 'Workplace assessment workflows',
                            itemCount: adminProvider.assessments.length,
                            onExport: () => _exportAssessments(adminProvider),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Import Section
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
                          Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: AdminTheme.warningColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.upload,
                                  size: 24,
                                  color: AdminTheme.warningColor,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Import Data',
                                      style: AdminTheme.heading3,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Upload JSON files to import competencies, guides, and assessments',
                                      style: AdminTheme.bodyMedium.copyWith(
                                        color: AdminTheme.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          const Divider(),
                          const SizedBox(height: 24),

                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: AdminTheme.backgroundColor,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AdminTheme.borderColor),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.cloud_upload,
                                  size: 48,
                                  color: AdminTheme.textMuted,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Drag and drop JSON files here',
                                  style: AdminTheme.bodyLarge.copyWith(
                                    color: AdminTheme.textMuted,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'or',
                                  style: AdminTheme.bodySmall.copyWith(
                                    color: AdminTheme.textMuted,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton.icon(
                                  onPressed: _isImporting ? null : _importData,
                                  icon: _isImporting
                                      ? const SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: CircularProgressIndicator(strokeWidth: 2),
                                        )
                                      : const Icon(Icons.upload_file),
                                  label: Text(_isImporting ? 'Importing...' : 'Choose File'),
                                  style: AdminTheme.secondaryButtonStyle,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AdminTheme.warningColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AdminTheme.warningColor.withOpacity(0.2)),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.warning,
                                  size: 20,
                                  color: AdminTheme.warningColor,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Importing will overwrite existing data. Make sure to backup your current data first.',
                                    style: AdminTheme.bodySmall.copyWith(
                                      color: AdminTheme.warningColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Migration Guide
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
                            'Moving to New Codebase',
                            style: AdminTheme.heading3,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Follow these steps to migrate your data to a new system:',
                            style: AdminTheme.bodyMedium,
                          ),
                          const SizedBox(height: 16),
                          _buildMigrationStep(
                            number: 1,
                            title: 'Export your data',
                            description: 'Use the export options above to download your content',
                          ),
                          _buildMigrationStep(
                            number: 2,
                            title: 'Backup files',
                            description: 'Store the exported JSON files in a safe location',
                          ),
                          _buildMigrationStep(
                            number: 3,
                            title: 'Set up new system',
                            description: 'Deploy your new codebase and admin panel',
                          ),
                          _buildMigrationStep(
                            number: 4,
                            title: 'Import data',
                            description: 'Use the import functionality in the new system',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExportOption({
    required String title,
    required String description,
    required int itemCount,
    required VoidCallback onExport,
  }) {
    return InkWell(
      onTap: _isExporting ? null : onExport,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AdminTheme.backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AdminTheme.borderColor),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AdminTheme.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: AdminTheme.bodySmall.copyWith(
                      color: AdminTheme.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AdminTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$itemCount items',
                style: AdminTheme.bodySmall.copyWith(
                  color: AdminTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Icon(
              Icons.download,
              color: AdminTheme.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMigrationStep({
    required int number,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AdminTheme.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: AdminTheme.bodySmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AdminTheme.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AdminTheme.bodySmall.copyWith(
                    color: AdminTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _exportAllData(AdminProvider adminProvider) async {
    setState(() => _isExporting = true);

    try {
      final data = await adminProvider.exportData();
      _downloadJsonFile(data, 'logit_lms_all_data.json');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All data exported successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Export failed: $e')),
      );
    } finally {
      setState(() => _isExporting = false);
    }
  }

  Future<void> _exportCompetencies(AdminProvider adminProvider) async {
    setState(() => _isExporting = true);

    try {
      final data = {
        'competencies': adminProvider.competencies.map((c) => c.toJson()).toList(),
        'exportedAt': DateTime.now().toIso8601String(),
      }.toString();

      _downloadJsonFile(data, 'logit_lms_competencies.json');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Competencies exported successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Export failed: $e')),
      );
    } finally {
      setState(() => _isExporting = false);
    }
  }

  Future<void> _exportGuides(AdminProvider adminProvider) async {
    setState(() => _isExporting = true);

    try {
      final data = {
        'guides': adminProvider.guides.map((g) => g.toJson()).toList(),
        'exportedAt': DateTime.now().toIso8601String(),
      }.toString();

      _downloadJsonFile(data, 'logit_lms_guides.json');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Guides exported successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Export failed: $e')),
      );
    } finally {
      setState(() => _isExporting = false);
    }
  }

  Future<void> _exportAssessments(AdminProvider adminProvider) async {
    setState(() => _isExporting = true);

    try {
      final data = {
        'assessments': adminProvider.assessments.map((a) => a.toJson()).toList(),
        'exportedAt': DateTime.now().toIso8601String(),
      }.toString();

      _downloadJsonFile(data, 'logit_lms_assessments.json');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Assessments exported successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Export failed: $e')),
      );
    } finally {
      setState(() => _isExporting = false);
    }
  }

  void _downloadJsonFile(String data, String filename) {
    final blob = html.Blob([data], 'application/json');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', filename)
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  void _importData() {
    // TODO: Implement file picker for JSON import
    setState(() => _isImporting = true);

    // Simulate import process
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isImporting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Import functionality coming soon!')),
      );
    });
  }
}


