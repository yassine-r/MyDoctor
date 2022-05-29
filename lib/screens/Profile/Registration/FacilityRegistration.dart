import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mydoctor/helpers/fct.dart';
import 'package:mydoctor/helpers/localisation.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'package:mydoctor/providers/account.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:mydoctor/helpers/db.dart';

class FacilityRegistration extends StatefulWidget {
  const FacilityRegistration({Key? key}) : super(key: key);

  @override
  State<FacilityRegistration> createState() => _FacilityRegistrationState();
}

const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12)),
  borderSide: BorderSide.none,
);

class _FacilityRegistrationState extends State<FacilityRegistration> {
  TextEditingController nameController = TextEditingController();
  TextEditingController adresseController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  static List<String> _categories = [
    "Heart",
    "leg",
    "brain",
    "eye",
    "ears",
    "gp",
    "hioj"
  ];
  List<String> _selectedcategories = [];
  final _items = _categories
      .map((category) => MultiSelectItem<String>(category, category))
      .toList();

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
                        validator: myValidator,
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(168, 240, 240, 240),
                            hintText: " Name ...",
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
                        keyboardType: TextInputType.phone,
                        validator: myValidator,
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
                        controller: emailController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !EmailValidator.validate(value)) {
                            return 'Enter a valid email';
                          }
                          print("Email value:" + value.toString());
                          return null;
                        },
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
                        obscureText: true,
                        keyboardType: TextInputType.name,
                        validator: myValidator,
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
                        keyboardType: TextInputType.streetAddress,
                        controller: adresseController,
                        validator: myValidator,
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
                        keyboardType: TextInputType.number,
                        validator: myValidator,
                        controller: priceController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(168, 240, 240, 240),
                            hintText: "Price ...",
                            border: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            focusedBorder: outlineInputBorder,
                            errorBorder: outlineInputBorder,
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(Ionicons.pricetag),
                            )),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: MultiSelectDialogField(
                        items: _items,
                        title: Container(
                            padding: EdgeInsets.all(10),
                            child: Text("Categoies")),
                        selectedColor: Colors.teal[700],
                        decoration: BoxDecoration(
                          color: Color.fromARGB(168, 240, 240, 240),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        buttonIcon: Icon(
                          Icons.face,
                          color: Colors.grey.shade600,
                        ),
                        buttonText: Text(
                          "Domain fields",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 16,
                          ),
                        ),
                        onConfirm: (results) {
                          _selectedcategories = results as List<String>;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        maxLines: 5,
                        keyboardType: TextInputType.multiline,
                        validator: myValidator,
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
                            width: 150,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  primary: Colors.teal[700],
                                  elevation: 0),
                              child: const Text('Register'),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  creedentials["email"] = emailController.text;
                                  creedentials["password"] =
                                      passwordController.text;
                                  creedentials["name"] = nameController.text;
                                  creedentials["address"] =
                                      adresseController.text;
                                  creedentials["phone"] = phoneController.text;
                                  creedentials["Description"] =
                                      descriptionController.text;
                                  creedentials["price"] = priceController.text;
                                  localisation
                                      .getCurrentLocation()
                                      .then((value) {
                                    if (value != null) {
                                      creedentials["latitude"] =
                                          value.latitude.toString();
                                      print(creedentials["latitude"]);
                                      creedentials["longitude"] =
                                          value.longitude.toString();
                                      creedentials["categories"] =
                                          fct.getString(_selectedcategories);
                                      setState(() {
                                        ispressed = true;
                                      });
                                      db
                                          .registerFacility(creedentials)
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
                                              errorText = value;
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
                ))
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
