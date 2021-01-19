import 'package:flutter/material.dart';
import 'package:project1/people.dart';

class BirthdayInputPage extends StatefulWidget {
  final People people;
  final int fMode;
  BirthdayInputPage(this.people, this.fMode);

  @override
  _BirthdayInputPageState createState() => _BirthdayInputPageState();
}

class _BirthdayInputPageState extends State<BirthdayInputPage> {
  TextEditingController controlNama = TextEditingController();
  People people;
  String urlImage;
  bool validateNama;

  @override
  void initState() {
    super.initState();
    validateNama = true;

    people = widget.people;

    // controlNama.text = people.nama;
    // if (people.urlPhoto != "") urlImage = people.urlPhoto;

    // _getUser();
  }

  @override
  void dispose() {
    controlNama.dispose();
    super.dispose();
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
        body: Center(
          child: Container(
              child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: CircleAvatar(
                        radius: 70,
                        // backgroundImage: AssetImage("img/noprofile.png"),
                        backgroundImage:
                            //(urlImage == "")
                            AssetImage("img/noImage.jpg")
                        // : NetworkImage(urlImage),
                        ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 100,
                    child: GestureDetector(
                      onTap: () {
                        // getImage();
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
                  onChanged: (value) {},
                  controller: controlNama,
                  keyboardType: TextInputType.text,
                  // style: TextStyle(height: 0.5),
                  decoration: InputDecoration(
                      //filled: true,
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

                      //hintText: "Username",
                      labelText: "Nama",
                      errorText: (validateNama) ? null : 'Nama harus diisi'),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
