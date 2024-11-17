import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_todo_unit_test/domain/use_case/fetch_todos.dart';
import 'package:my_todo_unit_test/domain/use_case/impl/fetch_todos_impl.dart';
import 'package:my_todo_unit_test/presentation/controller/todo/todo_event.dart';
import 'package:my_todo_unit_test/presentation/controller/todo/todo_state.dart';
import 'package:my_todo_unit_test/presentation/controller/util/base_controller.dart';

class TodoController extends BaseController<TodoEvent, TodoState> {
  final FetchTodos _fetchTodosUseCase;

  TodoController(
    this._fetchTodosUseCase,
  ) : super(TodoState.initial());

  @override
  Future<void> onEvent(TodoEvent event) async {
    await event.when(fetch: () async {
      state = state.copyWith(todos: const AsyncValue.loading());
      final todos = await _fetchTodosUseCase();
      state = state.copyWith(todos: AsyncValue.data(todos));
    });
  }

  @override
  Future<void> onEventError(
      TodoEvent event, Object error, StackTrace stackTrace) async {
    event.when(fetch: () {
      state = state.copyWith(todos: AsyncValue.error(error, stackTrace));
    });
  }
}

final todoControllerProvider =
    StateNotifierProvider.autoDispose<TodoController, TodoState>(
  (ref) => TodoController(ref.read(fetchTodosProvider)),
);
