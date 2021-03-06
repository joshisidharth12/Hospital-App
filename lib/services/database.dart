import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  //collection reference

  final CollectionReference hospCollection =
      FirebaseFirestore.instance.collection('Hospital');

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');

  final mainReference =
      FirebaseDatabase.instance.reference().child('Appointments');

  String createCryptoRandomString([int length = 32]) {
    final Random _random = Random.secure();
    var values = List<int>.generate(length, (i) => _random.nextInt(256));
    return base64Url.encode(values);
  }

  void documentFileUpload(String name, String url, String age, String status,
      String apt, String dateTime,String hospName, String emergencyNo) {
    var data = {
      "pdf": url,
      "name": name,
      "age": age,
      "type": "PATIENT",
      "status": status,
      "appointment_id": apt,
      "timestamp": dateTime,
      "hospName" : hospName,
      "emergencyNo" : emergencyNo
    };

    mainReference.child(apt).set(data).then((value) {
      print("Appointment Booked");
    });
  }

  void documentVictimFileUpload(String name, String url, String emergNo,
      String age, String status, String apt, String dateTime,String hospName,) {
    var data = {
      "pdf": url,
      "name": name,
      "age": age,
      "type": "VICTIM",
      "status": status,
      "appointment_id": apt,
      "timestamp": dateTime,
      "hospName" : hospName,
      "emergencyNo" : emergNo
    };

    mainReference.child(apt).set(data).then((value) {
      print("Appointment Booked");
    });
  }

  Future setUserData(
    String name,
    String emergencyNo,
    String age,
  ) async {
    return await userCollection.doc(uid).set(
        {'name': name, 'emergencyNo': emergencyNo, 'age': age, 'pdf': "-1"});
  }

  Future updatePdf(String url) async {
    return await userCollection.doc(uid).update({'pdf': url});
  }

  static Future<File> loadNetwork(String url) async {
    final response = await http.get(url);
    final bytes = response.bodyBytes;

    return _storeFile(url, bytes);
  }

  static Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

/*Stream<QuerySnapshot> get hosp{
    return hospCollection.snapshots();
  }*/
}
