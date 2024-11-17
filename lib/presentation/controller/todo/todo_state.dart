import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_todo_unit_test/domain/entity/todo.dart';

part 'todo_state.freezed.dart';

@freezed
class TodoState with _$TodoState {
  const factory TodoState({
    required AsyncValue<List<Todo>> todos,
  }) = _TodoState;

  factory TodoState.initial() => const TodoState(
        todos: AsyncValue.data([]),
      );
}
