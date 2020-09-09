import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project1/login_page.dart';
import 'package:project1/main_page.dart';
import 'package:provider/provider.dart';
// import 'package:project1/catatan_page.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);

    return (firebaseUser == null) ? LoginPage() : MainPage(firebaseUser);
    // return CatatanPage();
  }
}