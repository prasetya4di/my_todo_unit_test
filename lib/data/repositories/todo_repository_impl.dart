import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_todo_unit_test/data/repositories/mapper/todo_mapper.dart';
import 'package:my_todo_unit_test/data/source/network/todo/impl/todo_network_impl.dart';
import 'package:my_todo_unit_test/data/source/network/todo/todo_network.dart';
import 'package:my_todo_unit_test/domain/entity/todo.dart';
import 'package:my_todo_unit_test/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoNetwork _todoNetwork;

  TodoRepositoryImpl(this._todoNetwork);

  @override
  Future<List<Todo>> fetchTodos() async {
    final todoResponses = await _todoNetwork.fetchTodos();
    return todoResponses.map((e) => TodoMapper.fromResponse(e)).toList();
  }
}

final todoRepositoryProvider = Provider.autoDispose<TodoRepository>((ref) {
  final todoNetwork = ref.read(todoNetworkProvider);
  return TodoRepositoryImpl(todoNetwork);
});