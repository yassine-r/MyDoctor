import 'package:email_validator/email_validator.dart';
import 'package:mydoctor/helpers/localisation.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mydoctor/providers/account.dart';
import 'package:mydoctor/widgets/helpers/style/MyAppBar.dart';
import '../../../widgets/Main/Profile/login/LoginWidget.dart';
import 'package:provider/provider.dart';
import 'package:mydoctor/helpers/db.dart';

class PatientRegistration extends StatefulWidget {
  const PatientRegistration({Key? key}) : super(key: key);

  @override
  State<PatientRegistration> createState() => _PatientRegistrationState();
}

class _PatientRegistrationState extends State<PatientRegistration> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController adresseController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool ispressed = false;
  bool isSent = false;
  String errorText = "Error";
  final _formKey = GlobalKey<FormState>();

  Map<String, String> creedentials = Map();

  String? myemailValidator(value) {
    if (value == null || value.isEmpty || !EmailValidator.validate(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? myValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Enter a valid data';
    }
    return null;
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
            "",
            style: TextStyle(
                color: Colors.grey.shade800, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: !ispressed
            ? Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    Container(
                        padding: const EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        child: const Text(
                          'Registring ...',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                    isSent
                        ? Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              errorText,
                              style: TextStyle(fontSize: 20, color: Colors.red),
                            ))
                        : Container(),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: fnameController,
                        validator: myValidator,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(168, 240, 240, 240),
                            hintText: "First Name ...",
                            border: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            focusedBorder: outlineInputBorder,
                            errorBorder: outlineInputBorder,
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(Icons.text_fields_rounded),
                            )),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: lnameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(168, 240, 240, 240),
                            hintText: "last Name ...",
                            border: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            focusedBorder: outlineInputBorder,
                            errorBorder: outlineInputBorder,
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(Icons.text_fields_rounded),
                            )),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        validator: myValidator,
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(168, 240, 240, 240),
                            hintText: "Phone ...",
                            border: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            focusedBorder: outlineInputBorder,
                            errorBorder: outlineInputBorder,
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(Icons.phone_rounded),
                            )),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: myemailValidator,
                        controller: emailController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(168, 240, 240, 240),
                            hintText: "Email ...",
                            border: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            focusedBorder: outlineInputBorder,
                            errorBorder: outlineInputBorder,
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(Icons.email_rounded),
                            )),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextFormField(
                        validator: myValidator,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(168, 240, 240, 240),
                            hintText: "Password ...",
                            border: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            focusedBorder: outlineInputBorder,
                            errorBorder: outlineInputBorder,
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(Icons.password_rounded),
                            )),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        validator: myValidator,
                        keyboardType: TextInputType.streetAddress,
                        controller: adresseController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(168, 240, 240, 240),
                            hintText: "Adressee ...",
                            border: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            focusedBorder: outlineInputBorder,
                            errorBorder: outlineInputBorder,
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(Icons.location_city_rounded),
                            )),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        validator: myValidator,
                        keyboardType: TextInputType.number,
                        controller: ageController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(168, 240, 240, 240),
                            hintText: "Age ...",
                            border: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            focusedBorder: outlineInputBorder,
                            errorBorder: outlineInputBorder,
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(Icons.height_rounded),
                            )),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 50,
                          width: 150,
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Ionicons.logo_facebook),
                              Icon(Ionicons.logo_google),
                              Icon(Ionicons.logo_github),
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 50,
                            width: 200,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: ElevatedButton(
                              child: const Text('Register'),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  primary: Colors.teal[700],
                                  elevation: 0),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  creedentials["email"] = emailController.text;
                                  creedentials["password"] =
                                      passwordController.text;
                                  creedentials["fname"] = fnameController.text;
                                  creedentials["lname"] = lnameController.text;
                                  creedentials["address"] =
                                      adresseController.text;
                                  creedentials["phone"] = phoneController.text;
                                  creedentials["age"] = ageController.text;
                                  localisation
                                      .getCurrentLocation()
                                      .then((value) {
                                    if (value != null) {
                                      creedentials["latitude"] =
                                          value.latitude.toString();
                                      print(creedentials["latitude"]);
                                      creedentials["longitude"] =
                                          value.longitude.toString();
                                      setState(() {
                                        ispressed = true;
                                      });

                                      db
                                          .registerPatient(creedentials)
                                          .then((value) {
                                        value.forEach((key, value) {
                                          if (key == "id") {
                                            providedAccount.setId(value);
                                            Navigator.pop(context);
                                          }
                                          if (key == "isFacility") {
                                            bool test = value == "true";
                                            providedAccount.setIsFacility(test);
                                          }
                                          if (key == "msg") {
                                            setState(() {
                                              ispressed = false;
                                              isSent = true;
                                            });
                                          }
                                        });
                                      });
                                    } else {
                                      setState(() {
                                        errorText =
                                            "we can't get your position";
                                        ispressed = false;
                                        isSent = true;
                                      });
                                    }
                                  });
                                }
                              },
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        const Text('Do you have an account ?'),
                        TextButton(
                          child: const Text(
                            'Sign in',
                            style: TextStyle(fontSize: 20, color: Colors.amber),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ],
                ),
              )
            : Center(
                child: Container(
                  child: Image.asset(
                    'assets/images/loading2.gif',
                    height: 80,
                  ),
                ),
              ));
  }
}
