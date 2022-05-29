import 'package:flutter/material.dart';
import 'package:mydoctor/models/Facility.dart';
import 'package:mydoctor/widgets/helpers/Card.dart';
import 'package:mydoctor/widgets/helpers/Category.dart';
import './atoms/NomalHome.dart';
import 'package:mydoctor/helpers/db.dart';

const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12)),
  borderSide: BorderSide.none,
);

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  bool istapped = false;
  bool isFetchedd = false;
  List<Facility_light> facilities = [];
  String searchedText = "";
  TextEditingController searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Widget Findfacilities() {
    if (!isFetchedd) {
      db.FindFacilities(searchController.text).then((value) {
        if (value.isNotEmpty) {
          setState(() {
            facilities = value;
            isFetchedd = true;
          });
        } else {
          setState(() {
            facilities = [];
            isFetchedd = true;
          });
        }
      });
      return Center(
        child: Container(
          child: Image.asset(
            'assets/images/loading2.gif',
            height: 80,
          ),
        ),
      );
    }
    return Expanded(
      flex: 2,
      child: facilities.isEmpty
          ? Column(
              children: [
                Container(
                  child: Image.asset(
                    'assets/images/Not_found.png',
                  ),
                ),
                Text("Not Found")
              ],
            )
          : GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1.2),
              children: [
                ...facilities.map((element) {
                  return MyCard(
                      id: element.id,
                      image: element.images.first,
                      title: element.name);
                })
              ],
            ),
    );
  }

  List<Widget> childHome() {
    if (istapped) {
      return [Findfacilities()];
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
                      return 'Enter a valid name';
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
                                  isFetchedd = false;
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
