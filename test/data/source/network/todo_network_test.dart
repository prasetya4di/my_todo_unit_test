import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/mockito.dart';
import 'package:my_todo_unit_test/data/source/network/response/todo_response.dart';
import 'package:my_todo_unit_test/data/source/network/todo/impl/todo_network_impl.dart';

void main() {
  group('Todo Network', () {
    late ProviderContainer container;
    late Dio dio;
    late DioAdapter dioAdapter;

    setUp(() {
      dio = Dio();
      dioAdapter = DioAdapter(dio: dio);
      container = ProviderContainer(overrides: [
        todoNetworkProvider.overrideWithValue(TodoNetworkImpl(dioAdapter.dio))
      ]);
    });

    tearDown(() {
      dioAdapter.close();
      container.dispose();
    });

    test('Fetch list todo success', () async {
      final file = File('test/data/source/network/todo_response.json');
      final jsonString = await file.readAsString();
      final jsonData = jsonDecode(jsonString);

      when(dioAdapter.onGet('/todos', (server) => server.reply(200, jsonData)));

      final todoNetwork = container.read(todoNetworkProvider);
      final todos = await todoNetwork.fetchTodos();

      expect(todos, isNotEmpty);
      expect(todos, isA<List<TodoResponse>>());
    });

    test('Fetch list todo failed', () async {
      when(dioAdapter.onGet('/todos', (server) => server.reply(500, '')));

      try {
        final todoNetwork = container.read(todoNetworkProvider);
        await todoNetwork.fetchTodos();
      } catch (e) {
        expect(e, isA<DioException>());
      }
    });
  });
}
