import 'package:flutter/material.dart';
import 'package:mydoctor/widgets/Main/Profile/Facility/atoms/ClosetsFacilities.dart';
import 'package:mydoctor/widgets/Main/Profile/Facility/atoms/PopularFacilities.dart';
import 'package:mydoctor/widgets/helpers/Card.dart';
import 'package:mydoctor/widgets/helpers/Category.dart';

class helpers {
  static List<Widget> normalHome() {
    List<Widget> widgets = [
      Container(
        padding: EdgeInsets.all(10),
        child: Text(
          "Categories",
          style: TextStyle(color: Colors.grey.shade800, fontSize: 20),
        ),
      ),
      SizedBox(
        height: 50,
        child: ListView(scrollDirection: Axis.horizontal, children: [
          Category(
            icon: Icons.heart_broken_rounded,
            text: "Heart",
          ),
          Category(
            icon: Icons.remove_red_eye,
            text: "Eye",
          ),
          Category(
            icon: Icons.hearing,
            text: "Ear",
          ),
        ]),
      ),
      Container(
        padding: EdgeInsets.all(10),
        child: Text(
          "Popular",
          style: TextStyle(color: Colors.grey.shade800, fontSize: 20),
        ),
      ),
      PopularFacilities()
    ];
    return widgets;
  }
}
