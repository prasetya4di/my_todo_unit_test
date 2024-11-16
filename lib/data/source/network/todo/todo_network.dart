import 'package:my_todo_unit_test/data/source/network/response/todo_response.dart';

abstract class TodoNetwork {
  Future<List<TodoResponse>> fetchTodos();
}