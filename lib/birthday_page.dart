import 'dart:ui';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/people.dart';
import 'package:intl/intl.dart';
import 'package:project1/birthdayInput_page.dart';
import 'package:project1/constant.dart';
// import 'package:custom_switch/custom_switch.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';

class BirthDayPage extends StatefulWidget {
  @override
  _BirthDayPageState createState() => _BirthDayPageState();
}

class _BirthDayPageState extends State<BirthDayPage> {
  bool isLoading = true;
  bool statusFilter = false;
  People people;
  PeopleDB peopleDB;
  List<People> peopleList = [];
  String bulan;
  List bulanList = [
    "Januari",
    "Februari",
    "Maret",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember"
  ];
  TextEditingController controlNama = TextEditingController();
  bool isDelete;

  @override
  void initState() {
    people = new People();
    peopleDB = new PeopleDB();
    isLoading = true;
    isDelete = false;

    ambilData();
    super.initState();
  }

  void ambilData() async {
    print('start ambil data');
    peopleList = await peopleDB.getPeople();
    print('start selesai data');
    setState(() {
      isLoading = false;
    });
  }

  void ambilDatabyFilter(String aValue, bool aisBulan) async {
    print('start ambil data');
    peopleList = await peopleDB.getPeopleFilter(aValue, aisBulan);
    print('start selesai data');
    setState(() {
      isLoading = false;
    });
  }

  Future<void> showConfirm(
      BuildContext context, String aMessage, String aIdPeople) {
    Widget yaButton = FlatButton(
      color: Colors.blue,
      child: Text("Ya"),
      onPressed: () {
        isDelete = true;
        peopleDB.delete(aIdPeople);
        Navigator.of(context).pop();
        setState(() {
          print('ambil data lagi');
          ambilData();
        });
      },
    );

    Widget tidakButton = FlatButton(
      color: Colors.red,
      child: Text("Tidak"),
      onPressed: () {
        isDelete = false;
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

  int hitungUmur(DateTime birthDate) {
    int age = 0;
    DateTime currentDate = DateTime.now();
    age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }

    return age;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              leading: Icon(Icons.cake),
              title: Text(
                'Birthday',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.blue[700]),
          body: (isLoading)
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: FlutterSwitch(
                          activeText: "Filter ON",
                          inactiveText: "Filter OFF",
                          value: statusFilter,
                          valueFontSize: 10.0,
                          width: 80,
                          height: 25,
                          borderRadius: 10.0,
                          showOnOff: true,
                          onToggle: (val) {
                            setState(() {
                              statusFilter = val;
                              if (!statusFilter) {
                                ambilData();
                                // bulan = "";
                                controlNama.text = "";
                              }
                            });
                          },
                        ),
                      ),
                    ),
                    (statusFilter == true)
                        ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            margin: EdgeInsets.fromLTRB(40, 10, 40, 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: Colors.blue[700],
                                  style: BorderStyle.solid,
                                  width: 1.0),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  // dropdownColor: Colors.lightBlue,
                                  hint: Text('Pilih Bulan'),
                                  elevation: 0,
                                  isExpanded: true,
                                  value: bulan,
                                  items: bulanList.map((value) {
                                    return DropdownMenuItem(
                                      child: Text(value),
                                      value: value,
                                    );
                                  }).toList(),
                                  onChanged: (item) {
                                    setState(() {
                                      bulan = item;
                                      ambilDatabyFilter(bulan, true);
                                    });
                                  }),
                            ),
                          )
                        : Container(),
                    (statusFilter == true)
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(40, 0, 40, 10),
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  print(value);
                                  ambilDatabyFilter(value, false);
                                });
                              },
                              controller: controlNama,
                              keyboardType: TextInputType.text,
                              style: TextStyle(height: 0.5),
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.blue[700]),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.blue[700]),
                                ),

                                hintText: "Input Nama",
                                // labelText: "Pekerjaan",
                              ),
                            ),
                          )
                        : Container(),
                    (peopleList.length > 0)
                        ? Expanded(
                            child: ListView.builder(
                                // shrinkWrap: true,
                                // physics: ScrollPhysics(),
                                itemCount: peopleList.length,
                                itemBuilder: (_, index) {
                                  final peoples = peopleList[index];

                                  return Container(
                                      color: (index % 2) == 0
                                          ? Colors.blue[50]
                                          : Colors.white,
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(
                                                new MaterialPageRoute<String>(
                                                    builder: (context) =>
                                                        new BirthdayInputPage(
                                                            peoples, modeEdit)),
                                              )
                                                  .then((String val) {
                                                setState(() {
                                                  print('ambil data lagi');
                                                  ambilData();
                                                });
                                              });
                                            },
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                radius: 23,
                                                backgroundColor:
                                                    (peoples.jenisKelamin ==
                                                            "L")
                                                        ? Colors.blueAccent
                                                        : Colors.pinkAccent,
                                                child: CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor: Colors.white,
                                                  backgroundImage: (peoples
                                                                  .urlPhoto ==
                                                              "" ||
                                                          peoples.urlPhoto ==
                                                              null)
                                                      ? AssetImage(
                                                          "img/noImage.jpg")
                                                      : NetworkImage(
                                                          peoples.urlPhoto),
                                                ),
                                              ),
                                              title: Text(
                                                peoples.nama,
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              subtitle: Text(
                                                DateFormat('dd MMM yyyy')
                                                        .format(
                                                            peoples.tglLahir) +
                                                    ' - ' +
                                                    hitungUmur(peoples.tglLahir)
                                                        .toString() +
                                                    ' tahun',
                                                style: TextStyle(fontSize: 11),
                                              ),
                                              trailing: IconButton(
                                                icon: Icon(Icons.delete),
                                                color: Colors.red,
                                                onPressed: () {
                                                  print('hapus data ' +
                                                      peoples.idpeople
                                                          .toString());
                                                  showConfirm(
                                                      context,
                                                      'Apakah yakin menghapus ' +
                                                          peoples.nama +
                                                          ' ?',
                                                      peoples.idpeople
                                                          .toString());
                                                },
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 1,
                                            color: Colors.grey,
                                          )
                                        ],
                                      ));
                                }),
                          )
                        : Expanded(
                            child: ListView(children: [
                              Center(
                                heightFactor: 2,
                                child: Container(
                                  // color: Colors.blue[100],
                                  height: 100,
                                  child: Text(
                                    'Data Kosong',
                                    style: GoogleFonts.lobster(
                                        textStyle: TextStyle(
                                            fontSize: 24, color: Colors.grey)),
                                  ),
                                ),
                              )
                            ]),
                          ),
                  ],
                ),
          floatingActionButton: FloatingActionButton(
            elevation: 10,
            onPressed: () {
              Navigator.of(context)
                  .push(
                new MaterialPageRoute<String>(
                    builder: (context) =>
                        new BirthdayInputPage(People.clear(), modeNew)),
              )
                  .then((String val) {
                setState(() {
                  print('ambil data lagi');
                  ambilData();
                });
              });
            },
            backgroundColor: Colors.blue[700],
            child: Icon(
              Icons.note_add,
              size: 35,
            ),
          ),
        ));
  }
}
