import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'translate_bloc.dart';
import '../../../data/openai/models.dart';
import '../../widgets/error_view.dart';
import '../../widgets/game_over.dart';
import '../../widgets/hud.dart';
import '../../widgets/loading_view.dart';
import '../../widgets/word_detail.dart';

class MainScreen extends StatefulWidget {
  final String player;

  const MainScreen({
    super.key,
    required this.player,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();

  // Route creation helper
  static Route route(String player) {
    return MaterialPageRoute<void>(
      builder: (_) => MainScreen(
        player: player,
      ),
    );
  }
}

class _MainScreenState extends State<MainScreen> {
  // One point for each correctly translated word.
  int points = 0;

  // Only 3 hints allowed.
  int hintsRemaining = 3;

  Word? currentWord;
  Hint? currentHint;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getWord();
    });
    super.initState();
  }

  void getWord() {
    currentWord = null;
    context.read<TranslateWordBloc>().add(const GetWordEvent());
  }

  void getHint() {
    if (hintsRemaining == 0) return;

    currentHint = null;
    context.read<TranslateWordBloc>().add(GetHintEvent(word: currentWord!));
  }

  void restartTranslateSession() {
    context.read<TranslateWordBloc>().add(const StartTranslateSession());

    setState(() {
      points = 0;
      hintsRemaining = 3;
      currentWord = null;
      currentHint = null;
    });
    getWord();
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
          child: buildWordWidget(),
        ),
      ),
    );
  }

  Widget buildWordWidget() {
    return BlocBuilder<TranslateWordBloc, TranslateState>(
        builder: (context, state) {
      if (state is TranslateSessionEnded) {
        return GameOver(
          score: points,
          correctAnswer: currentWord!.correctWord.key,
          onTryAgainPressed: () {
            restartTranslateSession();
          },
          onGoBackPressed: () {
            Navigator.pop(context);
          },
        );
      }

      if (state is TranslateWordLoading) {
        return const Center(
          child: LoadingView(),
        );
      }

      if (state is TranslateWordError) {
        return Center(
          child: ErrorView(
            onRetryPressed: () => getWord(),
          ),
        );
      }

      if (state is TranslateWordLoaded) {
        currentWord = state.word;

        return Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: HUD(
                playerName: widget.player,
                score: points,
                availableHints: hintsRemaining,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WordDetail(
                  word: currentWord!,
                  onWordSelected: (question, answerKey) {
                    if (question.translations[answerKey] ?? false) {
                      setState(() {
                        ++points;
                      });
                      getWord();
                    } else {
                      context
                          .read<TranslateWordBloc>()
                          .add(const EndTranslateSession());
                    }
                  },
                ),
                buildHintWidget(state),
              ],
            ),
          ],
        );
      }
      return const SizedBox();
    });
  }

  Widget buildHintWidget(TranslateState state) {
    if (hintsRemaining == 0) return const SizedBox();

    print("Translate State: ${state.runtimeType}");

    if (state is TranslateHintLoading) {
      return const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 24),
          CircularProgressIndicator(),
        ],
      );
    }

    if (state is TranslateHintLoaded) {
      currentHint = state.hint;
      hintsRemaining -= 1;

      print("Translate Hint Loaded");
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 24),
          Text(
            currentHint!.hint,
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 24),
        TextButton(
          onPressed: hintsRemaining > 0 ? getHint : null,
          child: const Text(
            'Kann ich einen Hinweis haben, bitte?',
            style: TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }
}
