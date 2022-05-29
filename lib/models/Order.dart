class Order {
  String id;
  String date;
  String description;
  String patient;
  String facility;

  Order(
      {this.id = "",
      this.date = "",
      this.description = "",
      this.patient = "",
      this.facility = ""});
}

class Orders {
  String id;
  String date;

  Orders({this.id = "", this.date = ""});
}
