import 'package:equatable/equatable.dart';

class TodoModel extends Equatable {
  final String id;
  final String title;
  final bool isCompleted;

  const TodoModel({
    required this.id,
    required this.title,
    required this.isCompleted,
  });
  @override
  List<Object?> get props => [];

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'isCompleted': isCompleted};
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(id: map['id'] as String ,
     title: map['title'] as String ,
      isCompleted: map['isCompleted'] as bool , );
  }
}
