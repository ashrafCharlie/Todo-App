import 'package:todo_app/features/todo/domain/entities/todo_model.dart';

abstract class TodoRepo {
  Future<void> addTodo( TodoModel todo );

  Stream<List<TodoModel>> getTodos();

  Future<void> updateTodo(TodoModel todo);

  Future<void> deleteTodo(String todoId);

  Future<void> toggleComplete(TodoModel todo);
}