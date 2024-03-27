part of 'hint_bloc.dart';

abstract class HintEvent {
  const HintEvent();
}

class ShowHintLinkEvent extends HintEvent {
  const ShowHintLinkEvent({required this.showHintLink});
  final bool showHintLink;
}

class GetHintEvent extends HintEvent {
  const GetHintEvent({required this.word});
  final Word word;
}
