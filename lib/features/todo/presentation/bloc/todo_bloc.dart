import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todo/domain/entities/todo_model.dart';
import 'package:todo_app/features/todo/domain/repo/todo_repo.dart';
import 'package:todo_app/features/todo/presentation/bloc/todo_event.dart';
import 'package:todo_app/features/todo/presentation/bloc/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepo _todoRepo;
  TodoBloc(this._todoRepo) : super(TodoinitState()) {
    on<TodoAddEvent>((event, emit) async {
      try {
        await _todoRepo.addTodo(
          TodoModel(
            title: event.todoTitle,
            isCompleted: false,
            createdAt: null,
            id: '',
          ),
        );
        // emit(TodoSuccessState());
      } catch (e) {
        emit(TodoErrorState(errorMsg: e.toString()));
      }
    });

    on<TodoLoadEvent>((event, emit) async {
      emit(TodoLoadingState());
      try {
        await emit.forEach<List<TodoModel>>(
          _todoRepo.getTodos(),
          onData: (todos) {
            return TodoLoadedState(todos: todos);
          },
          onError: (error, stacktrace) {
            return TodoErrorState(errorMsg: error.toString());
          },
        );
      } catch (e) {
        emit(TodoErrorState(errorMsg: "Server error : $e"));
      }
    });

    on<TodoUpdateEvent>((event, emit) async {
      try {
        await _todoRepo.updateTodo(event.todo);
      } catch (e) {
        emit(TodoErrorState(errorMsg: e.toString()));
      }
    });

    on<TodoDeleteEvent>((event, emit) async {
      try {
        await _todoRepo.deleteTodo(event.id);
      } catch (e) {
        emit(TodoErrorState(errorMsg: e.toString()));
      }
    });
  }
}
