//import 'package:flutter/src/material/toggle_buttons.dart';
//import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:custom_switch/custom_switch.dart';
// import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class IotPage extends StatefulWidget {
  @override
  _IotPageState createState() => _IotPageState();
}

class _IotPageState extends State<IotPage> {
  // List<bool> _selections = List.generate(2, (_) => false);
  // List<bool> _isSelected = [false, true, true];
  bool isStatusRT = false;
  bool isStatusKD = false;

  static const strTemperature = 'Temperature';
  static const strHumidity = 'Humidity      ';

  Color currentColor = Colors.white;
  void changeColor(Color color) {
    setState(() => currentColor = color);
  }

  final DBRef = FirebaseDatabase.instance.reference();
  String _stRuangTamu = "";
  String _stKamarDepan = "";
  String _temperature = '0';
  String _humidity = '0';

  static const _ledRuangTamu = 1;
  static const _ledKamarDepan = 2;
  static const _ledTaman = 3;

  // Timer timerMonitoring;
  List<String> modes = ['MODE 1', 'MODE 2', 'MODE 3', 'MODE 4'];
  String mode = 'MODE 1';

  void _insertData(bool index, int led) {
    setState(() {
      if (led == _ledRuangTamu) {
        if (index) {
          DBRef.child("ledRuangTamu").set("On");
          _stRuangTamu = "LED ON";
        } else {
          DBRef.child("ledRuangTamu").set("Off");
          _stRuangTamu = "LED OFF";
        }
      } else if (led == _ledKamarDepan) {
        if (index) {
          DBRef.child("ledKamarDepan").set("On");
          _stKamarDepan = "LED ON";
        } else {
          DBRef.child("ledKamarDepan").set("Off");
          _stKamarDepan = "LED OFF";
        }
      }
    });
  }

  void _updateLedTaman(String hexa, String rgb) {
    DBRef.child("ledTaman").set({'hexa': hexa, 'rgb': rgb});
  }

  void _updateMode(String mode) {
    DBRef.child("mode").set(mode);
  }

  String _generateRGB(Color warna) {
    String warnaku = 'R' +
        warna.red.toString() +
        'G' +
        warna.green.toString() +
        'B' +
        warna.blue.toString();
    return warnaku;
  }

  void _showLedTaman() {
    DBRef.child("ledTaman/hexa").once().then((DataSnapshot dataSnapshot) {
      //print(dataSnapshot.value);
      String colorString = dataSnapshot.value;
      String valueString =
          colorString.split('(0x')[1].split(')')[0]; // kind of hacky..
      int value = int.parse(valueString, radix: 16);
      setState(() {
        currentColor = new Color(value);
      });
    });
  }

  _loadStateSwitch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //setState(() {
    // _counter = (prefs.getInt('counter') ?? 0);
    //print('Masuk');
    isStatusRT = true;
    isStatusKD = true;
    // isStatusRT = (prefs.getBool('isStatusRT') ?? false);
    // isStatusKD = (prefs.getBool('isStatusKD') ?? false);
    //});
    print(prefs.getBool('isStatusRT').toString());
  }

  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _monitoring();
    isStatusKD = (prefs.getBool('isStatusKD') ?? false);
    isStatusRT = (prefs.getBool('isStatusRT') ?? false);

    return isStatusKD;
    //return isStatusKD;
  }

  _saveStateSwitch(bool aValue, int aLed) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (aLed == _ledRuangTamu) {
        prefs.setBool('isStatusRT', aValue);
      } else if (aLed == _ledKamarDepan) {
        prefs.setBool('isStatusKD', aValue);
      }
    });
  }

  _showData() {
    DBRef.child("ledRuangTamu").once().then((DataSnapshot dataSnapshot) {
      String _dataLedRuangTamu = dataSnapshot.value;
      setState(() {
        if (_dataLedRuangTamu == "On") {
          _stRuangTamu = "LED ON";
          Global.shared.isStatusRT = true;
          // isStatusRT = true;
        } else {
          _stRuangTamu = "LED OFF";
          Global.shared.isStatusRT = false;
          // isStatusRT = false;
        }
      });
      // print(isStatusRT.toString());
    });
    DBRef.child("ledKamarDepan").once().then((DataSnapshot dataSnapshot) {
      String _dataLedKamarDepan = dataSnapshot.value;
      setState(() {
        if (_dataLedKamarDepan == "On") {
          _stKamarDepan = "LED ON";
          Global.shared.isStatusKD = true;
          // isStatusKD = true;
        } else {
          _stKamarDepan = "LED OFF";
          Global.shared.isStatusKD = false;
          // isStatusKD = false;
        }
      });
      // print(isStatusKD.toString());
    });

    DBRef.child("mode").once().then((DataSnapshot dataSnapshot) {
      setState(() {
        mode = dataSnapshot.value;
      });
      print(mode);
    });
  }

  @override
  void initState() {
    super.initState();

    _showData();
    _showLedTaman();

    isStatusRT = Global.shared.isStatusRT;
    isStatusKD = Global.shared.isStatusKD;

    // Timer.periodic(Duration(seconds: 2), (timerMonitoring) {
    //   //_monitoring();
    // });
    //_loadStateSwitch();
  }

  @override
  void dispose() {
    //DBRef.onDisconnect();
    //timerMonitoring.cancel();
    super.dispose();
  }

  void _monitoring() {
    DBRef.child("temperature").once().then((DataSnapshot dataSnapshot) {
      if (this.mounted) {
        setState(() {
          _temperature = dataSnapshot.value;
        });
      }
    });
    DBRef.child("humidity").once().then((DataSnapshot dataSnapshot) {
      if (this.mounted) {
        setState(() {
          _humidity = dataSnapshot.value;
        });
      }
    });
  }

  List<DropdownMenuItem> generateItems(List<String> modes) {
    List<DropdownMenuItem> items = [];

    for (var item in modes) {
      items.add(DropdownMenuItem(child: Text(item), value: item));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        body: FutureBuilder(
            future: _getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // print(snapshot.data);
                return ListView(padding: EdgeInsets.all(0), children: <Widget>[
                  Center(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.green[400],
                              shape: BoxShape.rectangle,
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(3.0, 3.0),
                                    blurRadius: 8.0,
                                    spreadRadius: 2.0,
                                    color: Colors.green[800]),
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // IconButton(
                              //   icon: Icon(
                              //     Icons.wifi_tethering,
                              //     color: Colors.black,
                              //     //size: 35,
                              //   ),
                              //   onPressed: null,
                              //   iconSize: 35,
                              // ),
                              Text(
                                'IOT System',
                                style: GoogleFonts.russoOne(
                                    textStyle: TextStyle(
                                        fontSize: 26, color: Colors.black)),
                                // style: TextStyle(
                                //     fontSize: 24,
                                //     color: Colors.white,
                                //     fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          //height: 170,
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Ruang Tamu',
                                style: GoogleFonts.russoOne(
                                    textStyle: TextStyle(
                                        fontSize: 16, color: Colors.white)),
                              ),
                              SizedBox(height: 10),
                              Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  // ToggleSwitch(
                                  //     initialLabelIndex: _stRuangTamuInt,
                                  //     minWidth: 70.0,
                                  //     cornerRadius: 10,
                                  //     activeBgColor: Colors.green,
                                  //     activeTextColor: Colors.white,
                                  //     inactiveBgColor: Colors.grey,
                                  //     inactiveTextColor: Colors.white,
                                  //     labels: ['OFF', 'ON'],
                                  //     icons: [Icons.close, Icons.check],
                                  //     onToggle: (_stRuangTamuInt) {
                                  //       _insertData(_stRuangTamuInt, _ledRuangTamu);
                                  //     }),

                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 30, right: 65),
                                    child: CustomSwitch(
                                      activeColor: Colors.green,
                                      value: isStatusRT,
                                      onChanged: (value) {
                                        _insertData(value, _ledRuangTamu);
                                        setState(() {
                                          isStatusRT = value;
                                          _saveStateSwitch(
                                              value, _ledRuangTamu);
                                          Global.shared.isStatusRT = value;
                                          //value = !value;
                                          print("VALUE RT : $value");
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 80,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(width: 55),
                                  Text(
                                    _stRuangTamu,
                                    style: GoogleFonts.russoOne(
                                        textStyle: TextStyle(
                                            fontSize: 20, color: Colors.white)),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        garis(),
                        Container(
                          // height: 170,
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Kamar Depan',
                                style: GoogleFonts.russoOne(
                                    textStyle: TextStyle(
                                        fontSize: 16, color: Colors.white)),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 30, right: 65),
                                    child: CustomSwitch(
                                      activeColor: Colors.green,
                                      value: isStatusKD,
                                      onChanged: (value) {
                                        _insertData(value, _ledKamarDepan);
                                        setState(() {
                                          isStatusKD = value;
                                          _saveStateSwitch(
                                              value, _ledKamarDepan);
                                          Global.shared.isStatusKD = value;
                                          //value = !value;
                                          print("VALUE KD : $value");
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 80,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(width: 55),
                                  Text(
                                    _stKamarDepan,
                                    style: GoogleFonts.russoOne(
                                        textStyle: TextStyle(
                                            fontSize: 20, color: Colors.white)),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        garis(),
                        Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Lampu Taman',
                                style: GoogleFonts.russoOne(
                                    textStyle: TextStyle(
                                        fontSize: 16, color: Colors.white)),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: ButtonTheme(
                                      height: 50,
                                      minWidth: 70,
                                      child: RaisedButton(
                                        shape: StadiumBorder(),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                    'Pilih warna gaes...',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: MaterialPicker(
                                                      pickerColor: currentColor,
                                                      onColorChanged:
                                                          changeColor,
                                                      enableLabel: true,
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      child: Text(
                                                        'OKAY',
                                                        style: GoogleFonts
                                                            .fredokaOne(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                      shape: StadiumBorder(),
                                                      color: Colors.black,
                                                      onPressed: () {
                                                        setState(() =>
                                                            currentColor =
                                                                currentColor);
                                                        _updateLedTaman(
                                                            currentColor
                                                                .toString(),
                                                            _generateRGB(
                                                                currentColor));
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        child: Text('Pilih Warna',
                                            style: GoogleFonts.russoOne(
                                                fontSize: 16)),
                                        color: currentColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 18),
                                  Container(
                                    width: 1,
                                    height: 80,
                                    color: Colors.grey,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 25),
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    height: 50,
                                    // decoration: BoxDecoration(
                                    //   borderRadius:
                                    //       BorderRadius.circular(10.0),
                                    //   border: Border.all(
                                    //       color: Colors.white,
                                    //       style: BorderStyle.solid,
                                    //       width: 1.0),
                                    // ),
                                    //child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      dropdownColor: Colors.black,
                                      hint: Text("Pilih mode",
                                          style:
                                              TextStyle(color: Colors.white)),
                                      value: mode,
                                      items: modes.map((value) {
                                        return DropdownMenuItem(
                                          child: Text(
                                            value,
                                            style: GoogleFonts.russoOne(
                                                textStyle: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white)),
                                          ),
                                          value: value,
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          mode = value;
                                          _updateMode(mode);
                                        });
                                      },
                                    ),
                                  )
                                  //),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text(
                          _generateRGB(currentColor),
                          style: GoogleFonts.russoOne(
                              textStyle:
                                  TextStyle(fontSize: 14, color: Colors.white)),
                        ),
                        SizedBox(height: 20),
                        garis(),
                        Container(
                          margin: EdgeInsets.only(left: 15, top: 25),
                          child: barisData(Icons.cloud_off, strTemperature,
                              _temperature + " °C"),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15, top: 15),
                          child: barisData(
                              Icons.hourglass_empty, strHumidity, _humidity),
                        )
                      ],
                    ),
                  ),
                ]);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

  Row barisData(IconData aIcon, String aTitle, String aData) {
    return Row(
      children: <Widget>[
        Icon(
          aIcon,
          color: Colors.white,
          size: 50,
        ),
        SizedBox(
          width: 30,
        ),
        Text(
          aTitle,
          textAlign: TextAlign.left,
          style: GoogleFonts.russoOne(
              textStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
          )),
        ),
        SizedBox(width: 60),
        Text(
          (aData != null) ? aData : '0',
          style: GoogleFonts.russoOne(
              textStyle: TextStyle(color: Colors.white, fontSize: 20)),
        )
      ],
    );
  }

  Container garis() {
    return Container(
      height: 0.5,
      color: Colors.grey,
      // margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
    );
  }
}

class Global {
  static final shared = Global();
  bool isStatusRT = false;
  bool isStatusKD = false;
}
