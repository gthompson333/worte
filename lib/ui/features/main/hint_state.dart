part of 'hint_bloc.dart';

abstract class HintState extends Equatable {
  const HintState();

  @override
  List<Object> get props => [];
}

final class HintShouldShow extends HintState {
  const HintShouldShow({required this.shouldShowHint});
  final bool shouldShowHint;

  @override
  List<Object> get props => [shouldShowHint];
}

final class HintLoading extends HintState {}

final class HintLoaded extends HintState {
  const HintLoaded({required this.hint});
  final Hint hint;

  @override
  List<Object> get props => [hint];
}

final class HintError extends HintState {}