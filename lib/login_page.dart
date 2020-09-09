import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project1/auth_services.dart';
import 'package:project1/main_page.dart';
import 'package:project1/loading.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController control_email = TextEditingController();
  TextEditingController control_password = TextEditingController();

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  bool result;
  String message = "";
  FirebaseUser userLogin, userSignUp;

  bool _checkEmailPassword(bool isSignIn) {
    setState(() {
      result = true;
      if (isSignIn) {
        if (control_email.text.trim() == "") {
          result = false;
          message = "Email belum diisi";
        } else if (control_password.text.trim() == "") {
          result = false;
          message = "Password belum diisi";
        }
      } else {
        if (control_email.text.trim() == "") {
          result = false;
          message = "Email belum diisi";
        } else if (control_password.text.trim() == "") {
          result = false;
          message = "Password belum diisi";
        } else if (!control_email.text.contains('@')) {
          result = false;
          message = "Format email salah";
        } else if (control_password.text.length < 6) {
          result = false;
          message = "Password harus 6 karakter";
        }
      }
    });
    return result;
  }

  Future<void> _showAlert(BuildContext context, String aMessage) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: Text(''),
          content: Text(aMessage),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleSubmit(BuildContext context, bool isLogin) async {
    try {
      if (isLogin) {
        if (_checkEmailPassword(true)) {
          Dialogs.showLoadingDialog(context, _keyLoader); //invoking login
          userLogin = await AuthServices.signIn(
              control_email.text, control_password.text);
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();

          if (userLogin == null) {
            message = "Email dan password salah.";
            _showAlert(context, message);
          }
        } else {
          _showAlert(context, message);
        }
      } else {
        if (_checkEmailPassword(false)) {
          Dialogs.showLoadingDialog(context, _keyLoader); //invoking signUp
          userSignUp = await AuthServices.signUp(
              control_email.text, control_password.text);
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();

          if (userSignUp == null) {
            message = "Daftar user gagal.";
            _showAlert(context, message);
          } else {
            message = "Daftar user berhasil";
            _showAlert(context, message);
          }
        } else {
          _showAlert(context, message);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          body: new ListView(padding: EdgeInsets.all(0), children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    color: Colors.blue[300],
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    padding: EdgeInsets.fromLTRB(100, 50, 100, 50),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("img/heru_logo.jpg"),
                      radius: 80,
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.blue,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(30),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: control_email,
                      keyboardType: TextInputType.emailAddress,
                      //maxLength: 12,
                      decoration: InputDecoration(
                          //icon: Icon(Icons.people),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          prefixIcon: Icon(Icons.person),
                          //prefixText: "Username",
                          hintText: "Email",
                          labelText: "Email"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 30),
                    child: TextField(
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: control_password,
                      maxLength: 6,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          //icon: Icon(Icons.people),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          prefixIcon: Icon(Icons.vpn_key),
                          //prefixText: "Username",
                          hintText: "Password",
                          labelText: "Password"),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      _handleSubmit(context, true);
                      // if (_checkEmailPassword(true)) {
                      //   userLogin = await AuthServices.signIn(
                      //       control_email.text, control_password.text);
                      //   if (userLogin == null) {
                      //     message = "Email dan password salah.";
                      //     _showAlert(context, message);
                      //   }
                      // } else {
                      //   _showAlert(context, message);
                      // }
                    },
                    child: Text(
                      "       LOGIN       ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    textColor: Colors.white,
                    color: Colors.blue[300],
                    splashColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                    child: Text(
                      "     SIGN UP     ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    onPressed: () async {
                      _handleSubmit(context, false);
                      // if (_checkEmailPassword(false)) {
                      //   userSignUp = await AuthServices.signUp(
                      //       control_email.text, control_password.text);
                      //   if (userSignUp == null) {
                      //     message = "Daftar user gagal.";
                      //     _showAlert(context, message);
                      //   } else {
                      //     message = "Daftar user berhasil";
                      //     _showAlert(context, message);
                      //   }
                      // } else {
                      //   _showAlert(context, message);
                      // }
                    },
                    textColor: Colors.blue,
                    color: Colors.white,
                    splashColor: Colors.blue,
                    //shape: StadiumBorder(),
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(20),
                    // ),
                  )

                  // Text(
                  //   "Belum punya akun, DAFTAR DISINI",
                  //   style: TextStyle(
                  //       color: Colors.blue, fontWeight: FontWeight.bold),
                  // )
                  //   ],
                  // )
                ],
              ),
            )
          ]),
        ));
  }
}
