import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class TodoModel extends Equatable {
  final String id;
  final String title;
  final bool isCompleted;
  final DateTime? createdAt;

  const TodoModel({
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.createdAt,
  });
  @override
  List<Object?> get props => [id, title, isCompleted, createdAt];
  
  TodoModel copyWith({String? id, String? title, bool? isCompleted, DateTime? createdAt}) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title ,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] as String,
      title: map['title'] as String,
      isCompleted: map['isCompleted'] as bool,
       createdAt: map['createdAt'] != null 
    ? (map['createdAt'] as Timestamp).toDate() 
    : null,
    );
  }


  //we use this instead fromMap method
  factory TodoModel.fromFirestore(DocumentSnapshot doc) {
  final data = doc.data() as Map<String, dynamic>;

  return TodoModel(
    id: doc.id,
    title: data['title'],
    isCompleted: data['isCompleted'],
    createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
  );
}
}
