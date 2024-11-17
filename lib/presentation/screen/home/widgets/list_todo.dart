import 'package:flutter/material.dart';
import 'package:my_todo_unit_test/domain/entity/todo.dart';
import 'package:my_todo_unit_test/presentation/screen/home/widgets/todo_item.dart';

class ListTodo extends StatelessWidget {
  final List<Todo> todos;

  const ListTodo({super.key, required this.todos});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: todos.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 12);
      },
      itemBuilder: (context, index) {
        return TodoItem(todo: todos[index]);
      },
    );
  }
}
