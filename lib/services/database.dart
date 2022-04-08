import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:projetchatapp/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService(this.uid);

  final CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection("users");
  final fireStorage = FirebaseStorage.instance;
  final auth = FirebaseAuth.instance;

  Future<void> saveUser(String name, String prenom) async {
    return await userCollection.doc(uid).set({'name': name,'prenom': prenom});
  }

  updateUser(String uid,Map<String,dynamic> map){
    userCollection.doc(uid).update(map);
  }

  Future <String> getIdentifiant() async{
    String id = auth.currentUser!.uid;
    return id;
  }

  Future<void> saveToken(String? token) async {
    return await userCollection.doc(uid).update({'token': token});
  }

  AppUserData _userFromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("user not found");
    return AppUserData(
      uid: snapshot.id,
      nom: data['name'],
      prenom: data['prenom'],
      avatar: data['avatar']
    );
  }

  Stream<AppUserData> get user {
    return userCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }

  List<AppUserData> _userListFromSnapshot(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc) {
      return _userFromSnapshot(doc);
    }).toList();
  }

  Stream<List<AppUserData>> get users {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }

  Future <String> stockageImage(String name,Uint8List data) async {
    //Stocker mon image dans la base donnée
    TaskSnapshot download = await fireStorage.ref("image/$name").putData(data);

    //Récupérer le lien de mon image
    String urlChemin = await download.ref.getDownloadURL();
    return urlChemin;


  }
}
