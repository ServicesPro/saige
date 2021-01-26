import 'package:flutter/foundation.dart';

class MyUser {
  String uid;
  String fullName;
  int age;
  String email;
  String sex;
  String country;
  String image;

  MyUser({
    @required this.uid,
    this.fullName = "",
    this.age = 0,
    @required this.email,
    this.sex = "",
    this.image = "",
    this.country = "",
  });

  MyUser.fromMap(Map snapshot, String uid)
      : uid = uid ?? '',
        fullName = snapshot['fullName'] ?? '',
        age = snapshot['age'] ?? 0,
        email = snapshot['email'] ?? '',
        sex = snapshot['sex'] ?? '',
        image = snapshot['image'] ?? '',
        country = snapshot['country'] ?? '';

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "fullName": fullName,
      "age": age,
      "email": email,
      "sex": sex,
      "image": image,
      "country": country,
    };
  }
}
