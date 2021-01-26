import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:saige/models/my_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser _userFromFirebaseUser(User user) {
    return user != null ? MyUser(uid: user.uid, email: user.email) : null;
  }

  // auth change user stream
  Stream<MyUser> get user {
    // return _auth.authStateChanges().map(_userFromFirebaseUser);
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // static FirebaseUser _currentUser;

  // void getUser() async {
  //   final _currentUser = await _auth.currentUser();
  // }

  // Future<String> get userId async => (await _auth.currentUser()).uid;

  // sign in anon
  Future signInAnonymously() async {
    try {
      final userCredential = await _auth.signInAnonymously();
      final user = userCredential.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email & password
  Future signInWithEmailAndPassword({String email, String password}) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign iup with email & password
  Future registerWithEmailAndPassword({
    String fullName,
    String email,
    String password,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      user.updateProfile(displayName: fullName);
      user.reload();
      MyUser myUser = MyUser(
        uid: user.uid,
        email: email,
        fullName: fullName,
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(myUser.uid)
          .set(myUser.toJson());
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
