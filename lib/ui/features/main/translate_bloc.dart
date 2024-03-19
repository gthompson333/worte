import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/openai/models.dart';
import '../../../data/openai/services.dart';

part 'translate_event.dart';
part 'translate_state.dart';

class TranslateWordBloc extends Bloc<TranslateEvent, TranslateState> {
  TranslateWordBloc() : super(TranslateSessionStarted()) {
    on<StartTranslateSession>(_onStartTranslateSession);
    on<EndTranslateSession>(_onEndTranslateSession);
    on<GetWordEvent>(_onGetWord);
    on<GetHintEvent>(_onGetHint);
  }

  Future<void> _onStartTranslateSession(
      StartTranslateSession _, Emitter<TranslateState> emit) async {
    emit(TranslateSessionStarted());
  }

  Future<void> _onEndTranslateSession(
      EndTranslateSession _, Emitter<TranslateState> emit) async {
    emit(TranslateSessionEnded());
  }

  Future<void> _onGetWord(
    GetWordEvent _,
    Emitter<TranslateState> emit,
  ) async {
    emit(TranslateWordLoading());
    await Data.instance
        .generateWord()
        .then(
          (word) => {emit(TranslateWordLoaded(word: word))},
        )
        .onError((error, stackTrace) => {emit(TranslateWordError())});
  }

  Future<void> _onGetHint(
    GetHintEvent event,
    Emitter<TranslateState> emit,
  ) async {
    emit(TranslateHintLoading());
    await Data.instance
        .requestHint(event.word)
        .then(
          (hint) => {emit(TranslateHintLoaded(hint: hint))},
        )
        .onError((error, stackTrace) => {emit(TranslateHintError())});
  }
}
