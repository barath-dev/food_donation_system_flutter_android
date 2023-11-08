import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodsarv01/models/donation.dart';

class ViewRequests extends StatefulWidget {
  final Donation donation;
  const ViewRequests({super.key, required this.donation});

  @override
  State<ViewRequests> createState() => _ViewRequestsState();
}

class _ViewRequestsState extends State<ViewRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("donations")
            .where('rid', isEqualTo: widget.donation.rid)
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
                      onTap: () {},
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
      ),
    );
  }
}
