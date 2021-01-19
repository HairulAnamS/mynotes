import 'dart:ui';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/people.dart';
import 'package:intl/intl.dart';
import 'package:project1/birthdayInput_page.dart';
import 'package:project1/constant.dart';

class BirthDayPage extends StatefulWidget {
  @override
  _BirthDayPageState createState() => _BirthDayPageState();
}

class _BirthDayPageState extends State<BirthDayPage> {
  bool isLoading = true;
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

  @override
  void initState() {
    people = new People();
    peopleDB = new PeopleDB();
    isLoading = true;

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
              leading: Icon(Icons.cake),
              title: Text(
                'Birthday',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.blue[700]),
          body: (isLoading)
              ? Center(child: CircularProgressIndicator())
              // : Container(
              //     color: Colors.red,
              //     height: 100,
              //   ),
              : Column(
                  children: [
                    Container(
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
                                // if (bulan != null) {
                                //   selectedKota = null;
                                // }
                                // getDataKota();
                              });
                            }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 10),
                      child: TextField(
                        onChanged: (value) {},
                        controller: controlNama,
                        keyboardType: TextInputType.text,
                        style: TextStyle(height: 0.5),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.blue[700]),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.blue[700]),
                          ),

                          hintText: "Input Nama",
                          // labelText: "Pekerjaan",
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          // shrinkWrap: true,
                          // physics: ScrollPhysics(),
                          itemCount: peopleList.length,
                          itemBuilder: (_, index) {
                            final peoples = peopleList[index];

                            return Container(
                                child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.redAccent,
                                    backgroundImage: (peoples.urlPhoto == "" ||
                                            peoples.urlPhoto == null)
                                        ? AssetImage("img/noImage.jpg")
                                        : NetworkImage(peoples.urlPhoto),
                                  ),
                                  title: Text(
                                    peoples.nama,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  subtitle: Text(
                                    DateFormat('dd MMM yyyy')
                                        .format(peoples.tglLahir),
                                    style: TextStyle(fontSize: 11),
                                  ),
                                  trailing: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                                Container(
                                  height: 1,
                                  color: Colors.grey[300],
                                )
                              ],
                            ));
                          }),
                    ),
                  ],
                ),
          floatingActionButton: FloatingActionButton(
            elevation: 10,
            onPressed: () {
              Navigator.of(context)
                  .push(
                new MaterialPageRoute<String>(
                    builder: (context) => new BirthdayInputPage(null, modeNew)),
              )
                  .then((String val) {
                setState(() {});
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
