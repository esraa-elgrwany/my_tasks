import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_project/models/taskmodel.dart';

class FireBaseFunctions {
  static CollectionReference<TaskModel> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJason();
      },
    );
  }

  static Future<void> addTask(TaskModel taskModel) {
    var collection = getTaskCollection();
    var docRef = collection.doc();
    taskModel.id = docRef.id;
    return docRef.set(taskModel);
  }

  static Stream<QuerySnapshot<TaskModel>> getTask(DateTime date) {
    var collection = getTaskCollection();
    return collection.where('id',isEqualTo: 'HNpQoNVmvMdmTJigW0pR')
        .snapshots();
  }

  static deleteTask(String id) {
    getTaskCollection().doc(id).delete();
  }

  static updateTask(TaskModel task) {
    getTaskCollection().doc(task.id).update(task.toJason());
  }
}
