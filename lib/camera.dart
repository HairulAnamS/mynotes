import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path/path.dart' as _path;
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(CameraPage());

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  int idButtonCamera = 1;
  int idButtonGaleri = 2;
  int idButtonSave = 3;

  File _image;
  String _imagePath = '';
  String _nameImage = '';

  Future getImage(bool isCamera) async {
    File image;
    if (isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      if (image != null) {
        _image = image;
        _imagePath = image.path;
        _nameImage = splitPath(_imagePath);
      }
    });
  }

  String splitPath(String path) {
    String result;
    int index;

    index = path.lastIndexOf('/');
    result = path.substring(index + 1);

    return result;
  }

  Future saveImage() async {
    if (_image != null && _image.path != null) {
      String dir = _path.dirname(_image.path);
      String newPath = _path.join(dir, _nameImage + '.jpg');
      File _newImage = await File(_image.path).copy(newPath);
      try {
        GallerySaver.saveImage(_newImage.path).then((bool paths) {
          setState(() {
            print(_newImage.path);
            print('Image saved');
            _image = null;
          });
        });
      } catch (e) {
        print(e);
      }
    }
  }

  tampilAlert(String aMsg) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "WARNING",
      desc: aMsg,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }

  Future<void> _showAlert(BuildContext context, String aMessage) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: Text(''),
          content: Center(
              child: Container(
            height: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.warning),
                Text(aMessage),
              ],
            ),
          )),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _renameImage(BuildContext context, String aPathBefore) {
    Widget okButton = FlatButton(
      color: Colors.blue,
      child: Text("OK"),
      onPressed: () {
        if (_nameImage == null || _nameImage == '') {
          // _showAlert(context, 'Nama gambar harus diisi.');
          tampilAlert('Nama gambar harus diisi !');
        } else {
          saveImage();
          Navigator.of(context).pop();
          setState(() {});
        }
      },
    );

    Widget cancelButton = FlatButton(
      color: Colors.red,
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
        setState(() {});
      },
    );

    TextEditingController path_controller =
        TextEditingController(text: aPathBefore);
    // TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Nama Gambar',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content:
              //ListView(scrollDirection: Axis.horizontal, children: <Widget>[
              TextField(
            onChanged: (value) {
              setState(() {
                _nameImage = value;
              });
            },
            controller: path_controller,
          ),
          //]),
          actions: <Widget>[cancelButton, okButton],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Camera",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(0),
          //scrollDirection: Axis.horizontal,
          children: <Widget>[
            Center(
                child: Column(
              children: <Widget>[
                (_image == null)
                    ? Container(
                        margin: EdgeInsets.all(10),
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width,
                        //color: Colors.grey,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage("img/noImage.jpg"),
                          fit: BoxFit.cover,
                        )),
                      )
                    : Container(
                        margin: EdgeInsets.all(10),
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width,
                        child: Image.file(
                          _image,
                        ),
                      ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    button(Icons.insert_drive_file, idButtonGaleri),
                    button(Icons.camera, idButtonCamera),
                    button(Icons.save, idButtonSave),
                  ],
                )
              ],
            )),
          ],
        ),
      ),
    );
  }

  Ink button(IconData aIcon, int aIdButton) {
    return Ink(
      decoration: const ShapeDecoration(
        color: Colors.lightBlue,
        shape: CircleBorder(),
      ),
      child: IconButton(
        icon: Icon(aIcon),
        iconSize: 30,
        color: Colors.white,
        onPressed: () {
          if (aIdButton == idButtonCamera) {
            getImage(true);
          } else if (aIdButton == idButtonGaleri) {
            getImage(false);
          } else if (aIdButton == idButtonSave) {
            if (_image != null) {
              _renameImage(
                  context, _nameImage.substring(0, _nameImage.length - 4));
            }
          }
        },
      ),
    );
  }
}
