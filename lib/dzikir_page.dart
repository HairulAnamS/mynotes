import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DzikirPage extends StatefulWidget {
  @override
  _DzikirPageState createState() => _DzikirPageState();
}

class _DzikirPageState extends State<DzikirPage> {
  int _counter = 0;

  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0);
    });
  }

  _incCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = _counter + 1;
      prefs.setInt('counter', _counter);
    });
  }

  _refresh() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = 0;
      prefs.setInt('counter', _counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("img/white-black.jpg"), fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            // appBar: AppBar(
            //   backgroundColor: Colors.lightBlue[100],
            //   leading: IconButton(
            //     icon: Icon(Icons.arrow_back_ios),
            //     onPressed: () {
            //       Navigator.pop(context);
            //     },
            //   ),
            //   title: Text(
            //     "Berdzikir",
            //     style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
            //   ),
            // ),
            body: Center(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 120),
                  Text(
                    _counter.toString(),
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.w900),
                  ),
                  Container(
                    color: Colors.black,
                    height: 2,
                    width: 120,
                  ),
                  SizedBox(height: 150),
                  Ink(
                    //padding: EdgeInsets.all(20),
                    decoration: const ShapeDecoration(
                      color: Colors.blue,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.add),
                      iconSize: 80,
                      color: Colors.white,
                      onPressed: () {
                        //Hitung();
                        _incCounter();
                      },
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _refresh();
              },
              backgroundColor: Colors.green,
              mini: false,
              // tooltip: 'Increment',
              child: Icon(Icons.refresh),
            ),
          ),
        ));
  }
}
