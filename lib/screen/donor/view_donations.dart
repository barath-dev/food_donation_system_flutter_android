import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodsarv01/screen/common/view_donation_page.dart';
import 'package:foodsarv01/widgets/listtile.dart';

class ViewDonation extends StatefulWidget {
  final bool isMine;
  const ViewDonation({super.key, required this.isMine});

  @override
  State<ViewDonation> createState() => _ViewDonationState();
}

class _ViewDonationState extends State<ViewDonation> {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(
          title: Text(
            widget.isMine ? "View My Donations" : "View Donations",
            style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
                color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        body: StreamBuilder(
            stream: !(widget.isMine)
                ? FirebaseFirestore.instance
                    .collection('donations')
                    .where('status', isEqualTo: 'pending')
                    .snapshots()
                : FirebaseFirestore.instance
                    .collection('donations')
                    .where('uid',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData) {
                var len = snapshot.data!.docs.length;
                if (len == 0) {
                  return const Center(
                      child: Text(
                    "No Donations made yet",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                        color: Colors.black),
                  ));
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewAcceptScreen(
                                            snap: snapshot.data!.docs[index],
                                            isMine: widget.isMine,
                                          )));
                            },
                            child: Listtile(snap: snapshot.data!.docs[index]));
                      });
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            })));
  }
}
