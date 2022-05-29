import 'package:flutter/material.dart';

import './RegisterWidget.dart';
import 'package:provider/provider.dart';
import 'package:mydoctor/helpers/db.dart';
import 'package:mydoctor/providers/account.dart';
import 'package:email_validator/email_validator.dart';

const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12)),
  borderSide: BorderSide.none,
);

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool ispressed = false;
  bool isSent = false;
  String errorText = "invalid credentials";
  final _formKey = GlobalKey<FormState>();
  Map<String, String> creedentials = Map();

  @override
  Widget build(BuildContext context) {
    Account providedAccount = Provider.of<Account>(context);
    return !ispressed
        ? Container(
            child: Center(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
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
                          'Signing in ...',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                    isSent
                        ? Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            child: Text(
                              errorText,
                              style: TextStyle(fontSize: 20, color: Colors.red),
                            ))
                        : Container(),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !EmailValidator.validate(value)) {
                            return 'Enter a valid email';
                          }
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
                              child: Icon(Icons.email),
                            )),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter a valid password';
                          }
                          return null;
                        },
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
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              primary: Colors.amber,
                              elevation: 0),
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 17),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              creedentials["email"] = emailController.text;
                              creedentials["password"] =
                                  passwordController.text;
                              setState(() {
                                ispressed = true;
                              });
                              db.login(creedentials).then((value) {
                                value.forEach((key, value) {
                                  if (key == "id") {
                                    providedAccount.setId(value);
                                  }
                                  if (key == "isFacility") {
                                    bool test = value == "true";
                                    providedAccount.setIsFacility(test);
                                    providedAccount
                                        .setcanCreateOrder(test == false);
                                  }
                                  if (key == "msg") {
                                    setState(() {
                                      ispressed = false;
                                      isSent = true;
                                    });
                                  }
                                });
                              });
                            }
                          },
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        children: <Widget>[
                          const Text(' you don\'t have an account?'),
                          TextButton(
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.teal.shade700),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()));
                            },
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Center(
            child: Container(
              child: Image.asset(
                'assets/images/loading2.gif',
                height: 80,
              ),
            ),
          );
  }
}
