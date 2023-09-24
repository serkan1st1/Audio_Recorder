import 'dart:io';
import 'package:audio_recorder/model/records.dart';
import 'package:audio_recorder/services/storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecordService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StorageService _storageService = StorageService();
  String mediaUrl = "";

  Future<RecordModel> addRecord(String date, String audio) async {
    var ref = _firestore.collection("Records");

    if (audio == null) {
      AlertDialog alert = AlertDialog(
        title: ErrorTitle(),
        content: ErrorContents(),
      );
    } else {
      mediaUrl = await _storageService.uploadAudio(File(audio));
    }

    var documentRef = await ref.add({'date': date, 'audio': mediaUrl});

    return RecordModel(id: documentRef.id, date: date, audio: mediaUrl);
  }

  Text ErrorTitle() => const Text("Error");
  Text ErrorContents() => const Text("File not found.");

  //Data
  Stream<QuerySnapshot> getRecords() {
    var ref = _firestore
        .collection("Records")
        .orderBy('date', descending: true)
        .snapshots();
    return ref;
  }
}
