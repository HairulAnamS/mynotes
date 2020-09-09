import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/database_services.dart';
import 'package:project1/catatanInput_page.dart';
import 'package:project1/constant.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class CatatanPage extends StatefulWidget {
  @override
  _CatatanPageState createState() => _CatatanPageState();
}

class _CatatanPageState extends State<CatatanPage> {
  Future _data;
  DocumentSnapshot note;

  String catatan, tanggal;
  // final String data;
  // _CatatanPageState(this.data);
  //_CatatanPageState({@required this.catatan, @required this.tanggal, @required this.note});

  // _getRequests() async {
  //   _data = DatabaseServices.getDocument();
  // }

  @override
  void initState() {
    super.initState();
    //_getRequests();
    _data = DatabaseServices.getDocument();
  }

  Future refreshData() async {
    DatabaseServices.getDocument();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // print(data);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            leading: Icon(Icons.library_books),
            title: Text(
              'Catatan-Ku',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.green),
        body: FutureBuilder(
            future: DatabaseServices.getDocument(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                return LiquidPullToRefresh(
                  onRefresh: refreshData,
                  backgroundColor: Colors.orangeAccent,
                  springAnimationDurationInMilliseconds: 750,
                  color: Colors.green[200],
                  // showChildOpacityTransition: true,
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      final notes = snapshot.data[index];

                      return Dismissible(
                        key: Key(notes.data["catatan"]),
                        onDismissed: (direction) {
                          // Remove the item from the data source.
                          setState(() {
                            print(notes.documentID);
                            DatabaseServices.deleteNote(notes.documentID);
                            snapshot.data.removeAt(index);
                          });

                          // Then show a snackbar.
                          // Scaffold.of(context).showSnackBar(
                          //     SnackBar(content: Text("berhasil dihapus")));
                        },
                        // Show a red background as the item is swiped away.
                        //background: Container(color: Colors.red),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(
                              new MaterialPageRoute<String>(
                                  builder: (context) => new CatatanInputPage(
                                      snapshot.data[index], modeEdit)),
                            )
                                .then((String val) {
                              setState(() {});
                            });
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => CatatanInputPage(
                            //           snapshot.data[index], modeEdit)),
                            // );
                          },
                          child: Container(
                            //color: Colors.greenAccent,
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.all(10),
                            height: 100,
                            decoration: BoxDecoration(
                                color: Colors.green[200],
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      blurRadius: 5,
                                      offset: Offset(2, 2))
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    snapshot.data[index].data["catatan"],
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                    //maxLines: 1,
                                  ),
                                ),
                                Spacer(),
                                // SizedBox(
                                //   height: 20,
                                // ),
                                Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    snapshot.data[index].data["tanggal"]
                                        .toString()
                                        .substring(
                                            0,
                                            snapshot.data[index].data["tanggal"]
                                                    .toString()
                                                    .length -
                                                5),
                                    softWrap: false,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                      // return ListTile(
                      //   title: Text(snapshot.data[index].data["catatan"]),
                      // );
                    },
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
        floatingActionButton: FloatingActionButton(
          elevation: 10,
          onPressed: () {
            //DatabaseServices.getMaxIDBaru();
            Navigator.of(context)
                .push(
              new MaterialPageRoute<String>(
                  builder: (context) => new CatatanInputPage(note, modeNew)),
            )
                .then((String val) {
              setState(() {});
            });
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => CatatanInputPage(note, modeNew)),
            // );
            // DatabaseServices.createNote("1",
            //     note: "Testing ke 1",
            //     date: formatDate(DateTime.now(),
            //         [dd, ' ', MM, ' ', yyyy, ' ', hh, ':', nn]));
          },
          backgroundColor: Colors.green,
          child: Icon(
            Icons.note_add,
            size: 40,
          ),
        ),
      ),
    );
  }
}
