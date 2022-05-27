import 'package:flutter/material.dart';
import 'package:mydoctor/models/Order.dart';

class Facility {
  String id;
  String name;
  String email;
  String desription;
  int phone;
  String address;
  double price;
  double latitude;
  double longitude;
  double ratting;
  String password = "";
  List<String> patients = [];
  List<dynamic> orders = [];
  List<String> images = [
    "https://facilityexecutive.com/wp-content/uploads/2019/08/healthcare_facilities_trends-550x300.png",
    "https://www.cmautah.com/wp-content/uploads/2018/05/Utah-Healthcare-Architecture-Riverton-Medical-Office-Building.jpg"
  ];

  Facility({
    this.id = "",
    this.name = "",
    this.email = "",
    this.desription = "",
    this.phone = 0,
    this.price = 0,
    this.latitude = 0,
    this.longitude = 0,
    this.address = "",
    this.ratting = 0,
  });
  @override
  String toString() {
    return name;
  }

  void setOrders(List<dynamic> orderss) {
    orderss.forEach((orders) {
      this.orders.add(orders);
    });
  }
}

class Facility_light {
  String id;
  String name;
  String address;
  List<String> images = [
    "https://facilityexecutive.com/wp-content/uploads/2019/08/healthcare_facilities_trends-550x300.png",
    "https://www.cmautah.com/wp-content/uploads/2018/05/Utah-Healthcare-Architecture-Riverton-Medical-Office-Building.jpg"
  ];

  Facility_light({
    required this.id,
    required this.name,
    required this.address,
  });
}
