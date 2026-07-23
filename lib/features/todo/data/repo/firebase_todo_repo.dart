import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/features/todo/domain/entities/todo_model.dart';
import 'package:todo_app/features/todo/domain/repo/todo_repo.dart';

class FirebaseTodoRepo implements TodoRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<void> addTodo(TodoModel todo) async {
    try {
      final uid = _auth.currentUser!.uid;
      await _firestore.collection('users').doc(uid).collection('todos').add({
        ...todo.toMap(),
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception("Failed to save todo..: $e");
    }
  }

  @override
  Stream<List<TodoModel>> getTodos() {
    try {
      final uid = _auth.currentUser!.uid;
      return _firestore
          .collection('users')
          .doc(uid)
          .collection('todos')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs.map(TodoModel.fromFirestore).toList(),
          );
    } catch (e) {
      throw Exception("Server Error: $e");
    }
  }

  @override
  Future<void> deleteTodo(String todoId) async {
    try {
      final uid = _auth.currentUser!.uid;
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('todos')
          .doc(todoId)
          .delete();
    } catch (e) {
      throw Exception("Failed to delete Todo: $e");
    }
  }

  @override
  Future<void> toggleComplete(TodoModel todo) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    try {
      final uid = _auth.currentUser!.uid;
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('todos')
          .doc(todo.id)
          .update(todo.toMap());
    } catch (e) {
      throw Exception("Failed to update todo: $e");
    }
  }
}
