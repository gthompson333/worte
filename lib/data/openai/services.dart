import 'package:dart_openai/dart_openai.dart';
import 'models.dart';
import 'prompts.dart';

class Data {
  Data._privateConstructor();

  static final Data _instance = Data._privateConstructor();

  static Data get instance => _instance;

  static final List<OpenAIChatCompletionChoiceMessageModel> _initialMessages = [
    OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
            initialInstructionsPrompt)
      ],
      role: OpenAIChatMessageRole.system,
    ),
  ];

  List<OpenAIChatCompletionChoiceMessageModel> _messages = [];

  Future<OpenAIChatCompletionModel> _generateChatCompletion() =>
      OpenAI.instance.chat.create(
        model: 'gpt-3.5-turbo',
        messages: _messages,
        temperature: 0.8,
      );

  Future<Question> generateTriviaQuestion() async {
    _messages = <OpenAIChatCompletionChoiceMessageModel>[
      ..._initialMessages,
      OpenAIChatCompletionChoiceMessageModel(
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(
              generateQuestionPrompt)
        ],
        role: OpenAIChatMessageRole.user,
      ),
    ];

    final response = await _generateChatCompletion();

    final rawQuestionMessage = response.choices.first.message;

    return Question.fromOpenAIMessage(rawQuestionMessage);
  }

  Future<Hint> requestHint(Question question) async {
    final prompt = requestHintPrompt(question.description);
    _messages.add(OpenAIChatCompletionChoiceMessageModel(
      content: [OpenAIChatCompletionChoiceMessageContentItemModel.text(prompt)],
      role: OpenAIChatMessageRole.user,
    ));

    final response = await _generateChatCompletion();

    final rawMessage = response.choices.first.message;

    _messages.add(rawMessage);

    return Hint.fromOpenAIMessage(rawMessage);
  }
}
