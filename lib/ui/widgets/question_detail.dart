import 'package:flutter/material.dart';
import '../../../data/openai/models.dart';

typedef AnswerSelectedCallback = void Function(
  Question question,
  String answerKey,
);

class QuestionDetail extends StatelessWidget {
  const QuestionDetail({
    super.key,
    required this.question,
    required this.onAnswerSelected,
  });

  final Question question;
  final AnswerSelectedCallback onAnswerSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          question.topic.toUpperCase(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        const SizedBox(height: 4),
        Text(
          question.description,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 32),
        GridView.count(
          childAspectRatio: 3 / 1,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: question.answers.entries
              .map(
                (entry) => OutlinedButton(
                  onPressed: () => onAnswerSelected.call(question, entry.key),
                  child: Text(
                    entry.key,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
