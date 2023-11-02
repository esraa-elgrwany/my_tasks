import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_project/models/usermodel.dart';
import 'package:todo_project/shared/firebase/firebaseFunctions.dart';

class MyProvider extends ChangeNotifier{
  String languageCode="en";
  ThemeMode modeApp=ThemeMode.light;
  UserModel? userModel;
  User? firebaseUser;

  MyProvider(){
    firebaseUser=FirebaseAuth.instance.currentUser;
    if(firebaseUser!=null)
    initUser();
  }

  initUser()async{
    firebaseUser=FirebaseAuth.instance.currentUser;
    userModel=await FireBaseFunctions.readUserFromFireStore(firebaseUser!.uid);
    notifyListeners();
  }

  changeLanguage(String langCode){
    languageCode=langCode;
    notifyListeners();
  }

  changeMode(ThemeMode mode){
    modeApp=mode;
    notifyListeners();
  }
}