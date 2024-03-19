part of 'translate_bloc.dart';

abstract class TranslateEvent {
  const TranslateEvent();
}

class StartTranslateSession extends TranslateEvent {
  const StartTranslateSession();
}

class EndTranslateSession extends TranslateEvent {
  const EndTranslateSession();
}

class GetWordEvent extends TranslateEvent {
  const GetWordEvent();
}

class GetHintEvent extends TranslateEvent {
  const GetHintEvent({required this.word});
  final Word word;
}
