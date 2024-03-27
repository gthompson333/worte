part of 'word_bloc.dart';

abstract class WordEvent {
  const WordEvent();
}

class EndWordEvent extends WordEvent {
  const EndWordEvent();
}

class GetWordEvent extends WordEvent {
  const GetWordEvent();
}

