// ignore_for_file: non_constant_identifier_names

class Patient {
  String id;
  String first_name;
  String last_name;
  int age;
  String email;
  int phone;
  String address;
  double latitude;
  double longitude;
  String password = "";
  List<dynamic> orders = [];

  Patient(
      {this.id = "",
      this.first_name = "",
      this.last_name = "",
      this.email = "",
      this.phone = 0,
      this.latitude = 0,
      this.longitude = 0,
      this.address = "",
      this.age = 0});

  void setOrders(List<dynamic> orderss) {
    orderss.forEach((orders) {
      this.orders.add(orders);
    });
  }
}
