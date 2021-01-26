import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final String path = "users";
  CollectionReference ref;

  static final UserService _userService = UserService._internal();

  UserService._internal();

  factory UserService() {
    _userService.ref = _db.collection(path);
    return _userService;
  }

  static UserService get instance => _userService;

  Future<QuerySnapshot> getDataCollection() {
    return ref.get();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.doc(id).get();
  }

  Future<void> removeDocument(String id) {
    return ref.doc(id).delete();
  }

  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }

  Future<void> updateDocument(Map data, String id) {
    return ref.doc(id).update(data);
  }
}
