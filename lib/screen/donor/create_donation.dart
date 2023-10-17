// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:foodsarv01/resources/DBMethods.dart';
import 'package:foodsarv01/widgets/textfiled.dart';

List<String> list = <String>['Kg', 'Liter', 'Packet', 'Plate', 'Bottle'];

class CreateDonationScreen extends StatefulWidget {
  const CreateDonationScreen({super.key});

  @override
  State<CreateDonationScreen> createState() => _CreateDonationScreenState();
}

class _CreateDonationScreenState extends State<CreateDonationScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController foodName = TextEditingController();
  TextEditingController foodQuantity = TextEditingController();
  TextEditingController foodDescription = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController foodExpiryTime = TextEditingController();
  TextEditingController foodPickupTime = TextEditingController();
  TextEditingController pickupLocation = TextEditingController();

  DateTime selectedExpiryDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime selectedPickupDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  String dropdownValue = list.first;

  Future<String> uploadDonation() async {
    DBMethods dbMethods = DBMethods();
    if (name.text.isNotEmpty &&
        foodName.text.isNotEmpty &&
        foodQuantity.text.isNotEmpty &&
        foodDescription.text.isNotEmpty &&
        mobile.text.isNotEmpty &&
        pickupLocation.text.isNotEmpty) {
      String res = await dbMethods.addDonationToDB(
          name: name.text,
          foodName: foodName.text,
          quantity: int.parse(foodQuantity.text),
          unit: dropdownValue,
          expiry_time: selectedExpiryDate,
          pickup_time: selectedPickupDate,
          mobile: mobile.text);
      return res;
    }
    return "Please fill all the fields";
  }

  @override
  Widget build(BuildContext context) {
    Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
        initialDate: DateTime.now());

    Future<TimeOfDay?> pickTime() =>
        showTimePicker(context: context, initialTime: TimeOfDay.now());

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextInput(hint: 'Enter your name', controller: name),
            TextInput(hint: 'Food type', controller: foodName),
            Row(
              children: [
                Spacer(),
                TextInput(
                    hint: 'Food Quantity',
                    keybordType: TextInputType.number,
                    width: MediaQuery.of(context).size.width * 0.5,
                    controller: foodQuantity),
                Spacer(),
                DropdownButton<String>(
                  value: dropdownValue,
                  onChanged: (String? value) => {
                    setState(() {
                      dropdownValue = value!;
                    })
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        // style: TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                ),
                Spacer()
              ],
            ),
            TextInput(
                hint: "Food Description",
                maxlines: 3,
                controller: foodDescription),
            TextInput(
                hint: 'Mobile Number',
                keybordType: TextInputType.number,
                controller: mobile),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Text(
                    'Expiry time:',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  ElevatedButton(
                      onPressed: () async {
                        final date = await pickDate();
                        final time = await pickTime();
                        if (date == null) return;
                        if (time == null) return;

                        setState(() {
                          selectedPickupDate = date;
                          selectedPickupDate = DateTime(
                              selectedPickupDate.year,
                              selectedPickupDate.month,
                              selectedPickupDate.day,
                              time.hour,
                              time.minute);
                        });
                      },
                      child: Text(
                          "${selectedPickupDate.year}/${selectedPickupDate.month}/${selectedPickupDate.day}  ${selectedPickupDate.hour}:${selectedPickupDate.minute}")),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Text(
                    'Pickup time:',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  ElevatedButton(
                      onPressed: () async {
                        final date = await pickDate();
                        final time = await pickTime();
                        if (date == null) return;
                        if (time == null) return;

                        setState(() {
                          selectedExpiryDate = date;
                          selectedExpiryDate = DateTime(
                              selectedExpiryDate.year,
                              selectedExpiryDate.month,
                              selectedExpiryDate.day,
                              time.hour,
                              time.minute);
                        });
                      },
                      child: Text(
                          "${selectedExpiryDate.year}/${selectedExpiryDate.month}/${selectedExpiryDate.day}  ${selectedExpiryDate.hour}:${selectedExpiryDate.minute}")),
                ],
              ),
            ),
            TextInput(hint: 'Pick up location', controller: pickupLocation),
            ElevatedButton(
              onPressed: () async {
                String res = await uploadDonation();
                if (res == 'success') {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Donation created')));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(uploadDonation().toString())));
                }
              },
              child: Text("Create Donation"),
            ),
          ],
        ),
      ),
    ));
  }
}
