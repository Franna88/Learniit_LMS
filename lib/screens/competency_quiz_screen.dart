import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'quiz_review_answers_screen.dart';
import 'profile_screen.dart';
import 'dart:math' as math;

class QuizQuestion {
  final String title;
  final String prompt;
  final List<String> options;
  final int correctIndex;
  final String correctFeedback;
  final String incorrectFeedback;

  QuizQuestion({
    required this.title,
    required this.prompt,
    required this.options,
    required this.correctIndex,
    required this.correctFeedback,
    required this.incorrectFeedback,
  });
}

class CompetencyQuizScreen extends StatefulWidget {
  final String competencyTitle;
  final List<QuizQuestion>? questions;
  const CompetencyQuizScreen({super.key, required this.competencyTitle, this.questions});

  @override
  State<CompetencyQuizScreen> createState() => _CompetencyQuizScreenState();
}

class _CompetencyQuizScreenState extends State<CompetencyQuizScreen> {
  late final List<QuizQuestion> _questions;
  int _currentIndex = 0;
  int? _selectedOptionIndex;
  bool _showingFeedback = false;
  bool _lastAnswerCorrect = false;
  int _correctCount = 0;
  final List<int?> _userSelections = [];

  @override
  void initState() {
    super.initState();
    _questions = widget.questions ?? _buildDummyQuestions();
    _userSelections.addAll(List<int?>.filled(_questions.length, null));
  }

  @override
  Widget build(BuildContext context) {
    final isSummary = _currentIndex >= _questions.length;
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final height = constraints.maxHeight;
                    if (isSummary) {
                      return _buildSummaryCard(height);
                    }
                    if (_showingFeedback) {
                      return _buildFeedbackCard(height);
                    }
                    return _buildQuestionCard(height);
                  },
                ),
              ),
            ),
            _buildBottomCounter(isSummary),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppTheme.mainGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                Text(
                  'Readiness check',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppTheme.highlightColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileScreen()),
                    );
                  },
                  icon: const Icon(Icons.person, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              widget.competencyTitle,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard(double height) {
    final question = _questions[_currentIndex];
    return Container(
      height: height,
      decoration: AppTheme.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Question ${_currentIndex + 1}: ${question.title}', style: AppTheme.heading3.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text(question.prompt, style: AppTheme.caption),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: question.options.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final option = question.options[index];
                final isSelected = _selectedOptionIndex == index;
                return InkWell(
                  onTap: () => setState(() => _selectedOptionIndex = index),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: isSelected ? AppTheme.primaryGradientStart : Colors.transparent, width: 1),
                    ),
                    child: Row(
                      children: [
                        Radio<int>(
                          value: index,
                          groupValue: _selectedOptionIndex,
                          activeColor: AppTheme.primaryGradientStart,
                          onChanged: (value) => setState(() => _selectedOptionIndex = value),
                        ),
                        const SizedBox(width: 8),
                        Expanded(child: Text(option, style: AppTheme.caption)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGradientStart,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                child: const Text('Submit'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubmit() {
    if (_selectedOptionIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select an answer')));
      return;
    }
    final question = _questions[_currentIndex];
    final isCorrect = _selectedOptionIndex == question.correctIndex;
    setState(() {
      _showingFeedback = true;
      _lastAnswerCorrect = isCorrect;
      _userSelections[_currentIndex] = _selectedOptionIndex;
      if (isCorrect) _correctCount += 1;
    });
  }

  Widget _buildFeedbackCard(double height) {
    final question = _questions[_currentIndex];
    final isCorrect = _lastAnswerCorrect;
    final Color cardColor = AppTheme.primaryGradientStart;
    final String message = isCorrect ? question.correctFeedback : question.incorrectFeedback;
    final IconData iconData = isCorrect ? Icons.check_circle : Icons.cancel;

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Builder(builder: (context) {
              final double iconSize = math.max(40, math.min(80, height * 0.12));
              final double titleSize = math.max(16, math.min(22, height * 0.035));
              final double bodySize = math.max(12, math.min(16, height * 0.028));
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(iconData, size: iconSize, color: AppTheme.highlightColor),
                  const SizedBox(height: 16),
                  Text('Feedback', style: GoogleFonts.poppins(fontSize: titleSize, fontWeight: FontWeight.w600, color: Colors.white)),
                  const SizedBox(height: 12),
                  Text(
                    message,
                    style: GoogleFonts.poppins(fontSize: bodySize, color: Colors.white, height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: 180,
                    child: ElevatedButton(
                      onPressed: _handleContinueFromFeedback,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppTheme.primaryGradientStart,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Continue'),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  void _handleContinueFromFeedback() {
    if (_currentIndex == _questions.length - 1) {
      setState(() {
        _currentIndex += 1; // move to summary mode
        _showingFeedback = false;
      });
    } else {
      setState(() {
        _currentIndex += 1;
        _selectedOptionIndex = null;
        _showingFeedback = false;
      });
    }
  }

  Widget _buildSummaryCard(double height) {
    final percent = ((_correctCount / _questions.length) * 100).round();
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppTheme.primaryGradientStart,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Builder(builder: (context) {
              final double iconSize = math.max(48, math.min(88, height * 0.14));
              final double percentSize = math.max(26, math.min(40, height * 0.09));
              final double titleSize = math.max(18, math.min(24, height * 0.04));
              final double bodySize = math.max(12, math.min(16, height * 0.028));
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('How did you do?', style: GoogleFonts.poppins(color: Colors.white, fontSize: titleSize, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 16),
                  Icon(Icons.emoji_events, size: iconSize, color: AppTheme.highlightColor),
                  const SizedBox(height: 8),
                  Text('$percent%', style: GoogleFonts.poppins(color: Colors.white, fontSize: percentSize, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 10),
                  Text(
                    "You're likely ready to demonstrate this in your workplace assessment.",
                    style: GoogleFonts.poppins(color: Colors.white, fontSize: bodySize),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizReviewAnswersScreen(
                            competencyTitle: widget.competencyTitle,
                            questions: _questions,
                            userAnswers: _userSelections,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppTheme.primaryGradientStart,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    ),
                    child: const Text('Review answers'),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: _resetQuiz,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retake test'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  void _resetQuiz() {
    setState(() {
      _currentIndex = 0;
      _selectedOptionIndex = null;
      _showingFeedback = false;
      _lastAnswerCorrect = false;
      _correctCount = 0;
      _userSelections.clear();
      _userSelections.addAll(List<int?>.filled(_questions.length, null));
    });
  }

  

  Widget _buildBottomCounter(bool isSummary) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppTheme.mainGradient,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Center(
        child: Text(
          isSummary
              ? 'Completed: ${_questions.length} questions'
              : 'Question ${_currentIndex + 1} of ${_questions.length}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  List<QuizQuestion> _buildDummyQuestions() {
    return [
      QuizQuestion(
        title: 'Safety First',
        prompt: 'Before handling the oxygen cylinder, what must you check?',
        options: const [
          'A. That the patient is in the clinic',
          'B. That your hands are clean and free of creams, oils or grease',
          'C. That your hands are clean and free of creams, oils or grease',
          'D. That the oxygen mask is attached to the patient',
        ],
        correctIndex: 1,
        correctFeedback: 'Correct. This ensures there is no fire or contamination risk when handling oxygen.',
        incorrectFeedback: 'Incorrect. First, you should check that your hands are clean and free of creams, oils, or grease, as these could pose a fire or contamination risk when handling oxygen.',
      ),
      QuizQuestion(
        title: 'Equipment Check',
        prompt: 'Which component must be checked for damage before use?',
        options: const [
          'A. Flow regulator and connections',
          'B. Patient wristwatch',
          'C. Clipboard',
          'D. None of the above',
        ],
        correctIndex: 0,
        correctFeedback: 'Correct. The flow regulator and connections must be intact and secure before use.',
        incorrectFeedback: 'Incorrect. Always check the flow regulator and connections for damage before use.',
      ),
      QuizQuestion(
        title: 'Delivery',
        prompt: 'What delivery method provides high-concentration oxygen for a conscious patient?',
        options: const [
          'A. Room air',
          'B. Non-rebreather mask',
          'C. Nasal cannula at 1 L/min',
          'D. Paper bag',
        ],
        correctIndex: 1,
        correctFeedback: 'Correct. A non-rebreather mask provides a higher concentration of oxygen for conscious patients.',
        incorrectFeedback: 'Incorrect. A non-rebreather mask is used to deliver high-concentration oxygen for conscious patients.',
      ),
    ];
  }
}


