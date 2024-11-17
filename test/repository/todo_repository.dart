import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_todo_unit_test/data/repositories/todo_repository_impl.dart';
import 'package:my_todo_unit_test/data/source/network/todo/impl/todo_network_impl.dart';
import 'package:my_todo_unit_test/data/source/network/todo/todo_network.dart';
import 'package:my_todo_unit_test/domain/entity/todo.dart';

import '../util/dummy_builder.dart';
import 'todo_repository.mocks.dart';

@GenerateMocks([TodoNetwork])
void main() {
  group("Todo repository", () {
    late ProviderContainer container;
    late TodoNetwork todoNetwork;

    setUp(() {
      todoNetwork = MockTodoNetwork();
      container = ProviderContainer(overrides: [
        todoNetworkProvider.overrideWithValue(todoNetwork),
        todoRepositoryProvider
            .overrideWithValue(TodoRepositoryImpl(todoNetwork)),
      ]);
    });

    tearDown(() {
      container.dispose();
    });

    test('Fetch list todo success', () async {
      when(todoNetwork.fetchTodos())
          .thenAnswer((_) async => dummyTodoResponse());

      final todoRepository = container.read(todoRepositoryProvider);
      final todos = await todoRepository.fetchTodos();

      expect(todos, isNotEmpty);
      expect(todos, isA<List<Todo>>());
    });

    test('Fetch list todo failed', () async {
      when(todoNetwork.fetchTodos()).thenThrow(
          DioException(requestOptions: RequestOptions(path: '/todos')));

      final todoRepository = container.read(todoRepositoryProvider);
      expect(() async => await todoRepository.fetchTodos(), throwsException);
    });
  });
}
