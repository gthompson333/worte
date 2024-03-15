import 'dart:convert';
import 'package:dart_openai/dart_openai.dart';

enum OperationStatus {
  idle,
  loading,
  success,
  failed,
}

extension ConvenienceGetters on OperationStatus {
  bool get isIdle => this == OperationStatus.idle;
  bool get isLoading => this == OperationStatus.loading;
  bool get isSuccess => this == OperationStatus.success;
  bool get isFailed => this == OperationStatus.failed;
}

class Word {
  String word;
  Map<String, bool> translations;

  Word({
    required this.word,
    required this.translations,
  });

  MapEntry<String, bool> get correctWord =>
      translations.entries.firstWhere((entry) => entry.value);

  factory Word.fromOpenAIMessage(
      OpenAIChatCompletionChoiceMessageModel message) {
    final response = jsonDecode(message.content?.first.text ?? '') as Map;

    return Word(
      word: response['word'] as String,
      translations: (response['translations'] as Map).cast<String, bool>(),
    );
  }
}

class Hint {
  String hint;

  Hint({
    required this.hint,
  });

  factory Hint.fromOpenAIMessage(
      OpenAIChatCompletionChoiceMessageModel message) {
    final response = jsonDecode(message.content?.first.text ?? '') as Map;

    return Hint(
      hint: response['hint'] as String,
    );
  }
}
