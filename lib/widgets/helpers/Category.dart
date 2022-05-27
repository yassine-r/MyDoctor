import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(3),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey), shape: BoxShape.circle),
        child: Column(
          children: [Icon(Icons.heart_broken), Text("heart")],
        ));
  }
}
