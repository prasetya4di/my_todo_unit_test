import 'package:my_todo_unit_test/data/source/network/response/todo_response.dart';
import 'package:my_todo_unit_test/domain/entity/todo.dart';

class TodoMapper {
  static Todo fromResponse(TodoResponse response) {
    return Todo(
      id: response.id,
      userId: response.userId,
      title: response.title,
      completed: response.completed,
    );
  }
}
