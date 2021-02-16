import 'package:flutter/material.dart';
import 'package:project1/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project1/finance.dart';
import 'package:intl/intl.dart';
import 'package:project1/financeInput_page.dart';
import 'package:date_time_picker/date_time_picker.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool isLoading;
  bool isDelete;
  Finance finance;
  FinanceDB financeDB;
  List<Finance> financeList = [];
  int saldo, income, outcome;
  DateTime tglSkrg, tglAwal, tglAkhir;

  @override
  void initState() {
    isLoading = true;
    isDelete = false;
    finance = new Finance();
    financeDB = new FinanceDB();
    saldo = 0;
    income = 0;
    outcome = 0;
    tglSkrg = DateTime.now();
    tglAwal = DateTime(tglSkrg.year, tglSkrg.month, 1);
    tglAkhir = DateTime(tglSkrg.year, tglSkrg.month + 1, 0);
    ambilData(false);

    super.initState();
  }

  void ambilData(bool isUseFilter) async {
    print('start ambil data');
    if (isUseFilter) {
      financeList = await financeDB.getFinanceFilter(tglAwal, tglAkhir);
    } else {
      financeList = await financeDB.getFinance(getBulan(DateTime.now()));
    }
    saldo = await financeDB.getSaldo();
    getCome(financeList);
    print('start selesai data');
    setState(() {
      isLoading = false;
    });
  }

  void getCome(List<Finance> finances) {
    //saldo = 0;
    income = 0;
    outcome = 0;
    for (int i = 0; i < finances.length; i++) {
      if (finances[i].isDebet) {
        //saldo = saldo + finances[i].nominal;
        income = income + finances[i].nominal;
      } else {
        //saldo = saldo - finances[i].nominal;
        outcome = outcome + finances[i].nominal;
      }
    }

    print('saldo: $saldo , income: $income, outcome: $outcome');
  }

  // Future<void> showConfirm(
  //     BuildContext context, String aMssg, String aIdFinance) {
  //   Widget yesButton = FlatButton(
  //     color: Colors.blue,
  //     child: Text("Ya"),
  //     onPressed: () {
  //       isDelete = true;
  //       financeDB.delete(aIdFinance);
  //       Navigator.of(context).pop();
  //       if (this.mounted) {
  //         setState(() {
  //           print('ambil data lagi');
  //           ambilData();
  //         });
  //       }
  //     },
  //   );

  //   Widget noButton = FlatButton(
  //     color: Colors.red,
  //     child: Text("Tidak"),
  //     onPressed: () {
  //       isDelete = false;
  //       Navigator.of(context).pop();
  //       // Navigator.push(
  //       //   context,
  //       //   MaterialPageRoute(builder: (context) => FinancePage()),
  //       // );
  //     },
  //   );

  //   return showDialog<void>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(
  //           'Konfirmasi',
  //           style: TextStyle(fontWeight: FontWeight.bold),
  //         ),
  //         content: Text(aMssg),
  //         actions: <Widget>[yesButton, noButton],
  //       );
  //     },
  //   );
  // }

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
                    formatter.format(saldo),
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
                            formatter.format(income),
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
                            formatter.format(outcome),
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
          padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Transactions',
                style: GoogleFonts.play(
                    textStyle: TextStyle(fontSize: 20, color: warna)),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  return showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text(
                        "Filter",
                        style: GoogleFonts.play(
                            textStyle: TextStyle(
                                fontSize: 20,
                                color: warna,
                                fontWeight: FontWeight.bold)),
                      ),
                      content: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: DateTimePicker(
                                icon: Icon(Icons.date_range),
                                dateMask: 'd MMM, yyyy',
                                initialValue: tglAwal.toString(),
                                firstDate: DateTime(2010),
                                lastDate: DateTime(2050),
                                dateLabelText: 'Tanggal Awal',
                                onChanged: (val) {
                                  setState(() {
                                    tglAwal =
                                        new DateFormat("yyyy-MM-dd").parse(val);
                                    //getBulan(tglAwal);
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
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: DateTimePicker(
                                icon: Icon(Icons.date_range),
                                dateMask: 'd MMM, yyyy',
                                initialValue: tglAkhir.toString(),
                                firstDate: DateTime(2010),
                                lastDate: DateTime(2050),
                                dateLabelText: 'Tanggal Akhir',
                                onChanged: (val) {
                                  setState(() {
                                    tglAkhir =
                                        new DateFormat("yyyy-MM-dd").parse(val);
                                    //getBulan(tglAkhir);
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
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          color: warna,
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            if (this.mounted) {
                              setState(() {
                                print('refresh data habis filter');
                                ambilData(true);
                              });
                            }
                          },
                          child: Text(
                            "OK",
                            style: GoogleFonts.play(
                                textStyle: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                          ),
                        )
                      ],
                    ),
                  );
                },
                child: Container(
                    padding: EdgeInsets.all(7),
                    height: 30,
                    width: 40,
                    decoration: BoxDecoration(
                        color: warna, borderRadius: BorderRadius.circular(5)),
                    child: Icon(
                      Icons.search,
                      size: 14,
                      color: Colors.white,
                    )),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) =>
                  //           FinanceInputPage(Finance.clear(), modeNew)),
                  // );

                  Navigator.of(context)
                      .push(
                    new MaterialPageRoute<String>(
                        builder: (context) =>
                            new FinanceInputPage(Finance.clear(), modeNew)),
                  )
                      .then((String val) {
                    setState(() {
                      print('ambil data lagi habis save');
                      ambilData(false);
                    });
                  });
                },
                child: Container(
                    padding: EdgeInsets.all(7),
                    height: 30,
                    width: 40,
                    decoration: BoxDecoration(
                        color: warna, borderRadius: BorderRadius.circular(5)),
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
            ? Center(heightFactor: 5, child: CircularProgressIndicator())
            : Container(
                height: MediaQuery.of(context).size.height * 0.47,
                child: (financeList.length > 0)
                    ? ListView.builder(
                        itemCount: financeList.length,
                        itemBuilder: (_, index) {
                          final finances = financeList[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(
                                new MaterialPageRoute<String>(
                                    builder: (context) => new FinanceInputPage(
                                        finances, modeEdit)),
                              )
                                  .then((String val) {
                                setState(() {
                                  print('ambil data lagi habis edit');
                                  ambilData(false);
                                });
                              });
                            },
                            onLongPress: () {
                              return showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: Text(
                                    "Konfirmasi",
                                    style: GoogleFonts.play(
                                        textStyle: TextStyle(
                                            fontSize: 20,
                                            color: warna,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  content: Text(
                                    "Apakah yakin ingin menghapus subjek " +
                                        finances.subjek +
                                        ' ?',
                                    style: GoogleFonts.play(
                                        textStyle: TextStyle(
                                      fontSize: 16,
                                      color: warna,
                                    )),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      color: warna,
                                      onPressed: () {
                                        isDelete = true;
                                        financeDB.delete(
                                            finances.idFinance.toString());
                                        Navigator.of(ctx).pop();
                                        if (this.mounted) {
                                          setState(() {
                                            print('refresh data habis hapus');
                                            ambilData(false);
                                          });
                                        }
                                      },
                                      child: Text(
                                        "YA",
                                        style: GoogleFonts.play(
                                            textStyle: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white)),
                                      ),
                                    ),
                                    FlatButton(
                                      color: warna,
                                      onPressed: () {
                                        isDelete = false;
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Text(
                                        "TIDAK",
                                        style: GoogleFonts.play(
                                            textStyle: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white)),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Container(
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
                                      textStyle: TextStyle(
                                          fontSize: 18, color: warna)),
                                ),
                                subtitle: Text(
                                  finances.subjek,
                                  style: GoogleFonts.play(
                                      textStyle: TextStyle(
                                          fontSize: 16, color: warna)),
                                ),
                                trailing: Text(
                                  DateFormat('dd MMM yyyy')
                                      .format(finances.tglTrans),
                                  style: GoogleFonts.play(
                                      textStyle: TextStyle(
                                          fontSize: 14, color: warna)),
                                ),
                              ),
                            ),
                          );
                        })
                    : Center(
                        child: Text(
                          'Empty Transactions...',
                          style: GoogleFonts.play(
                              textStyle: TextStyle(fontSize: 24, color: warna)),
                        ),
                      ))
      ],
    );
  }
}
