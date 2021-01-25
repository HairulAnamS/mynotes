import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BMIPage extends StatefulWidget {
  @override
  _BMIPageState createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {
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
                      width: 200,
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
                              'Gender',
                              style: GoogleFonts.meriendaOne(
                                  textStyle: TextStyle(
                                      fontSize: 16, color: Colors.black)),
                            ),
                          ),
                          Container(
                            height: 1,
                            width: 170,
                            color: Colors.grey,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Icon(Icons.accessibility,size: 60,),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text('Male'),
                                  )
                                ],
                              ),
                              Container(
                                width: 1,
                                height: 100,
                                color: Colors.grey
                              ),
                              Column(
                                children: [
                                  Icon(Icons.accessible,size: 60,),
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
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                blurRadius: 5,
                                offset: Offset(2, 2))
                          ]),
                    ),
                  ],
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
                          'Height (cm)',
                          style: GoogleFonts.meriendaOne(
                              textStyle:
                                  TextStyle(fontSize: 16, color: Colors.black)),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: 300,
                        color: Colors.grey,
                      )
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
                          'Weight (kg)',
                          style: GoogleFonts.meriendaOne(
                              textStyle:
                                  TextStyle(fontSize: 16, color: Colors.black)),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: 300,
                        color: Colors.grey,
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
