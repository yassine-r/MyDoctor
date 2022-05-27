import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget with PreferredSizeWidget {
  MyAppBar({Key? key, required this.title}) : super(key: key);
  @override
  State<MyAppBar> createState() => _MyAppBarState();
  final double appBarHeight = 50.0;
  String title;
  @override
  get preferredSize => Size.fromHeight(appBarHeight);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.title,
        style: TextStyle(color: Colors.grey.shade800),
      ),
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.grey.shade800),
      elevation: 0,
      backgroundColor: Colors.white,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
        ),
      ],
    );
  }
}
