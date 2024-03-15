part of 'translate_bloc.dart';

abstract class TranslateState extends Equatable {
  const TranslateState();
}

final class TranslateWordLoading extends TranslateState {
  @override
  List<Object> get props => [];
}

final class TranslateWordLoaded extends TranslateState {
  const TranslateWordLoaded({required this.word});
  final Word word;

  @override
  List<Object> get props => [word];
}

final class TranslateWordError extends TranslateState {
  @override
  List<Object> get props => [];
}

final class TranslateHintLoading extends TranslateState {
  @override
  List<Object> get props => [];
}

final class TranslateHintLoaded extends TranslateState {
  const TranslateHintLoaded({required this.hint});
  final Hint hint;

  @override
  List<Object> get props => [hint];
}

final class TranslateHintError extends TranslateState {
  @override
  List<Object> get props => [];
}