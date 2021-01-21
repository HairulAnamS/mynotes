import 'dart:io';
import 'package:path/path.dart' as _path;
import 'package:flutter/material.dart';
import 'package:project1/people.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project1/loading.dart';

class BirthdayInputPage extends StatefulWidget {
  // final People people;
  final int fMode;
  BirthdayInputPage(this.fMode);

  @override
  _BirthdayInputPageState createState() => _BirthdayInputPageState();
}

class _BirthdayInputPageState extends State<BirthdayInputPage> {
  TextEditingController controlNama = TextEditingController();
  final GlobalKey<State> keyLoader = new GlobalKey<State>();

  String urlImage;
  bool validateNama;
  int genderValue = 0;
  DateTime fTglLahir;
  String errMsg;

  int fIdPeople;
  People people;
  PeopleDB peopleDB;

  File fImage;
  String fNamaImage;
  bool isLoading;

  @override
  void initState() {
    super.initState();
    validateNama = true;
    urlImage = "";
    fTglLahir = DateTime.now();
    isLoading = false;

    people = new People();
    peopleDB = new PeopleDB();

    getPeopleID();
    print('idpeople init: $fIdPeople');

    // people = widget.people;

    // controlNama.text = people.nama;
    // if (people.urlPhoto != "") urlImage = people.urlPhoto;

    // _getUser();
  }

  @override
  void dispose() {
    controlNama.dispose();
    super.dispose();
  }

  Future getImage() async {
    File image;
    image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (image != null) {
        fImage = image;
        fNamaImage = _path.basename(image.path);
        print(fNamaImage);
      }
    });

    if (fImage != null) {
      // Dialogs.showLoadingDialog(context, keyLoader);
      uploadImage();
      // Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
    }
  }

  Future<String> uploadImage() async {
    StorageReference ref = FirebaseStorage.instance.ref().child(fNamaImage);
    StorageUploadTask uploadtTask = ref.putFile(fImage);

    var urlDownl = await (await uploadtTask.onComplete).ref.getDownloadURL();
    setState(() {
      urlImage = urlDownl.toString();
    });

    print('Url Gambar : $urlImage');
    return urlImage;
  }

  void getPeopleID() async {
    fIdPeople = await peopleDB.getMaxID();
  }

  void handleRadioValueChange(int value) {
    setState(() {
      genderValue = value;
      switch (genderValue) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
      }
    });
  }

  loadData() {
    people.idpeople = fIdPeople;
    people.nama = controlNama.text;
    people.jenisKelamin = (genderValue == 0) ? "L" : "P";
    people.urlPhoto = urlImage;
    people.tglLahir = fTglLahir;
    people.tglCreate = DateTime.now();
  }

  Future<void> insertPeople(BuildContext context) async {
    try {
      if (_checkValidate()) {
        loadData();
        peopleDB.insert(people);
      } else {
        errMsg = "Nama harus diisi";
        print(errMsg);
        // showAlert(context, errMsg);
      }
    } catch (e) {
      print(e);
    }
  }

  bool _checkValidate() {
    validateNama = true;
    bool result = true;

    setState(() {
      if (controlNama.text.trim() == "") {
        validateNama = false;
        result = false;
      }
      print('idpeople validate: $fIdPeople');
    });
    return result;
  }

  Future<void> showAlert(BuildContext context, String aMessage) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: Text(''),
          content: Text(aMessage),
          actions: <Widget>[
            FlatButton(
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Input Data',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.blue[700]),
        body: Container(
            child: ListView(
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 70,
                      backgroundImage: (urlImage == "")
                          ? AssetImage("img/noImage.jpg")
                          : NetworkImage(urlImage),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 200,
                  child: GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.blue[700],
                        child: Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                        )),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: TextField(
                onChanged: (value) {
                  if (fIdPeople == null) {
                    getPeopleID();
                    print('idpeople change: $fIdPeople');
                  } else {
                    print('idpeople change wes: $fIdPeople');
                  }
                },
                controller: controlNama,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: "Nama Lengkap",
                    icon: Icon(Icons.perm_identity),
                    errorText: (validateNama) ? null : 'Nama harus diisi'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                children: [
                  Text(
                    'Jenis Kelamin :',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Radio(
                      value: 0,
                      groupValue: genderValue,
                      onChanged: handleRadioValueChange),
                  Text('Laki-laki'),
                  Radio(
                      value: 1,
                      groupValue: genderValue,
                      onChanged: handleRadioValueChange),
                  Text('Perempuan'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: DateTimePicker(
                icon: Icon(Icons.date_range),
                dateMask: 'd MMM, yyyy',
                initialValue: fTglLahir.toString(),
                firstDate: DateTime(1950),
                lastDate: DateTime(2050),
                dateLabelText: 'Tanggal Lahir',
                onChanged: (val) {
                  setState(() {
                    fTglLahir = new DateFormat("yyyy-MM-dd").parse(val);
                    print(val);
                  });
                },
                validator: (val) {
                  print(val);
                  return null;
                },
                onSaved: (val) => print(val),
              ),
            ),
            SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Container(
                // color: Colors.blue[700],
                width: MediaQuery.of(context).size.width,
                child: RaisedButton.icon(
                    color: Colors.blue[700],
                    icon: Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                    label: Text(
                      'S A V E',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      insertPeople(context);
                      Navigator.pop(context);
                    }),
              ),
            )
          ],
        )),
      ),
    );
  }
}
