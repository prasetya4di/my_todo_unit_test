import 'package:my_todo_unit_test/data/source/network/response/todo_response.dart';

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
