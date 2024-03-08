import 'package:flutter/material.dart';
import '../../../data/openai/services.dart';
import '../../../data/openai/models.dart';
import '../../widgets/error_view.dart';
import '../../widgets/game_over.dart';
import '../../widgets/hud.dart';
import '../../widgets/loading_view.dart';
import '../../widgets/question_detail.dart';

class MainScreen extends StatefulWidget {
  final String player;

  const MainScreen({
    super.key,
    required this.player,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();

  /// Route creation helper
  static Route route(String player) {
    return MaterialPageRoute<void>(
      builder: (_) => MainScreen(
        player: player,
      ),
    );
  }
}

class _MainScreenState extends State<MainScreen> {
  int points = 0;
  int availableHints = 3;
  bool isGameOver = false;
  OperationStatus fetchQuestionStatus = OperationStatus.loading;
  OperationStatus fetchHintStatus = OperationStatus.idle;

  Question? currentQuestion;
  Hint? hint;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchQuestion();
    });
    super.initState();
  }

  void fetchQuestion() {
    setState(() {
      fetchQuestionStatus = OperationStatus.loading;
      hint = null;
      fetchHintStatus = OperationStatus.idle;
    });
    Data.instance
        .generateTriviaQuestion()
        .then(
          (question) => setState(() {
            currentQuestion = question;
            fetchQuestionStatus = OperationStatus.success;
          }),
        )
        .onError(
          (error, stackTrace) => setState(() {
            fetchQuestionStatus = OperationStatus.failed;
          }),
        );
  }

  void resetGame() {
    setState(() {
      points = 0;
      availableHints = 3;
      isGameOver = false;
      fetchQuestionStatus = OperationStatus.loading;
      currentQuestion = null;
      hint = null;
      fetchHintStatus = OperationStatus.idle;
    });
    fetchQuestion();
  }

  Widget buildGameView() {
    if (isGameOver) {
      return GameOver(
        score: points,
        correctAnswer: currentQuestion!.correctAnswer.key,
        funFact: currentQuestion!.funFact,
        onTryAgainPressed: () {
          resetGame();
        },
        onGoBackPressed: () {
          Navigator.pop(context);
        },
      );
    }

    if (fetchQuestionStatus.isLoading) {
      return const Center(
        child: LoadingView(),
      );
    }

    if (fetchQuestionStatus.isFailed) {
      return Center(
        child: ErrorView(
          onRetryPressed: () => fetchQuestion(),
        ),
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: HUD(
            playerName: widget.player,
            score: points,
            availableHints: availableHints,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QuestionDetail(
              question: currentQuestion!,
              onAnswerSelected: (question, answerKey) {
                if (question.answers[answerKey] ?? false) {
                  setState(() {
                    ++points;
                  });
                  fetchQuestion();
                } else {
                  setState(() {
                    isGameOver = true;
                  });
                }
              },
            ),
            buildHintView(),
          ],
        ),
      ],
    );
  }

  void fetchHint() {
    if (currentQuestion == null || availableHints == 0) return;

    setState(() {
      fetchHintStatus = OperationStatus.loading;
    });
    Data.instance
        .requestHint(currentQuestion!)
        .then(
          (newHint) => setState(() {
            hint = newHint;
            availableHints -= 1;
            fetchHintStatus = OperationStatus.success;
          }),
        )
        .onError(
          (error, stackTrace) => setState(() {
            fetchHintStatus = OperationStatus.failed;
          }),
        );
  }

  Widget buildHintView() {
    if (availableHints == 0 && hint == null) return const SizedBox();

    if (fetchHintStatus.isLoading) {
      return const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 24),
          CircularProgressIndicator(),
        ],
      );
    }

    if (hint == null || fetchHintStatus.isFailed) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 24),
          TextButton(
            onPressed: availableHints > 0 ? fetchHint : null,
            child: Text(
              'Not sure? Give me a hint! 🙏🏼',
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          )
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 24),
        Text(
          hint!.content,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 24,
          ),
          child: buildGameView(),
        ),
      ),
    );
  }
}
