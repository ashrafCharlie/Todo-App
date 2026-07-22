import 'package:todo_app/features/todo/domain/entities/todo_model.dart';
import 'package:todo_app/features/todo/domain/repo/todo_repo.dart';

class FirebaseTodoRepo  implements  TodoRepo{
  @override
  Future<void> addTodo(TodoModel todo) {
        throw UnimplementedError();
  }

    @override
  Stream<List<TodoModel>> getTodos() {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTodo(String todoId) {
    throw UnimplementedError();
  }



  @override
  Future<void> toggleComplete(TodoModel todo) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateTodo(TodoModel todo) {
    throw UnimplementedError();
  }
}