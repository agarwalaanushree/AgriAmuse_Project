import 'package:cloud_firestore/cloud_firestore.dart';

class crop {
  final String cropname;
  final String descr;
  final String msp;
  final String quantity;
  final String contact;
  final String pic;

  const crop({
    required this.cropname,
    required this.descr,
    required this.msp,
    required this.quantity,
    required this.pic,
    required this.contact,
  });

  toJson() {
    return {
      "cropname": cropname,
      "descr": descr,
      "msp": msp,
      "quantity": quantity,
      "pic": pic,
      "contact": contact,
    };
  }

  factory crop.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return crop(
      cropname: data["cropname"],
      descr: data["descr"],
      msp: data["msp"],
      quantity: data["quantity"],
      pic: data["pic"],
      contact: data["contact"],
    );
  }
}
