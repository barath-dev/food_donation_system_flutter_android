import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodsarv01/models/donation.dart';


class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key, required this.});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("donations").snapshots(),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewAcceptScreen(
                              snap: snap,
                              isMine: false,
                            ),
                          ),
                        );
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
      ),
    );
  }
}