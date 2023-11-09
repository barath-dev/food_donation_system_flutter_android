import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:foodsarv01/models/donation.dart';

class MyRequests extends StatefulWidget {
  const MyRequests({super.key});

  @override
  State<MyRequests> createState() => _MyRequestsState();
}

Color getColor() {
  return Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
      .withOpacity(1.0);
}

SimpleDialog _confirm() {
  return SimpleDialog(
    title: const Text('Confirm'),
    children: <Widget>[
      SimpleDialogOption(
        onPressed: () {},
        child: const Text('Confirm'),
      ),
      SimpleDialogOption(
        onPressed: () {},
        child: const Text('Cancel'),
      ),
    ],
  );
}

class _MyRequestsState extends State<MyRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Requests'),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("donations")
              .where('requests',
                  arrayContains:
                      FirebaseAuth.instance.currentUser!.uid.toString())
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text("No requests made yet",
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot snap = snapshot.data!.docs[index];
                  Donation donation = Donation.fromMap(snap);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        visualDensity: const VisualDensity(vertical: 3),
                        tileColor: getColor(),
                        onTap: () {
                          _confirm();
                        },
                        title: Text(
                          donation.foodName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "Reciever name: ${donation.name}\nstatus: ${donation.status}",
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        leading: CircleAvatar(
                          radius: 48,
                          backgroundImage: NetworkImage(donation.url, scale: 4),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
