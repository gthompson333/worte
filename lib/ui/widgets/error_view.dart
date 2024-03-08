import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    this.onRetryPressed,
  });

  final VoidCallback? onRetryPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Ehm! Sorry.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 16),
        const Text(
          'Magic 🪄✨ ran out and we couldn\'t pull a word '
          'out of the hat. Please try again later!',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: onRetryPressed,
          child: const Text('Retry'),
        ),
      ],
    );
  }
}
