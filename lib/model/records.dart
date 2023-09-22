import 'package:cloud_firestore/cloud_firestore.dart';

class RecordModel {
  late String id;
  late String date;
  late String audio;

  RecordModel({required this.id, required this.date, required this.audio});

  factory RecordModel.fromSnapShot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return RecordModel(
        id: snapshot.id, date: data["date"], audio: data["audio"]);
  }
}
