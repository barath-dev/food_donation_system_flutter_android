import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TranspoerStatus extends StatefulWidget {
  const TranspoerStatus({super.key});

  @override
  State<TranspoerStatus> createState() => _TranspoerStatusState();
}

class _TranspoerStatusState extends State<TranspoerStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("donations")
              .where(Filter.or(
                  Filter('status', isEqualTo: 'delivered'),
                  Filter('status', isEqualTo: 'started'),
                  Filter('status', isEqualTo: 'waiting')))
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text("No delivery started yet",
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        tileColor: Colors.green,
                        onTap: () {
                          // _confirmBook();
                        },
                        title: Text(
                          snapshot.data!.docs[index]['foodName'],
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          snapshot.data!.docs[index]['name'],
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          // ignore: prefer_interpolation_to_compose_strings
                          "${snapshot.data!.docs[index]['quantity']} " +
                              snapshot.data!.docs[index]['unit'],
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
