import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../assessment_detail_screen.dart';

class AssessorAssessmentScreen extends StatefulWidget {
  final String category;
  final String title;
  final String learnerName;
  final String assessorName;
  final String? backgroundImageAssetPath;

  const AssessorAssessmentScreen({
    super.key,
    required this.category,
    required this.title,
    required this.learnerName,
    required this.assessorName,
    this.backgroundImageAssetPath,
  });

  @override
  State<AssessorAssessmentScreen> createState() => _AssessorAssessmentScreenState();
}

class _AssessorAssessmentScreenState extends State<AssessorAssessmentScreen> {
  final Map<String, String> _marks = {}; // pointId -> status

  final List<_AssessmentPoint> _points = const [
    _AssessmentPoint(id: 'p1', index: 1, title: 'Safety first', description: 'Ensure area is safe and PPE applied.'),
    _AssessmentPoint(id: 'p2', index: 2, title: 'Check the cylinder', description: 'Confirm oxygen cylinder upright or lying down securely.'),
    _AssessmentPoint(id: 'p3', index: 3, title: 'Assemble equipment', description: 'Assemble regulator and mask as per protocol.'),
    _AssessmentPoint(id: 'p4', index: 4, title: 'Deliver oxygen', description: 'Deliver oxygen and monitor the learner according to protocol.'),
  ];

  @override
  Widget build(BuildContext context) {
    final double progress = _marks.length / _points.length;
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(progress),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Assessor: ${widget.assessorName}', style: AppTheme.caption.copyWith(color: AppTheme.primaryGradientStart)),
                    Text('Learner: ${widget.learnerName}', style: AppTheme.caption.copyWith(color: AppTheme.primaryGradientStart)),
                    const SizedBox(height: 16),
                    Text('Scenario:', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, color: AppTheme.primaryGradientStart)),
                    const SizedBox(height: 6),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                      style: AppTheme.caption,
                    ),
                    const SizedBox(height: 16),
                    Divider(color: Colors.grey[300]),
                    const SizedBox(height: 10),
                    Text('Click each heading to assess the skill while the learner demonstrates.', style: AppTheme.caption),
                    const SizedBox(height: 12),
                    ..._points.map(_buildPointTile).toList(),
                    const SizedBox(height: 20),
                    _buildActions(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(double progress) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: widget.backgroundImageAssetPath != null
                ? Image.asset(widget.backgroundImageAssetPath!, fit: BoxFit.cover)
                : Container(color: AppTheme.primaryGradientStart),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.primaryGradientStart.withOpacity(0.88),
                    AppTheme.primaryGradientEnd.withOpacity(0.88),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.keyboard_backspace, color: Colors.white, size: 22),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Icon(Icons.more_horiz, color: Colors.white, size: 22),
                  ],
                ),
                const SizedBox(height: 10),
                Text('Workplace assessment', style: GoogleFonts.poppins(fontSize: 14, color: Colors.amber[200], fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Text(widget.title, style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white)),
                const SizedBox(height: 10),
                // Progress bar
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: FractionallySizedBox(
                              widthFactor: progress.clamp(0.0, 1.0),
                              child: Container(
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text('${(progress * 100).round()}%', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPointTile(_AssessmentPoint p) {
    final String? current = _marks[p.id];
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: AppTheme.cardDecoration,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        leading: Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: AppTheme.primaryGradientStart,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text('${p.index}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
        title: Text('${p.index}. ${p.title}', style: AppTheme.bodyText.copyWith(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.keyboard_arrow_down),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text('Safety - ${p.description}', style: AppTheme.caption),
            ),
          ),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1.5, // Make buttons square
            children: [
              _markButton(p.id, 'competent', 'Competent', Colors.green, current == 'competent'),
              _markButton(p.id, 'skills_gap', 'Skills gap', Colors.yellow[700]!, current == 'skills_gap'),
              _markButton(p.id, 'not_yet_competent', 'Not yet\ncompetent', Colors.red, current == 'not_yet_competent'),
              _markButton(p.id, 'knowledge_gap', 'Knowledge\ngap', Colors.orange, current == 'knowledge_gap'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _markButton(String pointId, String value, String label, Color baseColor, bool selected) {
    final Color backgroundColor = selected ? baseColor : baseColor.withOpacity(0.08);
    final Color borderColor = baseColor.withOpacity(selected ? 0.0 : 0.6);
    final Color textColor = selected ? Colors.white : baseColor;

    return GestureDetector(
      onTap: () => setState(() => _marks[pointId] = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(color: textColor, fontWeight: FontWeight.w600, fontSize: 11),
          ),
        ),
      ),
    );
  }

  Widget _buildActions() {
    final bool allMarked = _marks.length == _points.length;
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _marks.isEmpty ? null : () => setState(() => _marks.clear()),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: BorderSide(color: Colors.grey[400]!),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('Reset', style: AppTheme.bodyText.copyWith(color: AppTheme.primaryGradientStart, fontWeight: FontWeight.w600)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: allMarked ? _handleSubmit : null,
            style: AppTheme.primaryButtonStyle,
            child: Text('Submit', style: AppTheme.buttonText),
          ),
        ),
      ],
    );
  }

  void _handleSubmit() {
    // Map marks to per-point scores and grades
    int toScore(String v) {
      switch (v) {
        case 'competent':
          return 100;
        case 'skills_gap':
          return 60;
        case 'knowledge_gap':
          return 40;
        case 'not_yet_competent':
        default:
          return 0;
      }
    }

    String toGrade(String v) {
      switch (v) {
        case 'competent':
          return 'Competent';
        case 'skills_gap':
          return 'Skills gap';
        case 'knowledge_gap':
          return 'Knowledge gap';
        default:
          return 'Not yet competent';
      }
    }

    final List<AssessmentItem> items = _points.map((p) {
      final sel = _marks[p.id] ?? 'not_yet_competent';
      return AssessmentItem(
        name: p.title,
        score: toScore(sel),
        grade: toGrade(sel),
      );
    }).toList();

    final int overallScore =
        (items.map((e) => e.score).reduce((a, b) => a + b) / items.length).round();

    // Overall grade precedence
    String overallGrade;
    if (_marks.values.contains('not_yet_competent')) {
      overallGrade = 'Not yet competent';
    } else if (_marks.values.contains('skills_gap')) {
      overallGrade = 'Skills gap';
    } else if (_marks.values.contains('knowledge_gap')) {
      overallGrade = 'Knowledge gap';
    } else {
      overallGrade = 'Competent';
    }

    final DateTime now = DateTime.now();
    final String dateAssessed = '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
    final DateTime next = DateTime(now.year + 1, now.month, now.day);
    final String nextRefresherDue = '${next.day.toString().padLeft(2, '0')}/${next.month.toString().padLeft(2, '0')}/${next.year}';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AssessmentDetailScreen(
          assessmentTitle: widget.title,
          assessor: widget.assessorName,
          learner: widget.learnerName,
          dateAssessed: dateAssessed,
          nextRefresherDue: nextRefresherDue,
          grade: overallGrade,
          overallScore: overallScore,
          assessmentItems: items,
        ),
      ),
    );
  }
}

class _AssessmentPoint {
  final String id;
  final int index;
  final String title;
  final String description;
  const _AssessmentPoint({
    required this.id,
    required this.index,
    required this.title,
    required this.description,
  });
}


