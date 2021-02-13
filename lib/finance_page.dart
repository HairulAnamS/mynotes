import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:project1/constant.dart';
import 'package:project1/history_page.dart';
import 'package:project1/grafik_page.dart';

class FinancePage extends StatefulWidget {
  @override
  _FinancePageState createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  int selectedPos = 0;
  double bottomNavBarHeight = 60;
  CircularBottomNavigationController _navigationController;
  // Color warna = const Color.fromARGB(255, 0, 0, 51);

  List<TabItem> tabItems = List.of([
    new TabItem(Icons.history, "History", Colors.white,
        labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
    new TabItem(Icons.stacked_line_chart, "Graphic", Colors.white,
        labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
  ]);

  @override
  void initState() {
    super.initState();
    _navigationController = new CircularBottomNavigationController(selectedPos);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(1),
                  child: _getTab(selectedPos),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CircularBottomNavigation(
                    tabItems,
                    controller: _navigationController,
                    barHeight: bottomNavBarHeight,
                    barBackgroundColor: warna,
                    selectedIconColor: Colors.orange,
                    animationDuration: Duration(milliseconds: 300),
                    selectedCallback: (int selectedPos) {
                      setState(() {
                        this.selectedPos = selectedPos;
                        print(_navigationController.value);
                        print('pos: ' + selectedPos.toString());
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

Widget _getTab(int idx) {
  if (idx == 0) {
    return HistoryPage();
  } else {
    return GrafikPage();
  } 
}
