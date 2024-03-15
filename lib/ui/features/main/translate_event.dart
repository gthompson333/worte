part of 'translate_bloc.dart';

abstract class TranslateEvent {
  const TranslateEvent();
}

class GetWordEvent extends TranslateEvent {
  const GetWordEvent();
}

class GetHintEvent extends TranslateEvent {
  const GetHintEvent({required this.word});
  final Word word;
}
