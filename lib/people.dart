import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class People {
  int idpeople;
  String nama;
  String jenisKelamin;
  String bulan;
  DateTime tglLahir;
  String urlPhoto;
  DateTime tglCreate;

  People(
      {this.idpeople,
      this.nama,
      this.jenisKelamin,
      this.bulan,
      this.tglLahir,
      this.urlPhoto,
      this.tglCreate});

  factory People.fromJson(Map<String, dynamic> map) {
    return People(
        idpeople: map["idpeople"],
        nama: map["nama"],
        jenisKelamin: map["jenisKelamin"],
        bulan: map["bulan"],
        tglLahir: DateTime.fromMillisecondsSinceEpoch(
            map["tglLahir"].millisecondsSinceEpoch),
        urlPhoto: map["urlPhoto"],
        tglCreate: DateTime.fromMillisecondsSinceEpoch(
            map["tglCreate"].millisecondsSinceEpoch));
  }

  Map<String, dynamic> toJson() {
    return {
      "idpeople": idpeople,
      "nama": nama,
      "jenisKelamin": jenisKelamin,
      "bulan": bulan,
      "tglLahir": tglLahir,
      "urlPhoto": urlPhoto,
      "tglCreate": tglCreate
    };
  }

  @override
  String toString() {
    return "People{idpeople: $idpeople, nama: $nama, jenisKelamin: $jenisKelamin}";
  }

  factory People.clear() {
    return People(
        idpeople: 0,
        nama: "",
        jenisKelamin: "L",
        bulan: "",
        tglLahir: DateTime.now(),
        urlPhoto: "",
        tglCreate: DateTime.now());
  }
}

List<People> objectFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<People>.from(data.map((item) => People.fromJson(item)));
}

String objectToJson(People data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

class PeopleDB {
  People people = new People();
  static CollectionReference dataCollection =
      Firestore.instance.collection('people');

  Future<void> insert(People people) async {
    await dataCollection.document(people.idpeople.toString()).setData({
      'idpeople': people.idpeople,
      'nama': people.nama,
      'jenisKelamin': people.jenisKelamin,
      'bulan': people.bulan,
      'tglLahir': people.tglLahir,
      'urlPhoto': people.urlPhoto,
      'tglCreate': people.tglCreate
    });
  }

  Future<void> update(People people) async {
    await dataCollection.document(people.idpeople.toString()).setData({
      'nama': people.nama,
      'jenisKelamin': people.jenisKelamin,
      'bulan': people.bulan,
      'tglLahir': people.tglLahir,
      'urlPhoto': people.urlPhoto
    }, merge: true);
  }

  Future<void> delete(String id) async {
    await dataCollection.document(id).delete();
  }

  selectByID(int id) {
    return dataCollection.where('idpeople', isEqualTo: id).getDocuments();
  }

  Future<People> selectByIDNew(int id) async {
    QuerySnapshot docs =
        await dataCollection.where('idpeople', isEqualTo: id).getDocuments();

    if (docs.documents.length > 0) {
      people = People.fromJson(docs.documents[0].data);
    }

    return people;
  }

  People selectByIDNew2(int id) {
    dataCollection.where('idpeople', isEqualTo: id).getDocuments().then((docs) {
      if (docs.documents.length > 0) {
        people = People.fromJson(docs.documents[0].data);
      }
    });

    return people;
  }

  Future<int> getMaxID() async {
    int id = 0;
    await dataCollection
        .orderBy('idpeople', descending: true)
        .limit(1)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((result) {
        print('idpeople people: ${result.data["idpeople"] + 1}');

        id = result.data["idpeople"] + 1;
      });
    });
    if (id == 0) id = id + 1;
    return id;
  }

  Future<List<People>> getPeople() async {
    List<People> peopleList = [];
    await dataCollection
        .orderBy('nama', descending: false)
        .getDocuments()
        .then((docs) {
      if (docs.documents.length > 0) {
        peopleList.clear();
        for (int i = 0; i < docs.documents.length; i++) {
          peopleList.add(People.fromJson(docs.documents[i].data));
        }
      }
    });

    return peopleList;
  }

  Future<List<People>> getPeopleFilter(String aValue, bool aIsBulan) async {
    List<People> peopleList = [];
    if (aIsBulan) {
      await dataCollection
          .where('bulan', isEqualTo: aValue)
          .orderBy('nama', descending: false)
          .getDocuments()
          .then((docs) {
        if (docs.documents.length > 0) {
          peopleList.clear();
          for (int i = 0; i < docs.documents.length; i++) {
            peopleList.add(People.fromJson(docs.documents[i].data));
          }
        }
      });
    }else{
      await dataCollection
          // .where('nama', isEqualTo: aValue)
          .orderBy('nama', descending: false)
          .startAt([aValue]).endAt([aValue +'\uf8ff'])
          // .where('nama', isLessThan: aValue)
          .getDocuments()
          .then((docs) {
        if (docs.documents.length > 0) {
          peopleList.clear();
          for (int i = 0; i < docs.documents.length; i++) {
            peopleList.add(People.fromJson(docs.documents[i].data));
          }
        }
      }); 
    }

    return peopleList;
  }
}
