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
              gradient: LinearGradient(
            colors: [Colors.lightBlue, Colors.white, Colors.lightGreen[300]],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              // image: DecorationImage(
              //     image: AssetImage("img/white-black.jpg"), fit: BoxFit.cover)
              ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
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
                    decoration: const ShapeDecoration(
                      color: Colors.blue,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.add),
                      iconSize: 80,
                      color: Colors.white,
                      onPressed: () {
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
              child: Icon(Icons.refresh),
            ),
          ),
        ));
  }
}
