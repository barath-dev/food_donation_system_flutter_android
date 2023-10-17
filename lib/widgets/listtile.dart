// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, avoid_print


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodsarv01/models/donation.dart';
import 'package:foodsarv01/widgets/tile.dart';

// ignore: non_constant_identifier_names
Widget Listtile({required DocumentSnapshot snap}) {
  Donation donation = Donation.fromMap(snap);
  return Container(
    padding: EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(right: 10),
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue,
          ),
          child: Center(
              child: Text('image here', style: TextStyle(color: Colors.white))),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Row(
                  children: [
                    Spacer(
                      flex: 4,
                    ),
                    Text(donation.foodName,
                        style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    Spacer(
                      flex: 5,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // InkWell(
                    //   onTap: () {
                    //     print('call');
                    //   },
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       color: Colors.green,
                    //     ),
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 4),
                    //       child: Column(
                    //         mainAxisSize: MainAxisSize.min,
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             'Location',
                    //             style: TextStyle(
                    //                 color: const Color.fromARGB(255, 0, 0, 0)),
                    //             textAlign: TextAlign.left,
                    //           ),
                    //           Text('Kathmandu',
                    //               style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
                    //               textAlign: TextAlign.left),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    tile(
                        title: "Expiry date",
                        subtitle:
                            "${donation.expiry_time.day}/${donation.expiry_time.month}/${donation.expiry_time.year}"),
                    tile(
                        title: "Quantity",
                        subtitle: "${donation.quantity} ${donation.unit}"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
