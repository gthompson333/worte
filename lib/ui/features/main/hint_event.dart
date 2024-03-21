part of 'hint_bloc.dart';

abstract class HintEvent {
  const HintEvent();
}

class InitializeHintEvent extends HintEvent {
  const InitializeHintEvent();
}

class GetHintEvent extends HintEvent {
  const GetHintEvent({required this.word});
  final Word word;
}
