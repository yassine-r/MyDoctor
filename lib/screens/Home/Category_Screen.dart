import 'package:flutter/material.dart';
import 'package:mydoctor/models/Facility.dart';
import 'package:mydoctor/widgets/helpers/Card.dart';
import 'package:mydoctor/helpers/db.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({Key? key, required this.category}) : super(key: key);
  String category;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool isFetchedd = false;
  List<Facility_light> facilities = [];

  Widget Categoryfacilities() {
    if (!isFetchedd) {
      db.FindCategoryFacilities(widget.category).then((value) {
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
    if (facilities.isEmpty) {
      return Center(
        child: Container(
          child: Image.asset(
            'assets/images/Not_found.png',
            height: 500,
          ),
        ),
      );
    }
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1.2),
      children: [
        ...facilities.map((element) {
          return MyCard(
              id: element.id, image: element.images.first, title: element.name);
        })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.grey.shade800),
          title: Text(
            widget.category,
            style: TextStyle(
                color: Colors.grey.shade800, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          elevation: 0),
      body: Container(child: Categoryfacilities()),
    );
  }
}
