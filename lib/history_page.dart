import 'package:flutter/material.dart';
import 'package:project1/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Container(
              padding: EdgeInsets.all(5),
              height: 70,
              color: Colors.transparent,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 27,
                  backgroundColor: warna,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage("img/heru_logo.jpg"),
                  ),
                ),
                title: Text(
                  'Hairul Anam S',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )),
        Container(
          height: 1,
          color: warna,
          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Container(
            height: 160,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: warna,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 15, 8, 5),
                  child: Text(
                    'Saldo',
                    style: GoogleFonts.play(
                        textStyle:
                            TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 25),
                  child: Text(
                    'Rp. 100.000.000',
                    style: GoogleFonts.play(
                        textStyle:
                            TextStyle(fontSize: 24, color: Colors.white)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
                          child: Text(
                            'Income',
                            style: GoogleFonts.play(
                                textStyle: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                          child: Text(
                            'Rp. 10.000.000',
                            style: GoogleFonts.play(
                                textStyle: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
                          child: Text(
                            'Outcome',
                            style: GoogleFonts.play(
                                textStyle: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                          child: Text(
                            'Rp. 5.000.000',
                            style: GoogleFonts.play(
                                textStyle: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(itemBuilder: null)
        )
      ],
    );
  }
}
