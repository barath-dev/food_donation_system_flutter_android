// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodsarv01/models/donation.dart';
import 'package:foodsarv01/screen/donor/view_requests.dart';

class ViewAcceptScreen extends StatefulWidget {
  final DocumentSnapshot snap;
  final bool isMine;
  const ViewAcceptScreen({super.key, required this.snap, required this.isMine});

  @override
  State<ViewAcceptScreen> createState() => _ViewAcceptScreenState();
}

class _ViewAcceptScreenState extends State<ViewAcceptScreen> {
  TextEditingController phone = TextEditingController();
  TextEditingController location = TextEditingController();

  @override
  void initState() {
    print(FirebaseAuth.instance.currentUser!.uid == widget.snap['uid']);
    super.initState();
  }

  _getData() async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Enter your details'),
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  controller: phone,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  controller: location,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Location',
                  ),
                ),
              ),
              Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel')),
                  ElevatedButton(
                      onPressed: () async {
                        if (phone.text.isNotEmpty && location.text.isNotEmpty) {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({
                            'status': 'accepted',
                            'phone': phone.text,
                            'location': location.text
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Details Updated and Request Sent'),
                            ),
                          );
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill all the details'),
                            ),
                          );
                        }
                      },
                      child: const Text('Confirm')),
                  const Spacer(),
                ],
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Donation donation = Donation.fromMap(widget.snap);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(flex: 2, child: Container()),
              Row(
                children: [
                  const Spacer(),
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(donation.url),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Donator:${donation.name}",
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Food donated : ${donation.foodName}",
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Quantity ${donation.quantity} ${donation.unit}",
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Location ${donation.location}",
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "mobile:${donation.mobile}",
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Expiry date:${donation.expiry_time.toString().substring(0, 16)}",
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        if (FirebaseAuth.instance.currentUser!.uid ==
                            donation.uid) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewRequests(
                                        donation: donation,
                                      )));
                        } else {}
                      },
                      child: Text(
                          FirebaseAuth.instance.currentUser!.uid == donation.uid
                              ? "View Requests"
                              : "")),
                  ElevatedButton(
                      onPressed: () async {
                        _getData();
                        if (FirebaseAuth.instance.currentUser!.uid ==
                            donation.uid) {
                          FirebaseFirestore.instance
                              .collection('donations')
                              .doc(widget.snap.id)
                              .delete();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Donation Deleted'),
                            ),
                          );
                          Navigator.pop(context);
                        } else {
                          _getData();
                          FirebaseFirestore.instance
                              .collection('donations')
                              .doc(widget.snap.id)
                              .update({
                            'requests': FieldValue.arrayUnion(
                                [FirebaseAuth.instance.currentUser!.uid])
                          });
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({
                            'requests': FieldValue.arrayUnion([widget.snap.id])
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Request Sent'),
                            ),
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                          FirebaseAuth.instance.currentUser!.uid == donation.uid
                              ? "Delete Donation"
                              : "Request")),
                  const Spacer(),
                ],
              ),
              Flexible(
                flex: 7,
                child: Container(),
              )
            ]),
      ),
    );
  }
}
