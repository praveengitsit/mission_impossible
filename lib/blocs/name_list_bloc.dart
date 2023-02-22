import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../models/name_model.dart';
import '../repositories/name_repository.dart';

part 'name_list_event.dart';
part 'name_list_state.dart';

class NameListBloc extends Bloc<NameListEvent, NameListState> {
  final NameRepository nameRepository;
  NameListBloc(this.nameRepository) : super(NameListInitial()) {
    on<LoadNameListRandom>(_onLoadNameListRandom);
    on<LoadNameListStartingFrom>(_onLoadNameListStartingFrom);
  }

  FutureOr<void> _onLoadNameListRandom(
    LoadNameListRandom event,
    Emitter<NameListState> emit,
  ) async {
    try {
      final nameListResponse = await nameRepository.getRandomNames();

      emit(
        NameListLoaded(
          nameList: nameListResponse,
        ),
      );
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  FutureOr<void> _onLoadNameListStartingFrom(
    LoadNameListStartingFrom event,
    Emitter<NameListState> emit,
  ) async {
    try {
      final nameListResponse = await nameRepository.getNamesStartingFrom(
        firstLetter: event.firstLetter,
      );

      emit(
        NameListLoaded(
          nameList: nameListResponse,
        ),
      );
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
