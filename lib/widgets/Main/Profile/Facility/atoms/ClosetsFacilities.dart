import 'package:flutter/material.dart';
import 'package:mydoctor/widgets/helpers/Card.dart';

class ClosetsFacilities extends StatefulWidget {
  const ClosetsFacilities({Key? key}) : super(key: key);

  @override
  State<ClosetsFacilities> createState() => _ClosetsFacilitiesState();
}

class _ClosetsFacilitiesState extends State<ClosetsFacilities> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          MyCard(
            id: "1a562564250f4f02835d0c9b31b59884",
            image:
                "https://facilityexecutive.com/wp-content/uploads/2019/08/healthcare_facilities_trends-550x300.png",
            title: "Chikh ZAID",
          ),
        ],
      ),
    );
  }
}
