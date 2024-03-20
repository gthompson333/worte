part of 'hint_bloc.dart';

abstract class HintEvent {
  const HintEvent();
}

class GetHintEvent extends HintEvent {
  const GetHintEvent({required this.word});
  final Word word;
}
