import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodsarv01/models/donation.dart';

class ViewAcceptScreen extends StatefulWidget {
  final DocumentSnapshot snap;
  final bool isMine;
  const ViewAcceptScreen({super.key, required this.snap, required this.isMine});

  @override
  State<ViewAcceptScreen> createState() => _ViewAcceptScreenState();
}

class _ViewAcceptScreenState extends State<ViewAcceptScreen> {
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
                      onPressed: () {},
                      child:  Text(
                          widget.isMine ? "Delete Donation" : "Request")),
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