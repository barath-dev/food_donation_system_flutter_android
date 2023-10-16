// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';

class RedirectScreen extends StatelessWidget {
  const RedirectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum: EdgeInsets.all(2),
        child: Scaffold(
          body: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Flexible(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(126, 132, 107, 1),
                      borderRadius: BorderRadius.circular(25)),
                  height: double.infinity,
                  width: double.infinity,
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/donate_food.png",
                        height: 50,
                        width: 50,
                      ),
                    ],
                  )),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Flexible(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(165, 174, 158, 1),
                      borderRadius: BorderRadius.circular(25)),
                  height: double.infinity,
                  width: double.infinity,
                  child: Center(child: const Text("world")),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ));
  }
}
