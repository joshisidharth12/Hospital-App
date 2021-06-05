import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future setUserData(String name,String emergencyNo, String age,) async{
    return await userCollection.doc(uid).set({
      'name' : name,
      'emergencyNo' : emergencyNo,
      'age': age,
      'pdf': "-1"
    });
  }

  Future updatePdf(String url) async{
    return await userCollection.doc(uid).update({
      'pdf' : url
    });
  }


  static Future<File> loadNetwork(String url) async{
    final response = await http.get(url);
    final bytes = response.bodyBytes;

    return _storeFile(url,bytes);
  }

  static Future<File> _storeFile(String url,List<int> bytes) async{
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes,flush: true);
    return file;
  }

  /*Stream<QuerySnapshot> get hosp{
    return hospCollection.snapshots();
  }*/
}
