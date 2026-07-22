import 'package:equatable/equatable.dart';
import 'package:todo_app/features/todo/domain/entities/todo_model.dart';

sealed class TodoState  extends Equatable {
 @override
  List<Object?> get props => []; 

}

class TodoinitState extends TodoState {}

class TodoLoadingState extends TodoState {}

class TodoLoadedState extends TodoState {
  final List<TodoModel> todos;
  TodoLoadedState({required this.todos});
  @override

  List<Object?> get props => [todos];
}

class TodoSuccessState extends TodoState{
}

class TodoErrorState extends TodoState {
  final String errorMsg;
  TodoErrorState({required this.errorMsg});
   @override

  List<Object?> get props => [errorMsg];
}
