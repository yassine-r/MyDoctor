import 'package:flutter/material.dart';
import 'package:mydoctor/providers/account.dart';
import 'package:mydoctor/widgets/Main/Profile/Facility/FacilityProfile.dart';
import 'package:mydoctor/widgets/Main/Profile/Patient/PatientProfile.dart';
import 'package:mydoctor/widgets/Main/Profile/login/LoginWidget.dart';

import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mydoctor/models/Facility.dart';
import 'package:mydoctor/helpers/db.dart';
import 'package:mydoctor/widgets/helpers/style/MyAppBar.dart';
import 'package:mydoctor/widgets/helpers/style/MyCarousel.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  bool checkId(String id) {
    if (id == "" || id == null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Account providedAccount = Provider.of<Account>(context);
    String providedId = providedAccount.getid();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey.shade800),
        title: Text(
          "",
          style: TextStyle(
              color: Colors.grey.shade800, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          checkId(providedId)
              ? PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert_rounded,
                    color: Colors.grey[800],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  onSelected: (result) {
                    if (result == 3) {
                      db.logout();
                      providedAccount.setId("");
                      providedAccount.setcanCreateOrder(false);
                    }
                  },
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text(
                            "Logout",
                            style: TextStyle(color: Colors.red),
                          ),
                          value: 3,
                        )
                      ])
              : Container()
        ],
      ),
      body: checkId(providedId)
          ? Container(
              child: Column(
                children: [
                  providedAccount.getIsFacility()
                      ? FacilityProfile(id: providedId)
                      : PatientProfile(id: providedId),
                ],
              ),
            )
          : LoginScreen(),
    );
  }
}
