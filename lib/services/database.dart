
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});
  //collection reference

  final CollectionReference hospCollection =
      FirebaseFirestore.instance.collection('Hospital');

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');

  Future updateUserData(String name,String emergencyNo, String age,) async{
    return await userCollection.doc(uid).set({
      'name' : name,
      'emergencyNo' : emergencyNo,
      'age': age,
    });
  }

  /*Stream<QuerySnapshot> get hosp{
    return hospCollection.snapshots();
  }*/
}
