import 'package:flutter/material.dart';
import 'package:mydoctor/models/Facility.dart';
import 'package:mydoctor/widgets/helpers/Card.dart';
import 'package:mydoctor/helpers/db.dart';

class PopularFacilities extends StatefulWidget {
  const PopularFacilities({Key? key}) : super(key: key);

  @override
  State<PopularFacilities> createState() => _PopularFacilitiesState();
}

class _PopularFacilitiesState extends State<PopularFacilities> {
  bool isFetchedd = false;
  List<Facility_light> facilities = [];

  Widget Popularfacilities() {
    if (!isFetchedd) {
      db.FetchPopularFacilities().then((value) {
        if (value != []) {
          setState(() {
            facilities = value;
            isFetchedd = true;
          });
        }
      });
      print("loading");
      return Center(
        child: Container(
          child: Image.asset(
            'assets/images/loading2.gif',
            height: 80,
          ),
        ),
      );
    }
    print("loaded");
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
    return Popularfacilities();
  }
}
