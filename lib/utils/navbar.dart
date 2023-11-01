// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodsarv01/screen/donor/create_donation.dart';
import 'package:foodsarv01/screen/donor/profile_screen.dart';
import 'package:foodsarv01/screen/donor/view_donations.dart';

List<Widget> pages_donate = [
  CreateDonationScreen(),
  ViewDonation(
    isMine: true,
  ),
  ProfileScreen()
];
List<Widget> pages_recieve = [
  ViewDonation(
    isMine: false,
  ),
  ProfileScreen()
];

class NavBar extends StatefulWidget {
  final bool isDonate;
  const NavBar({super.key, required this.isDonate});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _pageIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void navigatonTapped(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void onpageChanged(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: widget.isDonate ? pages_donate : pages_recieve,
        onPageChanged: onpageChanged,
        controller: _pageController,
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _pageIndex,
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              backgroundColor: _pageIndex == 0
                  ? const Color.fromARGB(255, 139, 145, 149)
                  : Colors.grey[500]),
          BottomNavigationBarItem(
              icon: Icon(Icons.rice_bowl_rounded),
              backgroundColor:
                  _pageIndex == 1 ? Colors.blue : Colors.grey[500]),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_rounded),
              backgroundColor:
                  _pageIndex == 2 ? Colors.blue : Colors.grey[500]),
        ],
        onTap: navigatonTapped,
      ),
    );
  }
}
