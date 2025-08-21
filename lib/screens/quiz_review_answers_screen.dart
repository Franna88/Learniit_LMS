import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'competency_quiz_screen.dart';

class QuizReviewAnswersScreen extends StatelessWidget {
  final String competencyTitle;
  final List<QuizQuestion> questions;
  final List<int?> userAnswers;

  const QuizReviewAnswersScreen({
    super.key,
    required this.competencyTitle,
    required this.questions,
    required this.userAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final q = questions[index];
                  final selected = userAnswers[index];
                  final isCorrect = selected == q.correctIndex;
                  return _ReviewCard(
                    index: index,
                    question: q,
                    selectedIndex: selected,
                    isCorrect: isCorrect,
                  );
                },
              ),
            ),
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
                  'Review answers',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppTheme.highlightColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Icon(Icons.person, color: Colors.white),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              competencyTitle,
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
}

class _ReviewCard extends StatelessWidget {
  final int index;
  final QuizQuestion question;
  final int? selectedIndex;
  final bool isCorrect;

  const _ReviewCard({
    required this.index,
    required this.question,
    required this.selectedIndex,
    required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: AppTheme.cardDecoration,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Question ${index + 1}: ${question.title}',
                    style: AppTheme.heading3.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isCorrect ? Colors.green[100] : Colors.red[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(isCorrect ? Icons.check : Icons.close, size: 14, color: isCorrect ? Colors.green[800] : Colors.red[800]),
                      const SizedBox(width: 6),
                      Text(isCorrect ? 'Correct' : 'Incorrect', style: TextStyle(color: isCorrect ? Colors.green[800] : Colors.red[800], fontSize: 12)),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(question.prompt, style: AppTheme.caption),
            const SizedBox(height: 12),
            ...List.generate(question.options.length, (i) {
              final isUserChoice = selectedIndex == i;
              final isRight = question.correctIndex == i;
              final Color border = isUserChoice
                  ? (isRight ? Colors.green : Colors.red)
                  : (isRight ? Colors.green : Colors.grey[300]!);
              final Color? bg = isUserChoice
                  ? (isRight ? Colors.green[50] : Colors.red[50])
                  : (isRight ? Colors.green[50] : null);
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: border),
                ),
                child: Row(
                  children: [
                    Icon(
                      isRight
                          ? Icons.check_circle
                          : (isUserChoice ? Icons.cancel : Icons.radio_button_unchecked),
                      size: 18,
                      color: isRight
                          ? Colors.green
                          : (isUserChoice ? Colors.red : Colors.grey[500]),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(question.options[i], style: AppTheme.caption)),
                  ],
                ),
              );
            }),
            const SizedBox(height: 8),
            Text('Why:', style: AppTheme.heading3.copyWith(fontSize: 14)),
            const SizedBox(height: 4),
            Text(
              question.correctFeedback,
              style: AppTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}


