import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project1/database_services.dart';
import 'package:project1/catatanInput_page.dart';
import 'package:project1/constant.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
// import 'package:intl/intl.dart';

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
              'Catatan',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.blue[700]),
        body: FutureBuilder(
            future: DatabaseServices.getDocument(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                return LiquidPullToRefresh(
                  onRefresh: refreshData,
                  backgroundColor: Colors.green,
                  springAnimationDurationInMilliseconds: 750,
                  color: Colors.blue[100],
                  // showChildOpacityTransition: true,
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      final notes = snapshot.data[index];

                      return Dismissible(
                        key: Key(notes.data["catatan"]),
                        onDismissed: (direction) {
                          return showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text(
                                "Konfirmasi",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              content: Text(
                                "Apakah yakin ingin menghapus data ini ?",
                                style: TextStyle(fontSize: 14),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  color: warna,
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                    if (this.mounted) {
                                      setState(() {
                                        print(notes.documentID);
                                        DatabaseServices.deleteNote(
                                            notes.documentID);
                                        snapshot.data.removeAt(index);
                                      });
                                    }
                                  },
                                  child: Text("YA",
                                      style: TextStyle(fontSize: 14)),
                                ),
                                FlatButton(
                                  color: warna,
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Text(
                                    "TIDAK",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
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
                                color: Colors.blue[100],
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
                                // Expanded(
                                //   flex: 1,
                                //   child: Text(
                                //     snapshot.data[index].data["catatan"],
                                //     style: TextStyle(
                                //       fontSize: 14,
                                //     ),
                                //     //maxLines: 1,
                                //   ),
                                // ),
                                ListTile(
                                  leading: Icon(
                                    Icons.list_alt_outlined,
                                    size: 40,
                                  ),
                                  title: Text(
                                    snapshot.data[index].data["catatan"],
                                    maxLines: 2,
                                    style: TextStyle(fontSize: 14),
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
                                    style: TextStyle(fontSize: 12),
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
