import 'package:flutter/material.dart';
import 'package:mydoctor/models/Facility.dart';
import 'package:mydoctor/widgets/helpers/Card.dart';
import 'package:mydoctor/helpers/db.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  bool isFetchedd = false;
  List<Facility_light> facilities = [];

  Widget Categoryfacilities() {
    if (!isFetchedd) {
      db.FetchPopularFacilities().then((value) {
        if (value != []) {
          setState(() {
            facilities = value;
            isFetchedd = true;
          });
        }
      });
      return Center(
        child: Container(
          child: Image.asset(
            'assets/images/loading2.gif',
            height: 80,
          ),
        ),
      );
    }
    return Expanded(
      flex: 2,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1.2),
        children: [
          ...facilities.map((element) {
            return MyCard(
                id: element.id,
                image: element.images.first,
                title: element.name);
          })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Categoryfacilities();
  }
}
