// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';

Column tile({
  required String title,
  required String subtitle,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
        textAlign: TextAlign.left,
      ),
      Text(subtitle,
          style: TextStyle(color: Colors.grey[600]), textAlign: TextAlign.left),
    ],
  );
}
