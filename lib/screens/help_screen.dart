import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import 'glossary_screen.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildHelpOptions(),
                    const Spacer(),
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
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF0D2A4C),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Top row with profile icon
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Color(0xFF0D2A4C),
                    size: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Question mark icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFDFAE26),
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Icon(
                Icons.help,
                color: Colors.white,
                size: 48,
              ),
            ),
            const SizedBox(height: 16),
            // Help text
            const Text(
              'Help',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpOptions() {
    return Column(
      children: [
        _buildHelpOption(
          icon: Icons.phone_android,
          title: 'How to use',
          subtitle: 'Logit LMS',
          subtitleColor: const Color(0xFFDFAE26),
          onTap: () => _showHowToUse(),
        ),
        const SizedBox(height: 16),
        _buildHelpOption(
          icon: Icons.description,
          title: 'Glossary',
          subtitle: '',
          subtitleColor: Colors.white,
          onTap: () => _showGlossary(),
        ),
        const SizedBox(height: 16),
        _buildHelpOption(
          icon: Icons.bug_report,
          title: 'Report a problem',
          subtitle: '',
          subtitleColor: Colors.white,
          onTap: () => _showReportProblem(),
        ),
      ],
    );
  }

  Widget _buildHelpOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color subtitleColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF0D2A4C),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon with yellow overlay
            Stack(
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 32,
                ),
                if (icon == Icons.phone_android)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDFAE26),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.info,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                if (icon == Icons.description)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDFAE26),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                if (icon == Icons.bug_report)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDFAE26),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.error,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: subtitleColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ),
            // Arrow icon
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _showHowToUse() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildHowToUseModal(),
    );
  }

  void _showGlossary() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const GlossaryScreen(),
      ),
    );
  }

  void _showReportProblem() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildReportProblemModal(),
    );
  }

  Widget _buildHowToUseModal() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'How to use Logit LMS',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D2A4C),
                  ),
                ),
                const SizedBox(height: 20),
                _buildInstructionItem(
                  '1. Navigate using the bottom bar',
                  'Use the icons at the bottom to switch between different sections of the app.',
                  Icons.space_bar,
                ),
                _buildInstructionItem(
                  '2. Start learning',
                  'Go to Competencies to begin your learning journey.',
                  Icons.school,
                ),
                _buildInstructionItem(
                  '3. Review guides',
                  'Access helpful guides in the Guides section.',
                  Icons.menu_book,
                ),
                _buildInstructionItem(
                  '4. Track progress',
                  'Check your results and progress in the Results tab.',
                  Icons.assessment,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildReportProblemModal() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Report a Problem',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D2A4C),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'If you\'re experiencing issues with the app, please contact our support team:',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                _buildContactOption(
                  Icons.email,
                  'Email Support',
                  'support@logitlms.com',
                  () => _openSupportEmail(),
                ),
                const SizedBox(height: 16),
                _buildContactOption(
                  Icons.phone,
                  'Phone Support',
                  '+1 (555) 123-4567',
                  () => _openPhoneSupport(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionItem(String title, String description, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF0D2A4C),
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF0D2A4C),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildContactOption(IconData icon, String title, String contact, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFF0D2A4C),
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xFF0D2A4C),
                    ),
                  ),
                  Text(
                    contact,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF0D2A4C),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openSupportEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@logitlms.com',
      query: 'subject=${Uri.encodeComponent('Logit LMS Support Request')}',
    );
    await _tryLaunch(emailUri);
  }

  Future<void> _openPhoneSupport() async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: '+15551234567',
    );
    await _tryLaunch(phoneUri);
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
            'Could not open external app. Please contact support manually.',
          ),
        ),
      );
    }
  }
}


