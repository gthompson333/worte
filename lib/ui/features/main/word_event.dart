part of 'word_bloc.dart';

abstract class WordEvent {
  const WordEvent();
}

class StartWordSession extends WordEvent {
  const StartWordSession();
}

class EndWordSession extends WordEvent {
  const EndWordSession();
}

class GetWordEvent extends WordEvent {
  const GetWordEvent();
}

