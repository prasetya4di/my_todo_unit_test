import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_todo_unit_test/data/repository/todo_repository_impl.dart';
import 'package:my_todo_unit_test/domain/entity/todo.dart';
import 'package:my_todo_unit_test/domain/repository/todo_repository.dart';
import 'package:my_todo_unit_test/domain/use_case/impl/fetch_todos_impl.dart';

import '../util/dummy_builder.dart';
import 'fetch_todos_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  group("Fetch todo use case", () {
    late ProviderContainer container;
    late TodoRepository todoRepository;

    setUp(() {
      todoRepository = MockTodoRepository();
      container = ProviderContainer(overrides: [
        todoRepositoryProvider.overrideWithValue(todoRepository),
        fetchTodosProvider.overrideWithValue(FetchTodosImpl(todoRepository)),
      ]);
    });

    tearDown(() {
      container.dispose();
    });

    test('Fetch list todo success', () async {
      when(todoRepository.fetchTodos()).thenAnswer((_) async => dummyTodo());

      final fetchTodos = container.read(fetchTodosProvider);
      final todos = await fetchTodos();

      expect(todos, isNotEmpty);
      expect(todos, isA<List<Todo>>());
    });

    test('Fetch list todo failed', () async {
      when(todoRepository.fetchTodos()).thenThrow(Exception());

      final fetchTodos = container.read(fetchTodosProvider);
      expect(() async => await fetchTodos(), throwsException);
    });
  });
}
