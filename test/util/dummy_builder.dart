import 'package:my_todo_unit_test/data/source/network/response/todo_response.dart';
import 'package:my_todo_unit_test/domain/entity/todo.dart';

List<TodoResponse> dummyTodoResponse() {
  return [
    TodoResponse(
      id: 1,
      userId: 1,
      title: 'delectus aut autem',
      completed: false,
    ),
    TodoResponse(
      id: 2,
      userId: 1,
      title: 'quis ut nam facilis et officia qui',
      completed: false,
    ),
    TodoResponse(
      id: 3,
      userId: 1,
      title: 'fugiat veniam minus',
      completed: false,
    ),
  ];
}

List<Todo> dummyTodo() {
  return [
    Todo(
      id: 1,
      userId: 1,
      title: 'delectus aut autem',
      completed: false,
    ),
    Todo(
      id: 2,
      userId: 1,
      title: 'quis ut nam facilis et officia qui',
      completed: false,
    ),
    Todo(
      id: 3,
      userId: 1,
      title: 'fugiat veniam minus',
      completed: false,
    ),
  ];
}
