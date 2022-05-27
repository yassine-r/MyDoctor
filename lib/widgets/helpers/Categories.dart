import 'package:flutter/material.dart';
import 'package:mydoctor/widgets/helpers/Category.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Category(),
          Category(),
          Category(),
          Category(),
          Category(),
          Category(),
          Category(),
        ],
      ),
    );
  }
}
