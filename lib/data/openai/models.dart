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

class Question {
  String description;
  Map<String, bool> answers;
  String topic;
  String funFact;

  Question({
    required this.description,
    required this.answers,
    required this.funFact,
    this.topic = 'Unknown',
  });

  MapEntry<String, bool> get correctAnswer =>
      answers.entries.firstWhere((entry) => entry.value);

  factory Question.fromOpenAIMessage(
      OpenAIChatCompletionChoiceMessageModel message) {
    final response = jsonDecode(message.content?.first.text ?? '') as Map;

    return Question(
      description: response['question'] as String,
      topic: response['topic'] as String,
      answers: (response['answers'] as Map).cast<String, bool>(),
      funFact: response['funFact'] as String,
    );
  }
}

class Hint {
  String content;

  Hint({
    required this.content,
  });

  factory Hint.fromOpenAIMessage(
      OpenAIChatCompletionChoiceMessageModel message) {
    final response = jsonDecode(message.content?.first.text ?? '') as Map;

    return Hint(
      content: response['hint'] as String,
    );
  }
}
