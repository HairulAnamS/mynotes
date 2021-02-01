import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Finance {
  int idfinance;
  String subjek;
  DateTime tgltrans;
  String bulantrans;
  double nominal;
  bool isDebet;
  DateTime tglCreate;

  Finance(
      {this.idfinance,
      this.subjek,
      this.tgltrans,
      this.bulantrans,
      this.nominal,
      this.isDebet,
      this.tglCreate});

  factory Finance.fromJson(Map<String, dynamic> map) {
    return Finance(
        idfinance: map["idfinance"],
        subjek: map["subjek"],
        tgltrans: DateTime.fromMillisecondsSinceEpoch(
            map["tgltrans"].millisecondsSinceEpoch),
        bulantrans: map["bulantrans"],
        nominal: map["nominal"],
        isDebet: map["isDebet"],
        tglCreate: DateTime.fromMillisecondsSinceEpoch(
            map["tglCreate"].millisecondsSinceEpoch));
  }

  Map<String, dynamic> toJson() {
    return {
      "idfinance": idfinance,
      "subjek": subjek,
      "tgltrans": tgltrans,
      "bulantrans": bulantrans,
      "nominal": nominal,
      "isDebet": isDebet,
      "tglCreate": tglCreate
    };
  }

  @override
  String toString() {
    return "Finance{idfinance: $idfinance, subjek: $subjek, isDebet: $isDebet}";
  }

  factory Finance.clear() {
    return Finance(
        idfinance: 0,
        subjek: "",
        tgltrans: DateTime.now(),
        bulantrans: "",
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
    await dataCollection.document(finance.idfinance.toString()).setData({
      'idfinance': finance.idfinance,
      'subjek': finance.subjek,
      'tgltrans': finance.tgltrans,
      'bulantrans': finance.bulantrans,
      'nominal': finance.nominal,
      'isDebet': finance.isDebet,
      'tglCreate': finance.tglCreate
    });
  }

  Future<void> update(Finance finance) async {
    await dataCollection.document(finance.idfinance.toString()).setData({
      'subjek': finance.subjek,
      'tgltrans': finance.tgltrans,
      'bulantrans': finance.bulantrans,
      'nominal': finance.nominal,
      'isDebet': finance.isDebet
    }, merge: true);
  }

  Future<void> delete(String id) async {
    await dataCollection.document(id).delete();
  }

  selectByID(int id) {
    return dataCollection.where('idfinance', isEqualTo: id).getDocuments();
  }

  Future<Finance> selectByIDNew(int id) async {
    QuerySnapshot docs =
        await dataCollection.where('idfinance', isEqualTo: id).getDocuments();

    if (docs.documents.length > 0) {
      finance = Finance.fromJson(docs.documents[0].data);
    }

    return finance;
  }

  Finance selectByIDNew2(int id) {
    dataCollection.where('idfinance', isEqualTo: id).getDocuments().then((docs) {
      if (docs.documents.length > 0) {
        finance = Finance.fromJson(docs.documents[0].data);
      }
    });

    return finance;
  }

  Future<int> getMaxID() async {
    int id = 0;
    await dataCollection
        .orderBy('idfinance', descending: true)
        .limit(1)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((result) {
        print('idfinance finance: ${result.data["idfinance"] + 1}');

        id = result.data["idfinance"] + 1;
      });
    });
    if (id == 0) id = id + 1;
    return id;
  }

  Future<List<Finance>> getFinance() async {
    List<Finance> financeList = [];
    await dataCollection
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
