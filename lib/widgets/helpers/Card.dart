import 'package:flutter/material.dart';
import 'package:mydoctor/widgets/Main/Profile/Facility/Facility_home.dart';

class MyCard extends StatelessWidget {
  MyCard({Key? key, required this.image, required this.title, required this.id})
      : super(key: key);
  String image;
  String id;
  String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Facility_home(
                      id: id,
                    )));
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: Stack(
          children: [
            ClipRRect(
              child: Image.network(
                image,
                height: 150,
                width: 180,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 150,
              width: 180,
              child: Text(""),
            ),
            Positioned(
                top: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        title,
                        style: TextStyle(
                            color: Color.fromARGB(228, 255, 255, 255),
                            fontSize: 24),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
