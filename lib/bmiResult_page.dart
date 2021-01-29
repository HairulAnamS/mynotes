import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class BMIResultPage extends StatefulWidget {
  final String result;
  BMIResultPage(this.result);
  
  @override
  _BMIResultPageState createState() => _BMIResultPageState();
}

class _BMIResultPageState extends State<BMIResultPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Container(
              height: 300, color: Colors.deepOrange,
              child: Text(widget.result, style: TextStyle(fontSize: 50),),
            )
          ),
        ));
  }
}
