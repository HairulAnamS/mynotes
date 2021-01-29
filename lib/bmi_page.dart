import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:project1/bmiResult_page.dart';
// import 'package:flutter_xlider/flutter_xlider.dart';
// import 'package:weight_slider/weight_slider.dart';
// import 'package:syncfusion_flutter_gauges/gauges.dart';

class BMIPage extends StatefulWidget {
  @override
  _BMIPageState createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {
  double _weight = 50;
  double _height = 150;
  int _age = 22;
  bool _isMale = true;

  final RoundedLoadingButtonController btnController =
      new RoundedLoadingButtonController();

  @override
  void initState() {
    super.initState();
  }

  void changeAge(bool isInc) {
    if (isInc) {
      setState(() {
        _age = _age + 1;
      });
    } else {
      setState(() {
        _age = _age - 1;
      });
    }
  }

  void doSomething() async {
    Timer(Duration(seconds: 3), () {
      btnController.success();
      Navigator.of(context)
          .push(
        new MaterialPageRoute<String>(
            builder: (context) => new BMIResultPage('Test')),
      )
          .then((String val) {
        setState(() {
          btnController.reset();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              color: Colors.deepOrange[400],
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 35, 15, 15),
                child: Text(
                  'BMI Calculator',
                  style: GoogleFonts.gorditas(
                      textStyle: TextStyle(fontSize: 26, color: Colors.white)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 100, 10, 10),
              child: ListView(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 150,
                      width: 180,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                blurRadius: 5,
                                offset: Offset(2, 2))
                          ]),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'GENDER',
                              style: GoogleFonts.meriendaOne(
                                  textStyle: TextStyle(
                                      fontSize: 16, color: Colors.grey[600])),
                            ),
                          ),
                          Container(
                            height: 1,
                            width: 160,
                            color: Colors.grey,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isMale = !_isMale;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: (_isMale)
                                          ? Image.asset(
                                              "img/man-blue.png",
                                              scale: 1.5,
                                            )
                                          : Image.asset(
                                              "img/man-grey.png",
                                              scale: 1.5,
                                            ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text('Male',
                                        style:
                                            TextStyle(color: Colors.grey[600])),
                                  )
                                ],
                              ),
                              Container(
                                  width: 1, height: 100, color: Colors.grey),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isMale = !_isMale;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: (_isMale)
                                          ? Image.asset(
                                              "img/woman-grey.png",
                                              scale: 1.5,
                                            )
                                          : Image.asset(
                                              "img/woman-blue.png",
                                              scale: 1.5,
                                            ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      'Female',
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 150,
                      width: 120,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                blurRadius: 5,
                                offset: Offset(2, 2))
                          ]),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'AGE',
                              style: GoogleFonts.meriendaOne(
                                  textStyle: TextStyle(
                                      fontSize: 16, color: Colors.grey[600])),
                            ),
                          ),
                          Container(
                            height: 1,
                            width: 100,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            _age.toString(),
                            style: GoogleFonts.meriendaOne(
                                textStyle: TextStyle(
                                    fontSize: 24, color: Colors.grey[600])),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 55,
                                padding: EdgeInsets.fromLTRB(8, 15, 8, 8),
                                child: RaisedButton(
                                  color: Colors.deepOrange[400],
                                  onPressed: () {
                                    changeAge(false);
                                  },
                                  child: Text(
                                    '-',
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Container(
                                width: 55,
                                padding: EdgeInsets.fromLTRB(8, 15, 8, 8),
                                child: RaisedButton(
                                  color: Colors.deepOrange[400],
                                  onPressed: () {
                                    changeAge(true);
                                  },
                                  child: Text(
                                    '+',
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  // height: 170,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            blurRadius: 5,
                            offset: Offset(2, 2))
                      ]),
                  child: Column(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text(
                      //     'WEIGHT',
                      //     style: GoogleFonts.meriendaOne(
                      //         textStyle:
                      //             TextStyle(fontSize: 16, color: Colors.black)),
                      //   ),
                      // ),
                      // Container(
                      //   height: 1,
                      //   width: 300,
                      //   color: Colors.grey,
                      // ),
                      SizedBox(
                        height: 10,
                      ),

                      CircleAvatar(
                        radius: 62,
                        backgroundColor: Colors.deepOrange,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Text(
                                  'WEIGHT',
                                  style: GoogleFonts.paytoneOne(
                                      textStyle: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey[600])),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _weight.round().toString(),
                                      style: GoogleFonts.paytoneOne(
                                          textStyle: TextStyle(
                                              fontSize: 34,
                                              color: Colors.grey[600])),
                                    ),
                                    Text(
                                      'kg',
                                      style: GoogleFonts.paytoneOne(
                                          textStyle: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey[600])),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            color: Colors.blue[100],
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  blurRadius: 5,
                                  offset: Offset(2, 2))
                            ]),

                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Colors.deepOrange,
                            inactiveTrackColor: Colors.deepOrange[100],
                            trackHeight: 3.0,
                            thumbColor: Colors.deepOrange,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 10.0),
                            overlayColor: Colors.purple.withAlpha(32),
                            overlayShape:
                                RoundSliderOverlayShape(overlayRadius: 14.0),
                          ),
                          child: Slider(
                            value: _weight,
                            min: 0,
                            max: 150,
                            divisions: 150,
                            label: _weight.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _weight = value;
                              });
                            },
                          ),
                        ),

                        // color: Colors.teal,
                        // child: WeightSlider(
                        //   weight: _weight,
                        //   minWeight: 40,
                        //   maxWeight: 120,
                        //   onChange: (val) => setState(() => this._weight = val),
                        //   unit: ' kg', // optional
                        // ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            blurRadius: 5,
                            offset: Offset(2, 2))
                      ]),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'HEIGHT',
                          style: GoogleFonts.meriendaOne(
                              textStyle: TextStyle(
                                  fontSize: 16, color: Colors.grey[600])),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: 310,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _height.round().toString(),
                              style: GoogleFonts.meriendaOne(
                                  textStyle: TextStyle(
                                      fontSize: 36, color: Colors.grey[600])),
                            ),
                            Text(
                              'cm',
                              style: GoogleFonts.meriendaOne(
                                textStyle: TextStyle(
                                    fontSize: 18, color: Colors.grey[600]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Colors.blue,
                            inactiveTrackColor: Colors.blue[100],
                            trackHeight: 3.0,
                            thumbColor: Colors.blue,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 10.0),
                            overlayColor: Colors.purple.withAlpha(32),
                            overlayShape:
                                RoundSliderOverlayShape(overlayRadius: 14.0),
                          ),
                          child: Slider(
                            value: _height,
                            min: 0,
                            max: 200,
                            divisions: 200,
                            label: _height.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _height = value;
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: RoundedLoadingButton(
                    color: Colors.deepOrange,
                    width: 200,
                    height: 50,
                    child: Text(
                      'GO !',
                      style: GoogleFonts.fasterOne(
                        textStyle:
                            TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    ),
                    controller: btnController,
                    onPressed: doSomething,
                  ),
                )
              ]),
            )
          ],
        ),

        // SizedBox(height: 10,),
        // Container(
        //   height: MediaQuery.of(context).size.height * 0.72,
        //   color: Colors.white,
        // )
      ),
    );
  }
}
