import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mydoctor/helpers/map.dart';
import 'package:mydoctor/models/Facility.dart';
import 'package:mydoctor/helpers/db.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:mydoctor/providers/account.dart';
import 'package:mydoctor/widgets/helpers/style/MyAppBar.dart';
import 'package:mydoctor/widgets/helpers/style/MyCarousel.dart';
import 'package:provider/provider.dart';
import '../../../../helpers/db.dart';

const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12)),
  borderSide: BorderSide.none,
);

class Facility_home extends StatefulWidget {
  Facility_home({Key? key, required this.id}) : super(key: key);
  String id;

  static String name = "Facility_home";

  @override
  State<Facility_home> createState() => _Facility_homeState();
}

class _Facility_homeState extends State<Facility_home> {
  Facility facility = Facility();
  bool isFetched = false;
  int numberPatients = 0;
  bool isSent = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController descriptionController = TextEditingController();

  Widget Patients(context, Account providedAccount) {
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
                  title: Text("Patient NR:${numberPatients}"),
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

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Create Ordre"),
      content: Text(
          "you are Not allowed to create an order. try to login with a patient account"),
      actions: [],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String selected_date = "select date";
    Map<String, String> creedentials = Map();
    Account providedAccount = Provider.of<Account>(context);
    if (!isFetched) {
      db.FetchFacility(widget.id).then((value) {
        facility = value;
        if (facility.id != "") {
          setState(() {
            isFetched = true;
          });
        } else {
          Navigator.pop(context);
        }
      });
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey.shade800),
        title: Text(
          facility.name,
          style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
        ),
        centerTitle: false,
        elevation: 0,
        actions: [
          isFetched
              ? MaterialButton(
                  onPressed: () {
                    MyMapLauncher.openMapsSheet(context, facility.name,
                        facility.latitude, facility.longitude);
                  },
                  child: Text(
                    "See it on Map",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                )
              : Container(),
          isFetched
              ? MaterialButton(
                  child: Text(
                    "Create Order",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    if (providedAccount.getcanCreateOrder() == false) {
                      showAlertDialog(context);
                    } else {
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
                            height: 350,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: EdgeInsets.all(10),
                                      child: const Text(
                                        'Create Order',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: TextButton.icon(
                                        icon: Icon(Icons.date_range_rounded,
                                            color: Colors.grey.shade900),
                                        onPressed: () {
                                          DatePicker.showDateTimePicker(context,
                                              showTitleActions: true,
                                              minTime: DateTime.now(),
                                              maxTime: DateTime(2023, 12, 31),
                                              onConfirm: (date) {
                                            setState(() {
                                              selected_date = date.toString();
                                            });
                                          },
                                              currentTime: DateTime.now(),
                                              locale: LocaleType.en);
                                        },
                                        label: Text(
                                          selected_date,
                                          style: TextStyle(
                                              color: Colors.grey.shade900,
                                              fontSize: 18),
                                        )),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: TextFormField(
                                      maxLines: 5,
                                      keyboardType: TextInputType.multiline,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter a valid data';
                                        }
                                        return null;
                                      },
                                      controller: descriptionController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor:
                                            Color.fromARGB(168, 240, 240, 240),
                                        hintText: "Description ...",
                                        border: outlineInputBorder,
                                        enabledBorder: outlineInputBorder,
                                        focusedBorder: outlineInputBorder,
                                        errorBorder: outlineInputBorder,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        height: 50,
                                        width: 150,
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                    .validate() &&
                                                selected_date !=
                                                    "select date") {
                                              creedentials["Description"] =
                                                  descriptionController.text;
                                              creedentials["date"] =
                                                  selected_date;
                                              creedentials["patient"] =
                                                  providedAccount.getid();
                                              creedentials["facility"] =
                                                  widget.id;
                                              await db.CreateOrder(creedentials)
                                                  .then((value) {
                                                if (value) {
                                                  print(creedentials);
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    isFetched = false;
                                                  });
                                                } else {
                                                  setState(() {
                                                    descriptionController.text =
                                                        "Error";
                                                  });
                                                }
                                              });
                                            } else {
                                              setState(() {
                                                descriptionController.text =
                                                    "Select a valid date";
                                              });
                                            }
                                          },
                                          child: Text('Register'),
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              primary: Colors.redAccent,
                                              elevation: 0),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                )
              : Container(),
        ],
      ),
      body: Container(
        child: Facility_widget(context, providedAccount),
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

  Widget Facility_widget(BuildContext context, Account providedAccount) {
    bool modify = false;
    double height = (MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom -
        40);
    if (!isFetched) {
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
            buildTextField("ratting", facility.ratting.toString(), modify),
            buildTextField("Description", facility.desription, modify),
            Text(
              "Appointments",
              style: TextStyle(fontSize: 20),
            ),
            facility.orders.isEmpty
                ? Center(
                    child: Image.asset(
                    "assets/images/empty.png",
                    height: 200,
                  ))
                : Patients(context, providedAccount),
          ],
        ),
      );
    }
  }
}
