import 'package:flutter/material.dart';

class HUD extends StatelessWidget {
  const HUD({
    super.key,
    required this.playerName,
    required this.score,
    required this.availableHints,
  });

  final String playerName;
  final int score;
  final int availableHints;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/logo.png',
          width: 100,
        ),
        const SizedBox(height: 8),
        Text('Player: $playerName'),
        Text('Score: $score pts'),
        Text('Hints: $availableHints'),
      ],
    );
  }
}
