import 'package:flutter/foundation.dart';

class Project {
  String id;
  String userId;
  String name;
  String country;
  String description;
  String duration;
  String currency;
  String domain;
  String image;
  String totalAmount;
  bool isPublic;

  Project({
    @required this.id,
    @required this.userId,
    @required this.name,
    @required this.country,
    @required this.description,
    @required this.duration,
    @required this.currency,
    @required this.domain,
    @required this.totalAmount,
    this.image = "",
    this.isPublic = true,
  });

  Project.fromMap(Map snapshot, String id)
      : id = id ?? '',
        name = snapshot['name'] ?? '',
        userId = snapshot['userId'] ?? '',
        country = snapshot['country'] ?? '',
        description = snapshot['description'] ?? '',
        duration = snapshot['duration'] ?? '',
        currency = snapshot['currency'] ?? '',
        domain = snapshot['domain'] ?? '',
        image = snapshot['image'] ?? '',
        totalAmount = snapshot['totalAmount'] ?? '',
        isPublic = snapshot['isPublic'] ?? true;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "userId": userId,
      "country": country,
      "description": description,
      "duration": duration,
      "currency": currency,
      "domain": domain,
      "image": image,
      "totalAmount": totalAmount,
      "isPublic": isPublic,
    };
  }
}
