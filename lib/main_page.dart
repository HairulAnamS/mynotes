//import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project1/auth_services.dart';
import 'package:project1/catatan_page.dart';
import 'package:project1/dzikir_page.dart';
import 'package:project1/iot_page.dart';
import 'package:project1/camera.dart';
//import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatelessWidget {
  final FirebaseUser user;
  static const _menuDzikir = 1;
  static const _menuIOT = 2;
  static const _menuNoted = 3;
  static const _menuCamera = 4;

  MainPage(this.user);

  Future<void> _showAlert(BuildContext context, String aMessage) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('User Login', style: TextStyle(fontWeight: FontWeight.bold),),
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
          title: Text('Konfirmasi', style: TextStyle(fontWeight: FontWeight.bold),),
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
      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("img/ladyslider.jpg"), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: Icon(Icons.android),
              title: Text(
                "My Notes",
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
                SizedBox(height: 70),
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        menu(context, Icons.timelapse, 'Dzikir', _menuDzikir),
                        menu(context, Icons.wifi_tethering, 'IOT', _menuIOT),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        menu(context, Icons.note_add, 'Notes', _menuNoted),
                        menu(context, Icons.camera, 'Camera', _menuCamera),
                      ],
                    ),
                  ],
                )
              ],
            ))),
      ),
    );
  }

  Container menu(
      BuildContext context, IconData aIcon, String aMenu, int aIdMenu) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 120,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          IconButton(
              icon: Icon(
                aIcon,
                color: Colors.blue,
              ),
              iconSize: 70,
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
                } else if (aIdMenu == _menuCamera){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CameraPage()),
                  );
                } else if (aIdMenu == _menuNoted){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CatatanPage()),
                  );
                }
              }),
          Text(
            aMenu,
            style: GoogleFonts.fredokaOne(
                textStyle: TextStyle(color: Colors.black, fontSize: 18)),
          )
        ],
      ),
    );
  }
}
