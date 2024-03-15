import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worter/data/openai/models.dart';
import 'package:worter/data/openai/services.dart';

part 'translate_word_event.dart';
part 'translate_word_state.dart';

class TranslateWordBloc extends Bloc<TranslateWordEvent, TranslateState> {
  TranslateWordBloc() : super(TranslateWordLoading()) {
    on<FetchWordEvent>(_onWordFetched);
    on<FetchHintEvent>(_onHintFetched);
  }

  Future<void> _onWordFetched(
    FetchWordEvent event,
    Emitter<TranslateState> emit,
  ) async {
    final state = this.state;

    if (state is TranslateWordLoaded) {
      Data.instance
          .generateWord()
          .then(
            (word) => {emit(TranslateWordLoaded(word: word))},
          )
          .onError((error, stackTrace) => {emit(TranslateWordError())});
    }
  }

  Future<void> _onHintFetched(
    FetchHintEvent event,
    Emitter<TranslateState> emit,
  ) async {
    final state = this.state;

    if (state is TranslateHintLoaded) {
      Data.instance
          .requestHint(event.word)
          .then(
            (hint) => {emit(TranslateHintLoaded(hint: hint))},
          )
          .onError((error, stackTrace) => {emit(TranslateHintError())});
    }
  }
}
