import 'package:cloud_firestore/cloud_firestore.dart';

class Rent {
  final String name;
  final String cost;
  final String category;
  final String desc;
  final String pic;
  final String contactinfo;

  const Rent({
    required this.name,
    required this.cost,
    required this.category,
    required this.desc,
    required this.pic,
    required this.contactinfo,
  });

  toJson() {
    return {
      "name": name,
      "cost": cost,
      "category": category,
      "desc": desc,
      "pic": pic,
      "contactinfo": contactinfo,
    };
  }

  factory Rent.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Rent(
      name: data["name"],
      cost: data["cost"],
      category: data["category"],
      desc: data["desc"],
      pic: data["pic"],
      contactinfo: data["contactinfo"],
    );
  }
}
