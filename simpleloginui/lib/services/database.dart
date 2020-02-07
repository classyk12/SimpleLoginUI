import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simpleloginui/models/brew.dart';
import 'package:simpleloginui/models/user-model.dart';

class DatabaseService {
  //collection reference
  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');
  final String uid;

  DatabaseService({this.uid});

  //use this to update user data after a new user signs up
  Future updateUserData(String name, String sugars, int strenght) async {
    return await brewCollection
        .document(uid)
        .setData({'sugars': sugars, 'name': name, 'strenght': strenght});
  }

//use this to convert querysnapshot to list of brews
  List<Brew> _getBrewFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brew(
          name: doc.data['name'] ?? '',
          strenght: doc.data['strenght'] ?? 0,
          sugars: doc.data['sugars'] ?? '0');
    }).toList();
  }

  //use this to convert document snapshot to user data
  UserData _getUserdataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        strenght: snapshot.data['strenght'],
        sugars: snapshot.data['sugars']);
  }

  //use this to listen to streams of changes in brew documents
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_getBrewFromSnapshot);
  }

  //use this to listen to streams of changes for a user data document using uid as an parameter
  Stream<UserData> get userData {
    return brewCollection
        .document(uid)
        .snapshots()
        .map(_getUserdataFromSnapshot);
  }
}
