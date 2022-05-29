import 'package:flutter/material.dart';
import 'package:mydoctor/providers/account.dart';
import 'package:mydoctor/screens/Profile/Facility/FacilityProfile.dart';
import 'package:mydoctor/screens/Profile/Patient/PatientProfile.dart';
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

    Widget selectedScreen() {
      if (checkId(providedId)) {
        if (providedAccount.getIsFacility()) {
          return FacilityProfile(id: providedId);
        }
        return PatientProfile(
          id: providedId,
        );
      }
      return LoginScreen();
    }

    return Scaffold(backgroundColor: Colors.white, body: selectedScreen());
  }
}
