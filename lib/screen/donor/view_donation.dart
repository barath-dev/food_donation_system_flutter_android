import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodsarv01/widgets/listtile.dart';

class ViewDonation extends StatefulWidget {
  const ViewDonation({super.key});

  @override
  State<ViewDonation> createState() => _ViewDonationState();
}

class _ViewDonationState extends State<ViewDonation> {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(
          title: const Text(
            "View Donation",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, letterSpacing: 1.1),
          ),
          backgroundColor: Colors.black,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('donations')
                .where('status', isEqualTo: 'pending')
                .snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Listtile(snap: snapshot.data!.docs[index]);
                    });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            })));
  }
}
