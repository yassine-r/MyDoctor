import 'package:flutter/material.dart';
import 'package:mydoctor/models/Patient.dart';
import 'package:mydoctor/providers/account.dart';
import 'package:provider/provider.dart';
import 'package:mydoctor/helpers/db.dart';

const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12)),
  borderSide: BorderSide.none,
);

class PatientProfile extends StatefulWidget {
  PatientProfile({Key? key, required this.id}) : super(key: key);
  String id;

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  Patient patient = Patient();
  bool isFetched = false;
  bool modifyOption = false;

  bool checkId(String id) {
    if (id == "" || id == null) {
      return false;
    }
    return true;
  }

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
        child: Patient_Profile_Widget(context, modifyOption),
      ),
    );
  }

  Widget Patient_Profile_Widget(BuildContext context, bool modify) {
    double height = (MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom -
        40);
    Account providedAccount = Provider.of<Account>(context);
    if (!isFetched) {
      db.FetchPatient(widget.id).then((value) {
        patient = value;
        if (patient.id != "") {
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
                    "assets/images/user_profile.png",
                    height: 200,
                  ))
                : Container(),
            buildTextField("First Name", patient.first_name, modify),
            buildTextField("Last Name", patient.last_name, modify),
            buildTextField("E-mail", patient.email, modify),
            buildTextField("Phone", patient.phone.toString(), modify),
            buildTextField("Age", patient.age.toString(), modify),
            buildTextField("Adress", patient.address, modify),
            !modify
                ? Text(
                    "Orders",
                    style: TextStyle(fontSize: 20),
                  )
                : Container(),
            patient.orders.isEmpty
                ? modify
                    ? Container()
                    : Center(
                        child: Image.asset(
                        "assets/images/empty.png",
                        height: 200,
                      ))
                : modify
                    ? Container()
                    : patient_orders(context, providedAccount),
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

  Widget buildTextField(String labelText, String placeholder, bool modify) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
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

  Widget patient_orders(context, Account providedAccount) {
    return Column(
      children: [
        ...patient.orders.map((e) {
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
                title: Text("Order NR:1"),
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
}
