import 'package:todo_app_with_firebase/headers.dart';

class FirebaseServices {
  FirebaseServices._();
  static final FirebaseServices instance = FirebaseServices._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  String collectionPath = "Todo";

  Future<void> addTodo({required Todo todo}) async {
    await fireStore.collection(collectionPath).doc(todo.id).set(
          todo.toMap,
        );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getStream() {
    return fireStore.collection(collectionPath).snapshots();
  }

  Future<void> updateStatus({required Todo todoModel}) async {
    await fireStore
        .collection(collectionPath)
        .doc(todoModel.id)
        .update(todoModel.toMap);
  }
}
