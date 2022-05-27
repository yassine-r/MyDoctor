import 'package:flutter/material.dart';
import 'package:mydoctor/widgets/Main/Home/atoms/NomalHome.dart';

const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12)),
  borderSide: BorderSide.none,
);

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool istapped = false;
  String searchedText = "";
  TextEditingController searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<Widget> childHome() {
    if (istapped) {
      return [Text(searchedText)];
    }
    return helpers.normalHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey.shade800),
        elevation: 0,
        title: Text(
          "Home",
          style: TextStyle(
              color: Colors.grey.shade800, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: searchController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter a valid data';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 237, 237, 237),
                    hintText: "Search ...",
                    border: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                    errorBorder: outlineInputBorder,
                    suffixIcon: Padding(
                        padding: EdgeInsets.all(5),
                        child: IconButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                searchedText = searchController.text;
                                setState(() {
                                  istapped = true;
                                });
                              }
                            },
                            icon: Icon(Icons.search))),
                  ),
                ),
              ),
            ),
            ...childHome()
          ],
        ),
      ),
    );
  }
}
