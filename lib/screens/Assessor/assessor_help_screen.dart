import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_theme.dart';
import 'assessor_dashboard_screen.dart';
import '../guides_screen.dart';

class AssessorHelpScreen extends StatefulWidget {
  const AssessorHelpScreen({super.key});

  @override
  State<AssessorHelpScreen> createState() => _AssessorHelpScreenState();
}

class _AssessorHelpScreenState extends State<AssessorHelpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  int _selectedIndex = 2; // Assess, Guides, Help

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Assessor tips', style: AppTheme.heading2),
                    const SizedBox(height: 8),
                    _buildHowToList(),
                    const SizedBox(height: 24),
                    Text('Report an issue', style: AppTheme.heading2),
                    const SizedBox(height: 12),
                    _buildReportForm(),
                    const SizedBox(height: 12),
                    _buildAlternateContact(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _AssessorBottomBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const AssessorDashboardScreen()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const GuidesScreen(useAssessorNav: true)),
              );
              break;
            case 2:
              setState(() => _selectedIndex = 2);
              break;
          }
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppTheme.mainGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: const [
            SizedBox(height: 8),
            Icon(Icons.help, color: AppTheme.highlightColor, size: 32),
            SizedBox(height: 8),
            Text(
              'Help',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Guidance for assessors and a way to report issues.',
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildHowToList() {
    final List<_Tip> tips = const [
      _Tip(
        title: 'Find learners ready for WPA',
        description: 'On the Assess tab, use the Competencies list to see how many learners are ready.',
        icon: Icons.group,
      ),
      _Tip(
        title: 'View learners by status',
        description: 'Switch to Learners to quickly see who is due for assessments.',
        icon: Icons.people_outline,
      ),
      _Tip(
        title: 'Open related guides',
        description: 'From Guides, review key content before or during an assessment.',
        icon: Icons.menu_book,
      ),
    ];

    return Column(
      children: tips
          .map((tip) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: AppTheme.cardDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryGradientStart,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(tip.icon, color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(tip.title, style: AppTheme.heading3),
                          const SizedBox(height: 6),
                          Text(tip.description, style: AppTheme.caption),
                        ],
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget _buildReportForm() {
    return Column(
      children: [
        TextField(
          controller: _nameController,
          decoration: AppTheme.inputDecoration.copyWith(hintText: 'Your name (optional)'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: AppTheme.inputDecoration.copyWith(hintText: 'Your email (optional)'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _subjectController,
          decoration: AppTheme.inputDecoration.copyWith(hintText: 'Subject'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _descriptionController,
          minLines: 4,
          maxLines: 8,
          decoration: AppTheme.inputDecoration.copyWith(hintText: 'Describe the issue or question...'),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: AppTheme.primaryButtonStyle,
            onPressed: _submitReport,
            child: const Text('Submit'),
          ),
        ),
      ],
    );
  }

  Widget _buildAlternateContact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Prefer email?', style: AppTheme.heading3),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.email, color: AppTheme.primaryGradientStart, size: 18),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: _openSupportEmail,
              child: Text(
                'support@logitlms.com',
                style: AppTheme.bodyText.copyWith(
                  color: AppTheme.primaryGradientStart,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _submitReport() async {
    final String subject = _subjectController.text.trim().isEmpty
        ? 'Assessor support request'
        : _subjectController.text.trim();
    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String description = _descriptionController.text.trim();

    if (description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please describe the issue.')),
      );
      return;
    }

    final String body = Uri.encodeComponent([
      if (name.isNotEmpty) 'Name: $name',
      if (email.isNotEmpty) 'Email: $email',
      'Description:',
      description,
    ].join('\n'));

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@logitlms.com',
      query: 'subject=${Uri.encodeComponent(subject)}&body=$body',
    );

    await _tryLaunch(emailUri);
  }

  Future<void> _openSupportEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@logitlms.com',
      query: 'subject=${Uri.encodeComponent('Logit LMS assessor support')}',
    );
    await _tryLaunch(emailUri);
  }

  Future<void> _tryLaunch(Uri uri) async {
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch');
      }
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open email app. Please email support@logitlms.com'),
        ),
      );
    }
  }
}

class _Tip {
  final String title;
  final String description;
  final IconData icon;
  const _Tip({required this.title, required this.description, required this.icon});
}

class _AssessorBottomBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const _AssessorBottomBar({required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.edit, 'Assess'),
            _buildNavItem(1, Icons.menu_book, 'Guides'),
            _buildNavItem(2, Icons.help, 'Help'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppTheme.highlightColor : Colors.white,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppTheme.highlightColor : Colors.white70,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


