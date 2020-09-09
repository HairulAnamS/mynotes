import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/constant.dart';
import 'package:project1/database_services.dart';
import 'package:date_format/date_format.dart';

class CatatanInputPage extends StatefulWidget {
  final DocumentSnapshot note;
  final int fMode;
  CatatanInputPage(this.note, this.fMode);

  @override
  _CatatanInputPageState createState() => _CatatanInputPageState();
}

class _CatatanInputPageState extends State<CatatanInputPage> {
  TextEditingController controller_note;
  int id;

  void getID() async {
    id = await DatabaseServices.getMaxIDBaru();
  }

  @override
  void initState() {
    super.initState();
    getID();
    print(id);
    controller_note = TextEditingController(
        text: (widget?.note?.data?.toString() == null)
            ? ''
            : widget.note.data["catatan"].toString());
    // print(widget.note.documentID);
    // print(widget.note.data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Detail",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView(
          //padding: EdgeInsets.all(0),
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  (widget?.note?.data == null)
                      ? Container()
                      : Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            (widget?.note?.data == null)
                                ? ' '
                                : widget.note.data["tanggal"],
                          )),
                  Container(
                    margin: EdgeInsets.all(10),
                    //color: Colors.white,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          print(id);
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      controller: controller_note,
                      maxLines: null,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FlatButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Colors.redAccent,
                        icon: Icon(Icons.cancel),
                        label: Text('Cancel'),
                        textColor: Colors.white,
                      ),
                      FlatButton.icon(
                        onPressed: () {
                          if (widget.fMode == modeNew) {
                            getID();
                            print(id);

                            DatabaseServices.createNote(id.toString(),
                                idNote: id,
                                note: controller_note.text,
                                date: formatDate(DateTime.now(),
                                    [dd, ' ', MM, ' ', yyyy, ' ', H, ':', nn]));
                          } else if (widget.fMode == modeEdit) {
                            DatabaseServices.createNote(widget.note.documentID,
                                idNote: int.parse(widget.note.documentID),
                                note: controller_note.text,
                                date: formatDate(DateTime.now(),
                                    [dd, ' ', MM, ' ', yyyy, ' ', H, ':', nn])
                                    );
                          }

                          Navigator.pop(context);
                          // Navigator.of(context).pop('String');
                          // print('OKAY');
                        },
                        color: Colors.green,
                        icon: Icon(Icons.check_circle),
                        label: Text('  Save  '),
                        textColor: Colors.white,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
