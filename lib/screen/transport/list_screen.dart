import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TransportScreen extends StatefulWidget {
  const TransportScreen({super.key});

  @override
  State<TransportScreen> createState() => _TransportScreenState();
}

class _TransportScreenState extends State<TransportScreen> {
  _confirmBook() {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Strat Transporting'),
            children: [
              Row(
                children: [
                  const Spacer(),
                  SimpleDialogOption(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue[900],
                            borderRadius: BorderRadius.circular(20)),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                      }),
                  SimpleDialogOption(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue[900],
                            borderRadius: BorderRadius.circular(20)),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Start',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      onPressed: () async {}),
                  const Spacer(),
                ],
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("donations")
              .where('status', isEqualTo: 'transport')
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
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        onTap: () {
                          _confirmBook();
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
          },
        ));
  }
}
