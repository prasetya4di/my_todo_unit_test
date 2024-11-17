import 'package:my_todo_unit_test/domain/entity/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> fetchTodos();
}
