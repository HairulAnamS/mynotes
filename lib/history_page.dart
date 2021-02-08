import 'package:flutter/material.dart';
import 'package:project1/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project1/finance.dart';
import 'package:intl/intl.dart';
import 'package:project1/financeInput_page.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool isLoading;
  Finance finance;
  FinanceDB financeDB;
  List<Finance> financeList = [];

  @override
  void initState() {
    isLoading = true;
    finance = new Finance();
    financeDB = new FinanceDB();
    ambilData();

    super.initState();
  }

  void ambilData() async {
    print('start ambil data');
    financeList = await financeDB.getFinance();
    print('start selesai data');
    setState(() {
      isLoading = false;
    });
  }

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
                title: Text('Hairul Anam S',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, color: warna)),
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
        Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transactions',
                style: GoogleFonts.play(
                    textStyle: TextStyle(fontSize: 20, color: warna)),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(
                    new MaterialPageRoute<String>(
                        builder: (context) =>
                            new FinanceInputPage(Finance.clear(), modeNew)),
                  )
                      .then((String val) {
                    setState(() {
                      print('ambil data lagi');
                      ambilData();
                    });
                  });
                },
                child: Container(
                    color: warna,
                    padding: EdgeInsets.all(7),
                    height: 30,
                    width: 40,
                    child: Text(
                      '+',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    )),
              )
            ],
          ),
        ),
        (isLoading)
            ? Center(child: CircularProgressIndicator())
            : Expanded(
                child: ListView.builder(
                    itemCount: financeList.length,
                    itemBuilder: (_, index) {
                      final finances = financeList[index];
                      return Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 5, 5),
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                        height: 72,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: warna,
                                  blurRadius: 8,
                                  offset: Offset(2, 2))
                            ]),
                        child: ListTile(
                          leading: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: warna,
                            ),
                            child: Icon(
                                (finances.isDebet)
                                    ? Icons.trending_up
                                    : Icons.trending_down,
                                color: (finances.isDebet)
                                    ? Colors.green
                                    : Colors.red),
                          ),
                          title: Text(
                            formatter.format(finances.nominal),
                            style: GoogleFonts.play(
                                textStyle:
                                    TextStyle(fontSize: 18, color: warna)),
                          ),
                          subtitle: Text(
                            finances.subjek,
                            style: GoogleFonts.play(
                                textStyle:
                                    TextStyle(fontSize: 16, color: warna)),
                          ),
                          trailing: Text(
                            DateFormat('dd MMM yyyy').format(finances.tglTrans),
                            style: GoogleFonts.play(
                                textStyle:
                                    TextStyle(fontSize: 14, color: warna)),
                          ),
                        ),
                      );
                    }))
      ],
    );
  }
}
