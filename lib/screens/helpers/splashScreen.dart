// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';

import '../HomePageScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePageScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xff011824),
        body: Container(
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                    ),
                  ],
                ),
                Image.asset(
                  'assets/images/loading.gif',
                  height: 80,
                )
              ]),
        ),
      ),
    );
  }
}
