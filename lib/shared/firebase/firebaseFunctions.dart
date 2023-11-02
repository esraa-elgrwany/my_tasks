import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_project/models/taskmodel.dart';
import 'package:todo_project/models/usermodel.dart';

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
    return collection.where("userId",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('date',
            isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .snapshots();
  }

  static deleteTask(String id) {
    getTaskCollection().doc(id).delete();
  }

  static updateTask(TaskModel task) {
    getTaskCollection().doc(task.id).update(task.toJason());
  }

  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJason();
      },
    );
  }

  static Future<void> addUser(UserModel userModel) {
    var collection = getUserCollection();
    var docRef = collection.doc(userModel.id);
    return docRef.set(userModel);
  }

  static Future<void> createUser(String name, int age, String email,
      String password, Function onSuccess, Function onError) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user?.uid != null) {
        UserModel userModel = UserModel(
            id: credential.user!.uid, name: name, age: age, email: email);
        addUser(userModel).then((value) {
          credential.user!.sendEmailVerification();
          onSuccess();
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message);
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        onError(e.message);
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> login(String email, String password, Function onSuccess,
      Function onError) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user?.uid != null) {
       //var user = await readUserFromFireStore(credential.user!.uid);
        onSuccess();
        }
    } on FirebaseAuthException catch (e) {
      onError("wrong email or password");
      /*if (e.code == 'user-not-found') {
        onError(e.message);
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        onError(e.message);
        print('Wrong password provided for that user.');
      }*/
    }
  }

  static readUserFromFireStore(String id) async {
    DocumentSnapshot<UserModel> docRef = await getUserCollection().doc(id).get();
  return docRef.data();
  }
}
