import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodsarv01/models/donation.dart';

class MyRequests extends StatefulWidget {
  const MyRequests({super.key});

  @override
  State<MyRequests> createState() => _MyRequestsState();
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
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot snap = snapshot.data!.docs[index];
                  Donation donation = Donation.fromMap(snap);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ViewAcceptScreen(
                          //       snap: snap,
                          //       isMine: false,
                          //     ),
                          //   ),
                          // );
                        },
                        title: Text(donation.foodName),
                        subtitle: Text(donation.name),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(donation.url),
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
