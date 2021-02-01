import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BMIResultPage extends StatefulWidget {
  final double result;
  final bool gender;
  BMIResultPage(this.result, this.gender);

  @override
  _BMIResultPageState createState() => _BMIResultPageState();
}

class _BMIResultPageState extends State<BMIResultPage> {
  String _str = "";
  double _bmi = 0;
  bool _isMale = true;

  @override
  void initState() {
    _bmi = widget.result;
    _isMale = widget.gender;

    feedback();
    super.initState();
  }

  void feedback() {
    if (_isMale) {
      if (_bmi < 18)
        _str = "You have UNDERWEIGHT body !";
      else if (_bmi >= 18 && _bmi <= 25)
        _str = "You have NORMAL body !";
      else if (_bmi > 25 && _bmi <= 27)
        _str = "You have OVERWEIGHT body !";
      else
        _str = "You have OBESITY body !";
    } else {
      if (_bmi < 17)
        _str = "You have UNDERWEIGHT body !";
      else if (_bmi >= 17 && _bmi <= 23)
        _str = "You have NORMAL body !";
      else if (_bmi > 23 && _bmi <= 27)
        _str = "You have OVERWEIGHT body !";
      else
        _str = "You have OBESITY body !";
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                CircleAvatar(
                  radius: 120,
                  // backgroundColor: Colors.deepOrange,
                  child: Container(
                    width: 240,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [Colors.blue, Colors.blue[50]])),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Your BMI',
                          style: GoogleFonts.acme(
                            textStyle: TextStyle(
                                fontSize: 20, color: Colors.deepOrange),
                          ),
                        ),
                        Text(
                          _bmi.toString(),
                          style: GoogleFonts.acme(
                            textStyle: TextStyle(
                                fontSize: 70, color: Colors.deepOrange),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  _str,
                  style: GoogleFonts.acme(
                    textStyle:
                        TextStyle(fontSize: 20, color: Colors.deepOrange),
                  ),
                )
              ])),
        ));
  }
}
