part of 'translate_bloc.dart';

abstract class TranslateState extends Equatable {
  const TranslateState();

  @override
  List<Object> get props => [];
}

final class TranslateSessionStarted extends TranslateState {}

final class TranslateSessionEnded extends TranslateState {}

final class TranslateWordLoading extends TranslateState {}

final class TranslateWordLoaded extends TranslateState {
  const TranslateWordLoaded({required this.word});
  final Word word;

  @override
  List<Object> get props => [word];
}

final class TranslateWordError extends TranslateState {}

final class TranslateHintLoading extends TranslateState {}

final class TranslateHintLoaded extends TranslateState {
  const TranslateHintLoaded({required this.hint});
  final Hint hint;

  @override
  List<Object> get props => [hint];
}

final class TranslateHintError extends TranslateState {}