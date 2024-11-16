import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_todo_unit_test/data/source/network/dio_provider.dart';
import 'package:my_todo_unit_test/data/source/network/response/todo_response.dart';
import 'package:my_todo_unit_test/data/source/network/todo/todo_network.dart';

class TodoNetworkImpl implements TodoNetwork {
  final Dio dio;

  TodoNetworkImpl(this.dio);

  @override
  Future<List<TodoResponse>> fetchTodos() async {
    final response = await dio.get('/todos');
    final data = response.data as List<dynamic>;
    return data.map((e) => TodoResponse.fromJson(e)).toList();
  }
}

final todoNetworkProvider = Provider.autoDispose<TodoNetwork>((ref) {
  return TodoNetworkImpl(ref.watch(dioProvider));
});
