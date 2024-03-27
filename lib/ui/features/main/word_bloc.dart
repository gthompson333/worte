import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/openai/models.dart';
import '../../../data/openai/services.dart';

part 'word_event.dart';

part 'word_state.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  WordBloc()
      : super(WordLoaded(word: Word(word: "", translations: {"": false}))) {
    on<EndWordEvent>(_onEndWord);
    on<GetWordEvent>(_onGetWord);
  }

  Future<void> _onEndWord(EndWordEvent _, Emitter<WordState> emit) async {
    emit(WordEnded());
  }

  Future<void> _onGetWord(
    GetWordEvent _,
    Emitter<WordState> emit,
  ) async {
    emit(WordLoading());
    await Data.instance
        .generateWord()
        .then(
          (word) => {emit(WordLoaded(word: word))},
        )
        .onError((error, stackTrace) => {emit(WordError())});
  }
}
