import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class QualificationsScreen extends StatefulWidget {
  const QualificationsScreen({super.key});

  @override
  State<QualificationsScreen> createState() => _QualificationsScreenState();
}

class _QualificationsScreenState extends State<QualificationsScreen> {
  final List<Qualification> _qualifications = [
    Qualification(
      name: 'Diving First Aid',
      level: 'Advanced',
      date: '2023-12-15',
      status: 'Active',
      expiryDate: '2025-12-15',
    ),
    Qualification(
      name: 'Emergency Medical Technician',
      level: 'Intermediate',
      date: '2023-08-20',
      status: 'Active',
      expiryDate: '2025-08-20',
    ),
    Qualification(
      name: 'Diving Safety Officer',
      level: 'Professional',
      date: '2022-06-10',
      status: 'Active',
      expiryDate: '2024-06-10',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
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
                    // Top Row with Back Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: AppTheme.primaryGradientStart,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                        Text(
                          'My Qualifications',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 32), // Spacer for centering
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Summary Stats
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem('${_qualifications.length}', 'Total\nQualifications'),
                        _buildStatItem('${_qualifications.where((q) => q.status == 'Active').length}', 'Active\nQualifications'),
                        _buildStatItem('2', 'Expiring\nSoon'),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            
            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Title
                    Text(
                      'Current Qualifications',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryGradientStart,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'View and manage your professional qualifications',
                      style: AppTheme.caption,
                    ),
                    const SizedBox(height: 20),
                    
                    // Qualifications List
                    ..._qualifications.map((qualification) => 
                      _buildQualificationCard(qualification)
                    ).toList(),
                    
                    const SizedBox(height: 20),
                    
                    // Add New Qualification Button
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryGradientStart,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Add New Qualification',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.white70,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildQualificationCard(Qualification qualification) {
    final bool isExpiringSoon = _isExpiringSoon(qualification.expiryDate);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      qualification.name,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryGradientStart,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Level: ${qualification.level}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: qualification.status == 'Active' 
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  qualification.status,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: qualification.status == 'Active' 
                      ? Colors.green
                      : Colors.red,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Details Row
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  'Date Obtained',
                  qualification.date,
                  Icons.calendar_today,
                ),
              ),
              Expanded(
                child: _buildDetailItem(
                  'Expiry Date',
                  qualification.expiryDate,
                  Icons.event_busy,
                  isExpiringSoon: isExpiringSoon,
                ),
              ),
            ],
          ),
          
          if (isExpiringSoon) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.orange.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: Colors.orange,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'This qualification expires soon. Please renew to maintain your status.',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.orange[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          
          const SizedBox(height: 16),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: View certificate
                  },
                  icon: Icon(
                    Icons.visibility,
                    size: 16,
                    color: AppTheme.primaryGradientStart,
                  ),
                  label: Text(
                    'View Certificate',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.primaryGradientStart,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppTheme.primaryGradientStart),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Download certificate
                  },
                  icon: Icon(
                    Icons.download,
                    size: 16,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Download',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGradientStart,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon, {bool isExpiringSoon = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 14,
              color: isExpiringSoon ? Colors.orange : Colors.grey[600],
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isExpiringSoon ? Colors.orange : AppTheme.primaryGradientStart,
          ),
        ),
      ],
    );
  }

  bool _isExpiringSoon(String expiryDate) {
    final expiry = DateTime.parse(expiryDate);
    final now = DateTime.now();
    final difference = expiry.difference(now).inDays;
    return difference <= 90 && difference > 0; // Expiring within 90 days
  }
}

class Qualification {
  final String name;
  final String level;
  final String date;
  final String status;
  final String expiryDate;

  Qualification({
    required this.name,
    required this.level,
    required this.date,
    required this.status,
    required this.expiryDate,
  });
}
