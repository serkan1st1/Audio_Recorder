import 'dart:io';

import 'package:audio_recorder/model/records.dart';
import 'package:audio_recorder/services/storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecordService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StorageService _storageService = StorageService();
  String mediaUrl = "";

  Future<RecordModel> addRecord(String person, String audio) async {
    var ref = _firestore.collection("Records");

    if (audio == null) {
      AlertDialog alert = AlertDialog(
        title: ErrorTitle(),
        content:
            const Text("Ses dosyası bulunamadı.Tekrar kayıt yapmayı deneyin."),
      );
    } else {
      mediaUrl = await _storageService.uploadAudio(File(audio));
    }

    var documentRef = await ref.add({'person': person, 'audio': mediaUrl});

    return RecordModel(id: documentRef.id, person: person, audio: mediaUrl);
  }

  Text ErrorTitle() => const Text("Hata");

  //Data
  Stream<QuerySnapshot> getRecords() {
    var ref = _firestore.collection("Records").snapshots();
    return ref;
  }
}
