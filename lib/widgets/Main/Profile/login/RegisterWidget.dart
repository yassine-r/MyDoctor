import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mydoctor/providers/account.dart';
import 'package:mydoctor/widgets/helpers/style/MyAppBar.dart';
import '../../../../screens/Profile/Registration/FacilityRegistration.dart';
import './LoginWidget.dart';
import '../../../../screens/Profile/Registration/PatientRegistration.dart';
import 'package:provider/provider.dart';
import 'package:mydoctor/helpers/db.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String type = "Patient";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey.shade800),
        title: Text(
          'Register',
          style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: Image.asset(
                'assets/images/logo2.png',
                height: 300,
              ),
            ),
            Container(
                padding: const EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                child: const Text(
                  'Select Account Type',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                )),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PatientRegistration()));
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    child: Stack(
                      children: [
                        ClipRRect(
                          child: Image.asset(
                            "assets/images/normal_user.jpg",
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
                                    "Normal User",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(228, 255, 255, 255),
                                        fontSize: 24),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FacilityRegistration()));
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    child: Stack(
                      children: [
                        ClipRRect(
                          child: Image.asset(
                            "assets/images/facility_user.jpg",
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
                                    "Hospital",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(228, 255, 255, 255),
                                        fontSize: 24),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
