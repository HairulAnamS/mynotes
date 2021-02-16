//import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project1/auth_services.dart';
import 'package:project1/catatan_page.dart';
import 'package:project1/dzikir_page.dart';
import 'package:project1/iot_page.dart';
import 'package:project1/camera.dart';
import 'package:project1/birthday_page.dart';
import 'package:project1/bmi_page.dart';
import 'package:project1/finance_page.dart';
import 'package:project1/data_page.dart';
//import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatelessWidget {
  final FirebaseUser user;
  static const _menuDzikir = 1;
  static const _menuIOT = 2;
  static const _menuNoted = 3;
  static const _menuCamera = 4;
  static const _menuBirthday = 5;
  static const _menuFinance = 6;
  static const _menuBMI = 7;
  static const _menuData = 8;

  MainPage(this.user);

  Future<void> _showAlert(BuildContext context, String aMessage) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'User Login',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(aMessage),
          actions: <Widget>[
            FlatButton(
              color: Colors.blue,
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

  Future<void> _showAlertExit(BuildContext context, String aMessage) {
    Widget yaButton = FlatButton(
      color: Colors.blue,
      child: Text("Ya"),
      onPressed: () {
        Navigator.of(context).pop();
        AuthServices.signOut();
      },
    );

    Widget tidakButton = FlatButton(
      color: Colors.red,
      child: Text("Tidak"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Konfirmasi',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(aMessage),
          actions: <Widget>[yaButton, tidakButton],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.blue[700],
            // leading: Icon(Icons.android),
            title: Text(
              "My Apps",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.account_circle, color: Colors.white),
                  onPressed: () {
                    _showAlert(context, user.email);
                  }),
              IconButton(
                  icon: Icon(Icons.exit_to_app, color: Colors.white),
                  onPressed: () {
                    _showAlertExit(context, "Apakah yakin ingin keluar ?");
                    // SystemNavigator.pop(); // Exit App
                    //Navigator.pop(context); // Kembali ke page sebelumnya
                  })
            ],
          ),
          body: Center(
              child: ListView(
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                height: 100,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        colors: [Colors.blue, Colors.lightGreen[300]])),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage("img/heru_logo.jpg"),
                      radius: 30,
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Hairul Anam S',
                      style: GoogleFonts.aBeeZee(
                          textStyle:
                              TextStyle(color: Colors.black, fontSize: 18)),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        menu(context, Icons.brightness_4_outlined, 'Dzikir', _menuDzikir),
                        menu(context, Icons.wifi_tethering, 'IOT', _menuIOT),
                        menu(context, Icons.note_add, 'Notes', _menuNoted),
                        menu(context, Icons.camera, 'Camera', _menuCamera),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        menu(context, Icons.cake, 'Birthday', _menuBirthday),
                        menu(context, Icons.money_off_outlined, 'Finance',
                            _menuFinance),
                        menu(context, Icons.accessibility, 'BMI', _menuBMI),
                        menu(context, Icons.folder, 'Data', _menuData),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ))),
    );
  }

  Container menu(
      BuildContext context, IconData aIcon, String aMenu, int aIdMenu) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 80,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          IconButton(
              icon: Icon(
                aIcon,
                color: Colors.blue[700],
              ),
              iconSize: 40,
              onPressed: () {
                if (aIdMenu == _menuDzikir) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DzikirPage()),
                  );
                } else if (aIdMenu == _menuIOT) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IotPage()),
                  );
                } else if (aIdMenu == _menuCamera) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CameraPage()),
                  );
                } else if (aIdMenu == _menuNoted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CatatanPage()),
                  );
                } else if (aIdMenu == _menuBirthday) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BirthDayPage()),
                  );
                } else if (aIdMenu == _menuBMI) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BMIPage()),
                  );
                } else if (aIdMenu == _menuFinance) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FinancePage()),
                  );
                } else if (aIdMenu == _menuData) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DataPage()),
                  );
                }
              }),
          Text(
            aMenu,
            style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(color: Colors.black, fontSize: 14)),
          )
        ],
      ),
    );
  }
}
