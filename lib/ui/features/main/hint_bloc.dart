import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/openai/models.dart';
import '../../../data/openai/services.dart';

part 'hint_event.dart';

part 'hint_state.dart';

class HintBloc extends Bloc<HintEvent, HintState> {
  HintBloc() : super(HintInitial()) {
    on<InitializeHintEvent>(_onInitializeHint);
    on<GetHintEvent>(_onGetHint);
  }

  Future<void> _onInitializeHint(
    InitializeHintEvent event,
    Emitter<HintState> emit,
  ) async {
    emit(HintInitial());
  }

  Future<void> _onGetHint(
    GetHintEvent event,
    Emitter<HintState> emit,
  ) async {
    emit(HintLoading());
    await Data.instance
        .requestHint(event.word)
        .then(
          (hint) => {emit(HintLoaded(hint: hint))},
        )
        .onError((error, stackTrace) => {emit(HintError())});
  }
}
