import 'package:flutter/material.dart';
import '../../../data/openai/models.dart';

typedef WordSelectedCallback = void Function(
  Word word,
  String answerKey,
);

class WordDetail extends StatelessWidget {
  const WordDetail({
    super.key,
    required this.word,
    required this.onWordSelected,
  });

  final Word word;
  final WordSelectedCallback onWordSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "[No topic provided.]",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        const SizedBox(height: 4),
        Text(
          word.word,
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
          children: word.translations.entries
              .map(
                (entry) => OutlinedButton(
                  onPressed: () => onWordSelected.call(word, entry.key),
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
