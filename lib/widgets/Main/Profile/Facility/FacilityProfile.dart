import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mydoctor/models/Facility.dart';
import 'package:mydoctor/helpers/db.dart';
import 'package:mydoctor/providers/account.dart';
import 'package:mydoctor/widgets/helpers/style/MyAppBar.dart';
import 'package:mydoctor/widgets/helpers/style/MyCarousel.dart';
import 'package:provider/provider.dart';
import '../../../../helpers/db.dart';

class FacilityProfile extends StatefulWidget {
  FacilityProfile({Key? key, required this.id}) : super(key: key);
  String id;

  @override
  State<FacilityProfile> createState() => _FacilityProfileState();
}

class _FacilityProfileState extends State<FacilityProfile> {
  Facility facility = Facility();
  bool isFetched = false;
  int numberPatients = 0;

  Widget Patients(context) {
    Account providedAccount = Provider.of<Account>(context);
    if (facility.orders.isNotEmpty) {
      return Column(
        children: [
          ...facility.orders.map((e) {
            numberPatients = numberPatients + 1;
            return Container(
              margin: EdgeInsets.all(10),
              child: Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(10),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  leading: Icon(Icons.account_circle),
                  subtitle: Text(e["date"]),
                  trailing: IconButton(
                      onPressed: () {
                        db.DeleteOrder(e["id"]).then((value) {
                          if (value == true) {
                            providedAccount.isChanged();
                          }
                        });
                      },
                      icon: Icon(Icons.delete)),
                  title: Text("Patient NR:${numberPatients}"),
                  onTap: () {
                    if (providedAccount.getIsFacility()) {
                      print(e["id"]);
                    }
                  },
                ),
              ),
            );
          }).toList(),
        ],
      );
    }
    return Container(
      child: Column(
        children: [
          Text("empty"),
        ],
      ),
    );
  }

  Widget Facility_widget(BuildContext context) {
    Account providedAccount = Provider.of<Account>(context);
    if (!isFetched) {
      db.FetchFacility(widget.id).then((value) {
        facility = value;
        if (facility.id != "") {
          setState(() {
            isFetched = true;
          });
        } else {
          providedAccount.setId("");
        }
      });
      return LinearProgressIndicator(
        backgroundColor: Colors.white,
      );
    } else {
      return Container(
        height: 500,
        child: ListView(
          children: [
            MyCarousel(images: facility.images),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email",
                    style: TextStyle(
                        color: Color.fromARGB(255, 4, 121, 121),
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(facility.email),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Adresse",
                    style: TextStyle(
                        color: Color.fromARGB(255, 4, 121, 121),
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(facility.address),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Description",
                    style: TextStyle(
                        color: Color.fromARGB(255, 4, 121, 121),
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(facility.desription),
                  Text(
                    "Patients en attente",
                    style: TextStyle(
                        color: Color.fromARGB(255, 4, 121, 121),
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  Patients(context),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Facility_widget(context),
    );
  }
}
