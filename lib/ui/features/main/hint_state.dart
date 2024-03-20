part of 'hint_bloc.dart';

abstract class HintState extends Equatable {
  const HintState();

  @override
  List<Object> get props => [];
}

final class HintInitial extends HintState {}
final class HintLoading extends HintState {}

final class HintLoaded extends HintState {
  const HintLoaded({required this.hint});
  final Hint hint;

  @override
  List<Object> get props => [hint];
}

final class HintError extends HintState {}