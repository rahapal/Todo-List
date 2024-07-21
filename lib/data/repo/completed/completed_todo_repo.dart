import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list/data/data.dart';

class CompletedTodoRepo {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  Future<void> addCompletedTodo(Map<String, dynamic> datas, String id) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection('completed')
          .doc(id)
          .set(datas);
    } catch (e) {
      throw Exception('Failed to add todo: $e');
    }
  }

  Stream<List<TodoModel>> showTodo() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection('completed')
        .snapshots()
        .map(
          (q) => q.docs.map((e) => TodoModel.fromJson(e.data())).toList(),
        );
  }

  Future<void> deleteTodo(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection('completed')
          .doc(id)
          .delete();
    } catch (e) {
      throw Exception('Failed to add todo: $e');
    }
  }
}
