import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:weight_slider/weight_slider.dart';

class BMIPage extends StatefulWidget {
  @override
  _BMIPageState createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {
  int _weight = 50;
  double _height = 150;
  int _age = 22;
  bool _isMale = true;

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
                                      fontSize: 16, color: Colors.black)),
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
                                    child: Text('Male'),
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
                                    child: Text('Female'),
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
                                      fontSize: 16, color: Colors.black)),
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
                                    fontSize: 24, color: Colors.black)),
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
                  height: 20,
                ),
                Container(
                  height: 220,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.deepOrange[50],
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
                          'WEIGHT',
                          style: GoogleFonts.meriendaOne(
                              textStyle:
                                  TextStyle(fontSize: 16, color: Colors.black)),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: 300,
                        color: Colors.grey,
                      ),
                      Container(
                        // width: 700,
                        height: 180,
                        // color: Colors.teal,
                        child: WeightSlider(
                          weight: _weight,
                          minWeight: 40,
                          maxWeight: 120,
                          onChange: (val) => setState(() => this._weight = val),
                          unit: ' kg', // optional
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.deepOrange[50],
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
                              textStyle:
                                  TextStyle(fontSize: 16, color: Colors.black)),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: 300,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          _height.round().toString() + ' cm',
                          style: GoogleFonts.meriendaOne(
                              textStyle:
                                  TextStyle(fontSize: 16, color: Colors.black)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Slider(
                          value: _height,
                          min: 100,
                          max: 200,
                          divisions: 100,
                          label: _height.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              _height = value;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
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
