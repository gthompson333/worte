import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/openai/models.dart';
import '../../../data/openai/services.dart';

part 'word_event.dart';
part 'word_state.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  WordBloc() : super(WordSessionStarted()) {
    on<StartWordSession>(_onStartWordSession);
    on<EndWordSession>(_onEndWordSession);
    on<GetWordEvent>(_onGetWord);
  }

  Future<void> _onStartWordSession(StartWordSession _,
      Emitter<WordState> emit) async {
    emit(WordSessionStarted());
  }

  Future<void> _onEndWordSession(EndWordSession _,
      Emitter<WordState> emit) async {
    emit(WordSessionEnded());
  }

  Future<void> _onGetWord(GetWordEvent _,
      Emitter<WordState> emit,) async {
    emit(WordLoading());
    await Data.instance
        .generateWord()
        .then(
          (word) => {emit(WordLoaded(word: word))},
    )
        .onError((error, stackTrace) => {emit(WordError())});
  }
}