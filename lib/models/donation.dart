// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Donation {
  final String name;
  final String uid;
  final String foodName;
  final int quantity;
  final String unit;
  final DateTime expiry_time;
  final DateTime pickup_time;
  final String mobile;
  final String status;

  Donation({
    required this.name,
    required this.uid,
    required this.foodName,
    required this.quantity,
    required this.unit,
    required this.expiry_time,
    required this.pickup_time,
    required this.mobile,
    required this.status,
  });

  factory Donation.fromMap(DocumentSnapshot data) {
    return Donation(
      name: data['name'],
      uid: data['uid'],
      foodName: data['foodName'],
      quantity: data['quantity'],
      unit: data['unit'],
      expiry_time: data['expiry_time'].toDate(),
      pickup_time: data['pickup_time'].toDate(),
      mobile: data['mobile'],
      status: data['status'],
    );
  }
}
