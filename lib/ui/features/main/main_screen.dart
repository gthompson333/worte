import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'word_bloc.dart';
import 'hint_bloc.dart';
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

  // The current word that is being translated.
  Word? currentWord;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Remove the hint link until the word has arrived.
      context.read<HintBloc>().add(const ShowHintLinkEvent(showHintLink: false));

      // Fetch the first word for translation.
      context.read<WordBloc>().add(const GetWordEvent());
    });
    super.initState();
  }

  void getHint() {
    if (hintsRemaining == 0) return;
    context.read<HintBloc>().add(GetHintEvent(word: currentWord!));
  }

  void restartTranslateSession() {
    points = 0;
    hintsRemaining = 3;
    context.read<WordBloc>().add(const GetWordEvent());
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              wordWidget(),
              hintWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget wordWidget() {
    return BlocBuilder<WordBloc, WordState>(builder: (context, state) {
      switch (state) {
        case WordEnded():
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
        case WordLoading():
          return const Center(
            child: LoadingView(),
          );
        case WordLoaded():
          context.read<HintBloc>().add(const ShowHintLinkEvent(showHintLink: true));
          currentWord = state.word;

          return Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: HUD(
                  playerName: widget.player,
                  score: points,
                  availableHints: hintsRemaining,
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              WordDetail(
                word: currentWord!,
                onWordSelected: (question, answerKey) {
                  context.read<HintBloc>().add(const ShowHintLinkEvent(showHintLink: false));
                  if (question.translations[answerKey] ?? false) {
                    ++points;
                    context.read<WordBloc>().add(const GetWordEvent());
                  } else {
                    context.read<WordBloc>().add(const EndWordEvent());
                  }
                },
              ),
            ],
          );
        case WordError():
          return Center(
            child: ErrorView(
              onRetryPressed: () =>
                  context.read<WordBloc>().add(const GetWordEvent()),
            ),
          );
      }
      return const SizedBox();
    });
  }

  Widget hintWidget() {
    return BlocBuilder<HintBloc, HintState>(builder: (context, state) {
      if (hintsRemaining == 0) return const SizedBox();

      switch (state) {
        case HintShouldShow():
          if (!state.shouldShowHint) {
            return const SizedBox();
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 24),
              TextButton(
                onPressed: hintsRemaining > 0 ? getHint : null,
                child: const Text(
                  'Hinweis',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          );
        case HintLoading():
          return const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 24),
              CircularProgressIndicator(),
            ],
          );
        case HintLoaded():
          hintsRemaining -= 1;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 24),
              Text(
                state.hint.hint,
                textAlign: TextAlign.center,
              ),
            ],
          );
        case HintError():
          return const SizedBox();
      }
      return const SizedBox();
    });
  }
}
