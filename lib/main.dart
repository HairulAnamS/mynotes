import 'package:flutter/material.dart';
import 'package:project1/wrapper.dart';
import 'package:project1/auth_services.dart';
import 'package:provider/provider.dart';
//import 'package:project1/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.firebaseUserStream,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
