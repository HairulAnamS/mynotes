import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  static CollectionReference noteCollection =
      Firestore.instance.collection('notes');

  static Future<void> createNote(String id,
      {int idNote, String note, String date}) async {
    await noteCollection
        .document(id)
        .setData({'idNote': idNote, 'catatan': note, 'tanggal': date});
  }

  static Future<DocumentSnapshot> getNote(String id) async {
    return await noteCollection.document(id).get();
  }

  static Future<int> getMaxID() async {
    QuerySnapshot myDoc = await noteCollection.getDocuments();
    return myDoc.documents.length + 1;

    //print(myDoc.documentChanges.length + 1);
  }

  static Future<int> getMaxIDBaru() async {
    int id = 0;
    await noteCollection
        .orderBy('idNote', descending: true)
        .limit(1)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((result) {
        print('${result.data["idNote"] + 1}');

        id = result.data["idNote"] + 1;
      });
    });
    return id;
    //print(myDoc.documentChanges.length + 1);
  }

  static Future<void> getDocument() async {
    QuerySnapshot _myNote = await noteCollection
        .orderBy('idNote', descending: true)
        .getDocuments();
    return _myNote.documents;
    // List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    // return _myDocCount.length;
  }

  static Future<void> getData() async {
    await noteCollection.getDocuments().then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }

  static Future<void> deleteNote(String id) async {
    await noteCollection.document(id).delete();
  }
}
