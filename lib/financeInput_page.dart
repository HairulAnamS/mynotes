import 'package:flutter/material.dart';
import 'package:project1/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project1/finance.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:chips_choice/chips_choice.dart';

class FinanceInputPage extends StatefulWidget {
  final Finance aFinance;
  final int aMode;
  FinanceInputPage(this.aFinance, this.aMode);

  @override
  _FinanceInputPageState createState() => _FinanceInputPageState();
}

class _FinanceInputPageState extends State<FinanceInputPage> {
  TextEditingController controlSubjek = TextEditingController();
  TextEditingController controlNominal = TextEditingController();
  int fIdFinance;
  Finance finance;
  FinanceDB financeDB;
  DateTime fTglTrans;
  int fMode;
  bool fIsDebet;
  int fKategori;
  List<String> options = [
    'Kebutuhan',
    'Belanja',
    'Hiburan',
    'Service',
    'Belajar',
    'Jalan-jalan',
  ];

  @override
  void initState() {
    fTglTrans = DateTime.now();
    fMode = widget.aMode;
    fKategori = 0;
    fIsDebet = true;

    finance = widget.aFinance;
    financeDB = new FinanceDB();
    show(finance);

    getFinanceID();
    print('idFinance init: $fIdFinance');
    super.initState();
  }

  @override
  void dispose() {
    controlSubjek.dispose();
    controlNominal.dispose();
    super.dispose();
  }

  void getFinanceID() async {
    fIdFinance = await financeDB.getMaxID();
  }

  void show(Finance finance) {
    controlSubjek.text = finance.subjek;
    controlNominal.text = finance.nominal.toString();
    fKategori = 0; // testing bro
    fIsDebet = (finance.isDebet) ? true : false;
    fTglTrans = finance.tglTrans;
  }

  void loadData() {
    if (fMode == modeNew) {
      finance.idFinance = fIdFinance;
      finance.tglCreate = DateTime.now();
    }
    finance.nominal = int.parse(controlNominal.text);
    finance.subjek = controlSubjek.text;
    finance.kategori = ''; // Testing bro
    finance.tglTrans = fTglTrans;
    finance.bulanTrans = getBulan(finance.tglTrans);
  }

  Future<void> doSave(BuildContext context) async {
    try {
      //if (_checkValidate()) {
      loadData();
      if (fMode == modeNew) {
        financeDB.insert(finance);
      } else {
        financeDB.update(finance);
      }
      // } else {
      //   errMsg = "Nama harus diisi";
      //   print(errMsg);
      //   // showAlert(context, errMsg);
      // }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: warna,
          leading: Icon(Icons.arrow_back_ios, color: Colors.white),
          title: Text(
            'Input Transaction',
            style: GoogleFonts.play(
                textStyle: TextStyle(fontSize: 20, color: Colors.white)),
          ),
        ),
        body: Center(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          fIsDebet = true;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          color: (fIsDebet) ? Colors.green : Colors.grey[300],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.trending_up,
                              size: 26,
                            ),
                            Text(
                              'Income',
                              style: GoogleFonts.play(
                                  textStyle:
                                      TextStyle(fontSize: 20, color: warna)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          fIsDebet = false;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          color: (fIsDebet) ? Colors.grey[300] : Colors.red,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.trending_down,
                              size: 26,
                            ),
                            Text(
                              'Outcome',
                              style: GoogleFonts.play(
                                  textStyle:
                                      TextStyle(fontSize: 20, color: warna)),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 15, 20, 5),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: warna, blurRadius: 8, offset: Offset(2, 2))
                    ]),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: ChipsChoice<int>.single(
                        //wrapped: true,
                        value: fKategori,
                        onChanged: (val) => setState(() => fKategori = val),
                        choiceItems: C2Choice.listFrom<int, String>(
                          source: options,
                          value: (i, v) => i,
                          label: (i, v) => v,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: TextField(
                        onChanged: (value) {
                          if (fIdFinance == null) {
                            getFinanceID();
                            print('idfinance change: $fIdFinance');
                          } else {
                            print('idfinance change wes: $fIdFinance');
                          }
                        },
                        controller: controlSubjek,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Subjek",
                          icon: Icon(Icons.perm_identity),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: TextField(
                        onChanged: (value) {
                          //
                        },
                        controller: controlNominal,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Nominal",
                          icon: Icon(Icons.monetization_on_outlined),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: DateTimePicker(
                        icon: Icon(Icons.date_range),
                        dateMask: 'd MMM, yyyy',
                        initialValue: fTglTrans.toString(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2050),
                        dateLabelText: 'Tanggal Transaksi',
                        onChanged: (val) {
                          setState(() {
                            fTglTrans = new DateFormat("yyyy-MM-dd").parse(val);
                            getBulan(fTglTrans);
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
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 40, 20, 0),
                          child: Container(
                            width: 100,
                            child: RaisedButton(
                              onPressed: () {
                                doSave(context);
                                Navigator.pop(context);
                              },
                              color: warna,
                              child: Text(
                                'S A V E',
                                style: GoogleFonts.play(
                                    textStyle: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                              ),
                            ),
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
