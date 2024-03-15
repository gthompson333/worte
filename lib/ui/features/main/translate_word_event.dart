part of 'translate_word_bloc.dart';

abstract class TranslateWordEvent {
  const TranslateWordEvent();
}

class FetchWordEvent extends TranslateWordEvent {
  const FetchWordEvent();
}

class FetchHintEvent extends TranslateWordEvent {
  const FetchHintEvent({required this.word});
  final Word word;
}
