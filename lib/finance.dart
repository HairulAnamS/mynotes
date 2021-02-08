import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Finance {
  int idFinance;
  String subjek;
  DateTime tglTrans;
  String bulanTrans;
  int nominal;
  bool isDebet;
  DateTime tglCreate;

  Finance(
      {this.idFinance,
      this.subjek,
      this.tglTrans,
      this.bulanTrans,
      this.nominal,
      this.isDebet,
      this.tglCreate});

  factory Finance.fromJson(Map<String, dynamic> map) {
    return Finance(
        idFinance: map["idFinance"],
        subjek: map["subjek"],
        tglTrans: DateTime.fromMillisecondsSinceEpoch(
            map["tglTrans"].millisecondsSinceEpoch),
        bulanTrans: map["bulanTrans"],
        nominal: map["nominal"],
        isDebet: map["isDebet"],
        tglCreate: DateTime.fromMillisecondsSinceEpoch(
            map["tglCreate"].millisecondsSinceEpoch));
  }

  Map<String, dynamic> toJson() {
    return {
      "idFinance": idFinance,
      "subjek": subjek,
      "tglTrans": tglTrans,
      "bulanTrans": bulanTrans,
      "nominal": nominal,
      "isDebet": isDebet,
      "tglCreate": tglCreate
    };
  }

  @override
  String toString() {
    return "Finance{idFinance: $idFinance, subjek: $subjek, isDebet: $isDebet}";
  }

  factory Finance.clear() {
    return Finance(
        idFinance: 0,
        subjek: "",
        tglTrans: DateTime.now(),
        bulanTrans: "",
        nominal: 0,
        isDebet: true,
        tglCreate: DateTime.now());
  }
}

List<Finance> objectFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Finance>.from(data.map((item) => Finance.fromJson(item)));
}

String objectToJson(Finance data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

class FinanceDB {
  Finance finance = new Finance();
  static CollectionReference dataCollection =
      Firestore.instance.collection('finance');

  Future<void> insert(Finance finance) async {
    await dataCollection.document(finance.idFinance.toString()).setData({
      'idFinance': finance.idFinance,
      'subjek': finance.subjek,
      'tglTrans': finance.tglTrans,
      'bulanTrans': finance.bulanTrans,
      'nominal': finance.nominal,
      'isDebet': finance.isDebet,
      'tglCreate': finance.tglCreate
    });
  }

  Future<void> update(Finance finance) async {
    await dataCollection.document(finance.idFinance.toString()).setData({
      'subjek': finance.subjek,
      'tglTrans': finance.tglTrans,
      'bulanTrans': finance.bulanTrans,
      'nominal': finance.nominal,
      'isDebet': finance.isDebet
    }, merge: true);
  }

  Future<void> delete(String id) async {
    await dataCollection.document(id).delete();
  }

  selectByID(int id) {
    return dataCollection.where('idFinance', isEqualTo: id).getDocuments();
  }

  Future<Finance> selectByIDNew(int id) async {
    QuerySnapshot docs =
        await dataCollection.where('idFinance', isEqualTo: id).getDocuments();

    if (docs.documents.length > 0) {
      finance = Finance.fromJson(docs.documents[0].data);
    }

    return finance;
  }

  Finance selectByIDNew2(int id) {
    dataCollection.where('idFinance', isEqualTo: id).getDocuments().then((docs) {
      if (docs.documents.length > 0) {
        finance = Finance.fromJson(docs.documents[0].data);
      }
    });

    return finance;
  }

  Future<int> getMaxID() async {
    int id = 0;
    await dataCollection
        .orderBy('idFinance', descending: true)
        .limit(1)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((result) {
        print('idFinance finance: ${result.data["idFinance"] + 1}');

        id = result.data["idFinance"] + 1;
      });
    });
    if (id == 0) id = id + 1;
    return id;
  }

  Future<List<Finance>> getFinance() async {
    List<Finance> financeList = [];
    await dataCollection
        .orderBy('tglTrans', descending: false)
        .getDocuments()
        .then((docs) {
      if (docs.documents.length > 0) {
        financeList.clear();
        for (int i = 0; i < docs.documents.length; i++) {
          financeList.add(Finance.fromJson(docs.documents[i].data));
        }
      }
    });

    return financeList;
  }

  Future<List<Finance>> getFinanceFilter(String aValue, bool aIsBulan) async {
    List<Finance> financeList = [];
    if (aIsBulan) {
      await dataCollection
          .where('bulan', isEqualTo: aValue)
          .orderBy('nama', descending: false)
          .getDocuments()
          .then((docs) {
        if (docs.documents.length > 0) {
          financeList.clear();
          for (int i = 0; i < docs.documents.length; i++) {
            financeList.add(Finance.fromJson(docs.documents[i].data));
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
          financeList.clear();
          for (int i = 0; i < docs.documents.length; i++) {
            financeList.add(Finance.fromJson(docs.documents[i].data));
          }
        }
      }); 
    }

    return financeList;
  }
}
