// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mydoctor/models/Facility.dart';
import 'package:mydoctor/helpers/db.dart';
import 'package:mydoctor/models/Order.dart';
import 'package:mydoctor/providers/account.dart';
import 'package:mydoctor/widgets/helpers/style/MyAppBar.dart';
import 'package:mydoctor/widgets/helpers/style/MyCarousel.dart';
import 'package:provider/provider.dart';
import '../../../helpers/db.dart';

const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12)),
  borderSide: BorderSide.none,
);

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
  bool modifyOption = false;
  bool orderisFetched = false;
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Account providedAccount = Provider.of<Account>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey.shade800),
        title: Text(
          "Profile",
          style: TextStyle(
              color: Colors.grey.shade800, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          PopupMenuButton(
              icon: Icon(
                Icons.more_vert_rounded,
                color: Colors.grey[800],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              onSelected: (result) {
                if (result == 1) {
                  setState(() {
                    modifyOption = true;
                  });
                }
                if (result == 2) {
                  db.logout();
                  providedAccount.setId("");
                  providedAccount.setcanCreateOrder(false);
                }
              },
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text(
                        "Modify",
                        style: TextStyle(color: Colors.cyan.shade900),
                      ),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.red),
                      ),
                      value: 2,
                    )
                  ])
        ],
      ),
      body: Container(
        child: Facility_widget(context, providedAccount, modifyOption),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder, bool modify,
      {int maxline = 1}) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        maxLines: maxline,
        decoration: InputDecoration(
            enabled: modify,
            filled: true,
            fillColor: Color.fromARGB(168, 240, 240, 240),
            border: outlineInputBorder,
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            errorBorder: outlineInputBorder,
            labelText: labelText,
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.black,
            )),
      ),
    );
  }

  Widget Facility_widget(
      BuildContext context, Account providedAccount, bool modify) {
    double height = (MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom -
        40);
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
        height: height,
        padding: EdgeInsets.only(left: 16, top: 0, right: 16),
        child: ListView(
          children: [
            SizedBox(
              height: 35,
            ),
            !modify
                ? Center(
                    child: Image.asset(
                    "assets/images/hospital_profile.png",
                    height: 200,
                  ))
                : Container(),
            buildTextField("Name", facility.name, modify),
            buildTextField("Phone", "0" + facility.phone.toString(), modify),
            buildTextField("E-mail", facility.email, modify),
            buildTextField("Address", facility.address, modify),
            buildTextField("Consultation Price",
                facility.price.toString() + " mad", modify),
            !modify
                ? buildTextField("ratting", facility.ratting.toString(), modify)
                : Container(),
            buildTextField("Description", facility.desription, modify),
            !modify
                ? Text(
                    "Appointments",
                    style: TextStyle(fontSize: 20),
                  )
                : Container(),
            facility.orders.isEmpty
                ? modify
                    ? Container()
                    : Center(
                        child: Image.asset(
                        "assets/images/empty.png",
                        height: 200,
                      ))
                : modify
                    ? Container()
                    : Patients(context, providedAccount),
            modify
                ? MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      setState(() {
                        modifyOption = false;
                      });
                    },
                    child: Text("Save"),
                  )
                : Container()
          ],
        ),
      );
    }
  }

  Widget Patients(context, Account providedAccount) {
    TextEditingController descriptionController = TextEditingController();
    if (facility.orders.isNotEmpty) {
      return Column(
        children: [
          ...facility.orders.map((e) {
            numberPatients = numberPatients + 1;
            return Container(
              margin: EdgeInsets.all(10),
              child: Material(
                elevation: 0,
                color: Color.fromARGB(44, 255, 82, 82),
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
                    Order order = Order();
                    db.FetchOrder(e["id"]).then((value) {
                      order = value;
                      if (order.patient != "") {
                        showModalBottomSheet<void>(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          )),
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              decoration: BoxDecoration(),
                              height: 500,
                              child: ListView(
                                children: <Widget>[
                                  Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: EdgeInsets.all(10),
                                      child: Text(
                                        'Appointment details',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color.fromARGB(
                                                197, 255, 82, 82),
                                            fontWeight: FontWeight.w700),
                                      )),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 0, right: 10, left: 10, bottom: 0),
                                    child: buildTextField(
                                        "Date", order.date, false),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 0,
                                        right: 10,
                                        left: 10,
                                        bottom: 10),
                                    child: buildTextField(
                                        "Description", order.description, false,
                                        maxline: 5),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 0,
                                        right: 10,
                                        left: 10,
                                        bottom: 10),
                                    child: TextButton(
                                      child: Text(
                                        "Patient details",
                                        style: TextStyle(
                                            color: Colors.grey.shade900,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      onPressed: () {
                                        db.FetchPatient(order.patient)
                                            .then((patient) {
                                          if (patient.first_name != "") {
                                            showModalBottomSheet<void>(
                                                context: context,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight: Radius.circular(15),
                                                )),
                                                builder:
                                                    (BuildContext context) {
                                                  return Container(
                                                      decoration:
                                                          BoxDecoration(),
                                                      height: 500,
                                                      child: ListView(
                                                        children: <Widget>[
                                                          Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              margin: EdgeInsets
                                                                  .all(10),
                                                              child: Text(
                                                                'Patient details',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            197,
                                                                            255,
                                                                            82,
                                                                            82),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              )),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 0,
                                                                    right: 10,
                                                                    left: 10,
                                                                    bottom: 10),
                                                            child: buildTextField(
                                                                "Patient Name",
                                                                patient.first_name +
                                                                    " " +
                                                                    patient
                                                                        .last_name,
                                                                false),
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 0,
                                                                    right: 10,
                                                                    left: 10,
                                                                    bottom: 10),
                                                            child: buildTextField(
                                                                "Patient age",
                                                                patient.age
                                                                    .toString(),
                                                                false),
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 0,
                                                                    right: 10,
                                                                    left: 10,
                                                                    bottom: 10),
                                                            child: buildTextField(
                                                                "Patient Phone",
                                                                "0" +
                                                                    patient
                                                                        .phone
                                                                        .toString(),
                                                                false),
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 0,
                                                                    right: 10,
                                                                    left: 10,
                                                                    bottom: 10),
                                                            child: buildTextField(
                                                                "Patient Email",
                                                                patient.email,
                                                                false),
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 0,
                                                                    right: 10,
                                                                    left: 10,
                                                                    bottom: 10),
                                                            child: buildTextField(
                                                                "Patient address",
                                                                patient.address,
                                                                false),
                                                          ),
                                                        ],
                                                      ));
                                                });
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    });
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
}
