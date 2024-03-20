part of 'word_bloc.dart';

abstract class WordState extends Equatable {
  const WordState();

  @override
  List<Object> get props => [];
}

final class WordSessionStarted extends WordState {}

final class WordSessionEnded extends WordState {}

final class WordLoading extends WordState {}

final class WordLoaded extends WordState {
  const WordLoaded({required this.word});
  final Word word;

  @override
  List<Object> get props => [word];
}

final class WordError extends WordState {}
