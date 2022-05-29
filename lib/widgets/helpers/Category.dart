import 'package:flutter/material.dart';
import 'package:mydoctor/screens/Home/Category_Screen.dart';

class Category extends StatelessWidget {
  Category({Key? key, required this.text, required this.icon})
      : super(key: key);
  String text;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryScreen(
                      category: text,
                    )));
      },
      child: Container(
          width: 70,
          child: Column(
            children: [
              Icon(
                icon,
                color: Colors.grey,
              ),
              Text(text)
            ],
          )),
    );
  }
}
