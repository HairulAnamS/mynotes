import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:google_fonts/google_fonts.dart';
import 'package:project1/constant.dart';
import 'package:project1/finance.dart';
import 'package:intl/intl.dart';

class GrafikPage extends StatefulWidget {
  @override
  _GrafikPageState createState() => _GrafikPageState();
}

class _GrafikPageState extends State<GrafikPage> {
  bool isLoading;
  Finance finance;
  FinanceDB financeDB;
  List<Finance> financeList = [];
  DateTime tglSkrg, tglAwal, tglAkhir;
  List<int> income = [];
  List<int>  outcome = [];
  String bln0, bln1, bln2;

  List<charts.Series> seriesList;
  List<charts.Series<Graph, String>> _createData() {
    //final random = Random();
    var incomeData = [
      // Graph(bln0, 110),
      // Graph(bln1, 250),
      // Graph(bln2, 300),

      Graph(bln0, income[0]),
      Graph(bln1, income[1]),
      Graph(bln2, income[2]),
    ];

    var outcomeData = [
      Graph(bln0, outcome[0]),
      Graph(bln1, outcome[1]),
      Graph(bln2, outcome[2]),

      // Graph(bln0, 57),
      // Graph(bln1, 99),
      // Graph(bln2, 120),
    ];

    return [
      charts.Series<Graph, String>(
          data: incomeData,
          id: 'Graph',
          domainFn: (Graph graph, _) => graph.bulan,
          measureFn: (Graph graph, _) => graph.nominal,
          fillColorFn: (Graph graph, _) =>
              charts.MaterialPalette.green.shadeDefault,
          labelAccessorFn: (Graph graph, _) => graph.nominal.toString()),
      charts.Series<Graph, String>(
          data: outcomeData,
          id: 'Graph',
          domainFn: (Graph graph, _) => graph.bulan,
          measureFn: (Graph graph, _) => graph.nominal,
          fillColorFn: (Graph graph, _) =>
              charts.MaterialPalette.red.shadeDefault,
          labelAccessorFn: (Graph graph, _) => graph.nominal.toString())
    ];
  }

  barChart() {
    return charts.BarChart(
      seriesList,
      animate: true,
      vertical: true,
      //barRendererDecorator: charts.BarLabelDecorator<String>(),
    );
  }

  @override
  void initState() {
    super.initState();
    
    isLoading = true;
    finance = new Finance();
    financeDB = new FinanceDB();
    tglSkrg = DateTime.now();
    tglAwal = DateTime(tglSkrg.year, tglSkrg.month - 2, 1);
    tglAkhir = DateTime(tglSkrg.year, tglSkrg.month + 1, 0);

    bln2 = getBulan(tglSkrg);
    bln1 = getBulan(DateTime(tglSkrg.year, tglSkrg.month - 1, 1));
    bln0 = getBulan(DateTime(tglSkrg.year, tglSkrg.month - 2, 1));

    ambilData();
  }

  void ambilData() async {
    print('start ambil data');
    financeList = await financeDB.getFinanceFilter(tglAwal, tglAkhir);
    getCome(financeList);
    seriesList = _createData();
    print('start selesai data');
    setState(() {
      isLoading = false;
    });
  }

  void getCome(List<Finance> finances) {
    income = [0, 0, 0];
    outcome = [0, 0, 0];

    for (int i = 0; i < finances.length; i++) {
      if (finances[i].bulanTrans == bln0) {
        if (finances[i].isDebet) {
          income[0] = income[0] + finances[i].nominal;
        } else {
          outcome[0] = outcome[0] + finances[i].nominal;
        }
      } 
      else if (finances[i].bulanTrans == bln1) {
        if (finances[i].isDebet) {
          income[1] = income[1] + finances[i].nominal;
        } else {
          outcome[1] = outcome[1] + finances[i].nominal;
        }
      } 
      else if (finances[i].bulanTrans == bln2){
        if (finances[i].isDebet) {
          income[2] = income[2] + finances[i].nominal;
        } else {
          outcome[2] = outcome[2] + finances[i].nominal;
        }
      }
    }

    print(' income: $income, outcome: $outcome');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Data Income dan Outcome',
            style: GoogleFonts.play(
                textStyle: TextStyle(fontSize: 20, color: Colors.white))),
        backgroundColor: warna,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.73,
          child: (isLoading)
              ? Center(child: CircularProgressIndicator())
              : barChart(),
        ),
      ),
    );
  }
}

class Graph {
  final String bulan;
  final int nominal;

  Graph(this.bulan, this.nominal);
}
