import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_todo_unit_test/presentation/controller/todo/todo_controller.dart';
import 'package:my_todo_unit_test/presentation/controller/todo/todo_event.dart';
import 'package:my_todo_unit_test/presentation/screen/home/widgets/list_todo.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      final controller = ref.read(todoControllerProvider.notifier);
      controller.emit(const TodoEvent.fetch());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body:
          ref.watch(todoControllerProvider.select((value) => value.todos)).when(
                data: (todos) => ListTodo(todos: todos),
                error: (error, stackTrace) => Center(
                  child: Text('Error: $error'),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
    );
  }
}
