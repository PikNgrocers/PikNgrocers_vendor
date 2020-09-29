import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Database {
  final String uid;
  Database({this.uid});

  FirebaseApp secondaryApp = Firebase.app('pik_n_grocers_vendor');

  Future<void> updateUserData(
      {String username, String shopname, String fsno, String phno}) async {
    return await FirebaseFirestore.instanceFor(app: secondaryApp)
        .collection('user')
        .doc(uid)
        .set({
      'user_name': username,
      'shop_name': shopname,
      'fs_no': fsno,
      'ph_no': phno,
    });
  }

  Future<DocumentSnapshot> getDatas() async {
    //TODO:Need to create map for products in firebase "not collection".
    return await FirebaseFirestore.instanceFor(app: secondaryApp).collection('user').doc(uid).get();
  }
}
