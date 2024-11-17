import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_todo_unit_test/data/repository/todo_repository_impl.dart';
import 'package:my_todo_unit_test/domain/entity/todo.dart';
import 'package:my_todo_unit_test/domain/repository/todo_repository.dart';
import 'package:my_todo_unit_test/domain/use_case/fetch_todos.dart';

class FetchTodosImpl implements FetchTodos {
  final TodoRepository _todoRepository;

  FetchTodosImpl(this._todoRepository);

  @override
  Future<List<Todo>> call() async {
    return _todoRepository.fetchTodos();
  }
}

final fetchTodosProvider = Provider.autoDispose<FetchTodos>((ref) {
  final todoRepository = ref.read(todoRepositoryProvider);
  return FetchTodosImpl(todoRepository);
});
