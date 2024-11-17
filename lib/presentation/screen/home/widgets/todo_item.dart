import 'package:flutter/material.dart';
import 'package:my_todo_unit_test/domain/entity/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: ListTile(
        leading: Checkbox(
          value: todo.completed,
          onChanged: (value) {},
        ),
        title: Text(todo.title),
      ),
    );
  }
}
