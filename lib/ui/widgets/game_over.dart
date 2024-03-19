import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  const GameOver({
    super.key,
    required this.score,
    required this.correctAnswer,
    this.onTryAgainPressed,
    this.onGoBackPressed,
  });

  final int score;
  final String correctAnswer;
  final VoidCallback? onTryAgainPressed;
  final VoidCallback? onGoBackPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Incorrect!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text(
            'Score: $score pts',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 16),
          Text(
            'Correct Word: '
            '$correctAnswer',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onTryAgainPressed,
            child: const Text('Try again!'),
          ),
          ElevatedButton(
            onPressed: onGoBackPressed,
            child: const Text('Go back!'),
          ),
        ],
      ),
    );
  }
}
