// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';

Column tile() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        'title',
        style: TextStyle(color: Colors.grey[200]),
        textAlign: TextAlign.left,
      ),
      Text('subtitle',
          style: TextStyle(color: Colors.grey[700]), textAlign: TextAlign.left),
    ],
  );
}
