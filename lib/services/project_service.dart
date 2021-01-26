import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ProjectService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final String path = "projects";
  CollectionReference ref;

  static final ProjectService _projectService = ProjectService.internal();

  ProjectService.internal();

  factory ProjectService() {
    _projectService.ref = _db.collection(path);
    return _projectService;
  }

  static ProjectService get instance => _projectService;

  Future<QuerySnapshot> getDataCollection() {
    return ref.get();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots();
  }

  Stream<QuerySnapshot> streamDataCollectionByUser({@required String id}) {
    try {
      return ref.where("userId", isEqualTo: id).orderBy("name").snapshots();
    } catch (err) {
      print(err);
      return null;
    }
  }

  Stream<QuerySnapshot> streamPublicOrStateDataCollection({
    bool isPublic = true,
  }) {
    try {
      if (isPublic) {
        return ref
            .where("isPublic", isEqualTo: true)
            .orderBy("name")
            .snapshots();
      }
      return ref
          .where("isPublic", isEqualTo: false)
          .orderBy("name")
          .snapshots();
    } catch (err) {
      print(err);
      return null;
    }
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
