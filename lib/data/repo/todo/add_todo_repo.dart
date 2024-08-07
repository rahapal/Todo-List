import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list/data/data.dart';

class AddTodoRepo {
  final userId = FirebaseAuth.instance.currentUser?.uid;

  Future<void> addTodo(Map<String, dynamic> datas, String id) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection('todo')
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
        .collection('todo')
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
          .collection('todo')
          .doc(id)
          .delete();
    } catch (e) {
      throw Exception('Failed to add todo: $e');
    }
  }

  Future<void> updateTodo(Map<String, dynamic> datas, String id) async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection('todo')
          .doc(id)
          .get();
      if (docSnapshot.exists) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userId)
            .collection('todo')
            .doc(id)
            .update(datas);
      } else {
        throw Exception('id $id does not exist.');
      }
    } catch (e) {
      throw Exception('Failed to update todo: $e');
    }
  }
}
