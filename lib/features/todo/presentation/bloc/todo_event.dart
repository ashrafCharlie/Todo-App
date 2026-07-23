import 'package:todo_app/features/todo/domain/entities/todo_model.dart';

sealed class TodoEvent {}

class TodoLoadEvent extends TodoEvent {}

class TodoAddEvent extends TodoEvent {
  final String todoTitle;
  TodoAddEvent({required this.todoTitle});
}

class TodoUpdateEvent extends TodoEvent {
  final TodoModel todo;
  TodoUpdateEvent({required this.todo});
}

class TodoDeleteEvent extends TodoEvent {
  final String id;
  TodoDeleteEvent({required this.id});
}
