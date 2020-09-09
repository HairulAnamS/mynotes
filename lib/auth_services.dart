import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project1/login_page.dart';

class AuthServices{
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<FirebaseUser> signInAnonymous() async{
    try{
      AuthResult result =  await _auth.signInAnonymously();
      FirebaseUser firebaseUser =  result.user;

      return firebaseUser; 
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  static Future<FirebaseUser> signUp(String email, String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = result.user;

      return firebaseUser;
    }catch(e){
      print(e.toString());

      return null;
    }
  }

  static Future<FirebaseUser> signIn(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = result.user;

      return firebaseUser;
    }catch(e){
       print(e.toString());
      //_showAlert(Builder: (context) => LoginPage(), e.toString());

      return null;
    }
  }

  static Future<void> signOut() async{
    _auth.signOut();
  }

  static Stream<FirebaseUser> get firebaseUserStream => _auth.onAuthStateChanged;

  // static Future<void> _showAlert(BuildContext context, String pesan) {
  //   return showDialog<void>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         //title: Text(''),
  //         content: Text(pesan),
  //         actions: <Widget>[
  //           FlatButton(
  //             child: Text('OK'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}