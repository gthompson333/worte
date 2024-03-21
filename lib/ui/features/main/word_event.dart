part of 'word_bloc.dart';

abstract class WordEvent {
  const WordEvent();
}

class StartWordEvent extends WordEvent {
  const StartWordEvent();
}

class EndWordEvent extends WordEvent {
  const EndWordEvent();
}

class GetWordEvent extends WordEvent {
  const GetWordEvent();
}

