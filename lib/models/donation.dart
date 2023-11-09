// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Donation {
  final String name;
  final String uid;
  final String foodName;
  final int quantity;
  final String location;
  final String recieverID;
  final String rid;
  final String url;
  final List<dynamic> requests;
  final String unit;
  final DateTime expiry_time;
  final DateTime pickup_time;
  final String mobile;
  final String status;

  Donation({
    required this.name,
    required this.rid,
    required this.uid,
    required this.foodName,
    required this.requests,
    required this.quantity,
    required this.recieverID,
    required this.url,
    required this.location,
    required this.unit,
    required this.expiry_time,
    required this.pickup_time,
    required this.mobile,
    required this.status,
  });

  factory Donation.fromMap(DocumentSnapshot data) {
    return Donation(
      name: data['name'],
      rid: data['rid'],
      uid: data['uid'],
      recieverID: data['recieverID'],
      requests: data['requests'],
      foodName: data['foodName'],
      location: data['location'],
      quantity: data['quantity'],
      unit: data['unit'],
      url: data['imgUrl'],
      expiry_time: data['expiry_time'].toDate(),
      pickup_time: data['pickup_time'].toDate(),
      mobile: data['mobile'],
      status: data['status'],
    );
  }
}
