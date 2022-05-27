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
                            setState(() {
                              providedAccount.isChanged();
                              setState(() {
                                isFetched = false;
                              });
                            });
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

  Widget Facility_widget(BuildContext context, Account providedAccount) {
    if (!isFetched) {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(facility.address),
                      MaterialButton(
                        onPressed: () {
                          MyMapLauncher.openMapsSheet(context, facility.name,
                              facility.latitude, facility.longitude);
                        },
                        child: Text("see it on map"),
                      ),
                    ],
                  ),
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
                  Patients(context, providedAccount),
                ],
              ),
            ),
          ],
        ),
      );
    }
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
        centerTitle: true,
        elevation: 0,
        actions: [
          MaterialButton(
            child: Text("Create Order"),
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
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                                  fillColor: Color.fromARGB(168, 240, 240, 240),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate() &&
                                          selected_date != "select date") {
                                        creedentials["Description"] =
                                            descriptionController.text;
                                        creedentials["date"] = selected_date;
                                        creedentials["patient"] =
                                            providedAccount.getid();
                                        creedentials["facility"] = widget.id;
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
                                                BorderRadius.circular(10)),
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
          ),
        ],
      ),
      body: Container(
        child: Facility_widget(context, providedAccount),
      ),
    );
  }
}
