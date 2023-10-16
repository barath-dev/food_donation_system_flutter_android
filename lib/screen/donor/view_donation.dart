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
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Listtile(),
      ),
    ));
  }
}
