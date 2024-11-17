import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_todo_unit_test/domain/use_case/fetch_todos.dart';
import 'package:my_todo_unit_test/domain/use_case/impl/fetch_todos_impl.dart';
import 'package:my_todo_unit_test/presentation/controller/todo/todo_controller.dart';
import 'package:my_todo_unit_test/presentation/controller/todo/todo_event.dart';

import '../util/dummy_builder.dart';
import 'todo_controller_test.mocks.dart';

@GenerateMocks([FetchTodos])
void main() {
  group('Todo controller test', () {
    late ProviderContainer container;
    late MockFetchTodos mockFetchTodosUseCase;

    setUp(() {
      mockFetchTodosUseCase = MockFetchTodos();
      container = ProviderContainer(overrides: [
        fetchTodosProvider.overrideWithValue(mockFetchTodosUseCase),
      ]);
    });

    tearDown(() {
      container.dispose();
    });

    test('should fetch todos on Fetch event', () async {
      final mockTodos = dummyTodo();
      when(mockFetchTodosUseCase()).thenAnswer((_) async => mockTodos);

      final controller = container.read(todoControllerProvider.notifier);
      await controller.emit(const TodoEvent.fetch());

      verify(mockFetchTodosUseCase()).called(1);
      expect(controller.state.todos, AsyncValue.data(mockTodos));
    });

    test('should handle error on Fetch event', () async {
      final error = Exception('Failed to fetch todos');
      when(mockFetchTodosUseCase()).thenThrow(error);
      final controller = container.read(todoControllerProvider.notifier);

      try {
        controller.emit(const TodoEvent.fetch());
      } catch (e) {
        verify(mockFetchTodosUseCase()).called(1);
        expect(controller.state.todos, isA<AsyncError>());
      }
    });
  });
}
