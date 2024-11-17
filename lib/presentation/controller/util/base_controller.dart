import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseController<Event, State> extends StateNotifier<State> {
  BaseController(super.initialState);

  emit(Event event) async {
    if (!mounted) return;
    await onEvent(event).catchError((err, stackTrace) async {
      return onEventError(event, err, stackTrace);
    });
  }

  emitAll(List<Event> events) async {
    for (var event in events) {
      emit(event);
    }
  }

  Future<void> onEvent(Event event);

  Future<void> onEventError(Event event, Object error, StackTrace stackTrace);
}
