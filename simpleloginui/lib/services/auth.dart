import 'package:firebase_auth/firebase_auth.dart';
import 'package:simpleloginui/models/user-model.dart';
import 'package:simpleloginui/services/database.dart';

class AuthService {
//create auth service object
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //use this to convert firebase user to our custom model
  User _getCustomUser(FirebaseUser user) {
    final userData = user != null ? User(uid: user.uid) : null;
    return userData;
  }

  //use this to listen for authentication status
  Stream<User> get user {
    //use this to map firebaseUser object to User
    final _user = _auth.onAuthStateChanged.map(_getCustomUser);
    return _user;
  }

  //sign in with anon //future are async operations and must be awaited
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _getCustomUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with username and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = result.user;
      return _getCustomUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = result.user;
      //create a record/document/row for a user in the db with the user id generated on signup
      await DatabaseService(uid: user.uid)
          .updateUserData('new crew member', '0', 100);
      return _getCustomUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
