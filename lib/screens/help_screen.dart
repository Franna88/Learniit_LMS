import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
                    Text('How do I navigate?', style: AppTheme.heading2),
                    const SizedBox(height: 8),
                    _buildHowToList(),
                    const SizedBox(height: 24),
                    Text('Report a bug or request help', style: AppTheme.heading2),
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.help, color: AppTheme.highlightColor, size: 32),
                SizedBox(width: 12),
                Text(
                  'Help',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Find tips for using the app and contact us to report issues.',
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildHowToList() {
    final List<_HelpTip> tips = [
      const _HelpTip(
        title: 'Bottom navigation',
        description: 'Use the bar at the bottom to switch between Learning Zone, Competencies, Guides, Results, and Help.',
        icon: Icons.space_bar,
      ),
      const _HelpTip(
        title: 'Start a competency',
        description: 'Open Competencies, choose a topic, then work through the introduction, readiness, and quiz.',
        icon: Icons.my_location,
      ),
      const _HelpTip(
        title: 'Review guides',
        description: 'Guides provide quick reference content to help prepare for assessments.',
        icon: Icons.menu_book,
      ),
      const _HelpTip(
        title: 'See your results',
        description: 'Track your progress and view past quiz results in the Results tab.',
        icon: Icons.assignment,
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
        ? 'Logit LMS mobile app support'
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
      query: 'subject=${Uri.encodeComponent('Logit LMS support')}',
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
        SnackBar(
          content: Text(
            'Could not open email app. Please email support@logitlms.com',
          ),
        ),
      );
    }
  }
}

class _HelpTip {
  final String title;
  final String description;
  final IconData icon;
  const _HelpTip({required this.title, required this.description, required this.icon});
}


