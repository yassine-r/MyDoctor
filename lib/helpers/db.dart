import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mydoctor/models/Facility.dart';
import 'package:mydoctor/models/Order.dart';
import 'package:mydoctor/models/Patient.dart';

extension IsOk on http.Response {
  bool get ok {
    return (statusCode ~/ 100) == 2;
  }
}

class db {
  static String APIurl = "https://seal-app-kmczw.ondigitalocean.app/api/";
  // static String APIurl = "http://127.0.0.1:8000/api/";

  static Future<Map<String, String>> login(Map<String?, String?> data) async {
    logout();
    var url = Uri.parse(db.APIurl + 'login/');
    Object? httperror;

    try {
      var body = jsonEncode({
        'email': data["email"],
        'password': data["password"],
      });
      var response = await http
          .post(url, body: body, headers: {'Content-Type': 'application/json'});
      if (response.ok) {
        return {
          "isFacility": jsonDecode(response.body)["isFacility"].toString(),
          "id": jsonDecode(response.body)["id"],
        };
      }
    } catch (error) {
      httperror = error;
      print(httperror);
    }
    return {"msg": httperror.toString()};
  }

  static Future<Map<String, String>> registerFacility(
      Map<String, String> data) async {
    var url = Uri.parse(db.APIurl + 'facilities/register/');
    Object? httperror;
    try {
      var body = jsonEncode({
        'email': data["email"],
        'password': data["password"],
        'name': data["name"],
        'address': data["address"],
        'phone': int.parse(data["phone"]!),
        'Description': data["Description"],
        'categories': data["categories"],
        'latitude': double.parse(data["latitude"]!),
        'longitude': double.parse(data["longitude"]!),
        'ratting': 0,
        'price': double.parse(data["price"]!),
      });
      print(body);
      var response = await http
          .post(url, body: body, headers: {'Content-Type': 'application/json'});
      if (response.ok) {
        Map<String?, String?> cred = Map();
        cred["email"] = data["email"];
        cred["password"] = data["password"];
        return login(cred);
      }
    } catch (error) {
      httperror = error;
      print(httperror.toString());
    }
    return {"msg": httperror.toString()};
  }

  static Future<Map<String, String>> registerPatient(
      Map<String, String> data) async {
    var url = Uri.parse(db.APIurl + 'patients/register/');
    Object? httperror;
    try {
      var body = jsonEncode({
        'email': data["email"],
        'password': data["password"],
        'first_name': data["fname"],
        'last_name': data["lname"],
        'address': data["address"],
        'phone': data["phone"],
        'age': data["age"],
        'isFacility': false,
        'latitude': double.parse(data["latitude"]!),
        'longitude': double.parse(data["longitude"]!),
      });
      var response = await http
          .post(url, body: body, headers: {'Content-Type': 'application/json'});
      if (response.ok) {
        Map<String?, String?> cred = Map();
        cred["email"] = data["email"];
        cred["password"] = data["password"];
        return login(cred);
      }
    } catch (error) {
      httperror = error;
      print(httperror.toString());
    }
    return {"msg": httperror.toString()};
  }

  static Future<Facility> FetchFacility(String id) async {
    var url = Uri.parse(db.APIurl + 'facilities/${id}/');

    try {
      var response = await http.get(url);
      var decoded_response = jsonDecode(response.body);
      if (response.ok) {
        Facility facility = Facility(
          id: decoded_response['id'],
          name: decoded_response['name'],
          email: decoded_response['email'],
          desription: decoded_response['Description'],
          phone: decoded_response['phone'],
          price: decoded_response['price'],
          address: decoded_response['address'],
          latitude: decoded_response['latitude'],
          longitude: decoded_response['longitude'],
          ratting: decoded_response['ratting'],
        );
        facility.setOrders(decoded_response['orders']);
        return facility;
      }
    } catch (error) {
      print(error);
    }
    return Facility();
  }

  static Future<Patient> FetchPatient(String id) async {
    var url = Uri.parse(db.APIurl + 'patients/${id}/');

    try {
      var response = await http.get(url);
      var decoded_response = jsonDecode(response.body);
      if (response.ok) {
        Patient patient = Patient(
          id: decoded_response['id'],
          first_name: decoded_response['first_name'],
          last_name: decoded_response['last_name'],
          email: decoded_response['email'],
          phone: decoded_response['phone'],
          age: decoded_response['age'],
          address: decoded_response['address'],
          latitude: decoded_response['latitude'],
          longitude: decoded_response['longitude'],
        );
        patient.setOrders(decoded_response['orders']);
        return patient;
      }
    } catch (error) {
      print(error);
    }
    return Patient();
  }

  static Future<List<Facility_light>> FetchPopularFacilities() async {
    var url = Uri.parse(db.APIurl + 'facilities/popular/');
    List<Facility_light> facilities = [];

    try {
      var response = await http.get(url);
      var decoded_response = jsonDecode(response.body);
      if (response.ok) {
        for (var response_facility in decoded_response) {
          Facility_light facility = Facility_light(
            id: response_facility['id'],
            name: response_facility['name'],
            address: response_facility['address'],
          );
          facilities.add(facility);
        }
      }
    } catch (error) {
      print(error);
    }
    return facilities;
  }

  static Future<List<Facility_light>> FindFacilities(String text) async {
    var url = Uri.parse(db.APIurl + 'facilities/find/$text');
    List<Facility_light> facilities = [];

    try {
      var response = await http.get(url);
      var decoded_response = jsonDecode(response.body);
      if (response.ok) {
        for (var response_facility in decoded_response) {
          Facility_light facility = Facility_light(
            id: response_facility['id'],
            name: response_facility['name'],
            address: response_facility['address'],
          );
          facilities.add(facility);
        }
      }
    } catch (error) {
      print(error);
    }
    return facilities;
  }

  static Future<List<Facility_light>> FindCategoryFacilities(
      String text) async {
    var url = Uri.parse(db.APIurl + 'facilities/category/$text');
    List<Facility_light> facilities = [];

    try {
      var response = await http.get(url);
      var decoded_response = jsonDecode(response.body);
      if (response.ok) {
        for (var response_facility in decoded_response) {
          Facility_light facility = Facility_light(
            id: response_facility['id'],
            name: response_facility['name'],
            address: response_facility['address'],
          );
          facilities.add(facility);
        }
      }
    } catch (error) {
      print(error);
    }
    return facilities;
  }

  static Future<Order> FetchOrder(String id) async {
    var url = Uri.parse(db.APIurl + 'orders/${id}/');

    try {
      var response = await http.get(url);
      var decoded_response = jsonDecode(response.body);
      if (response.ok) {
        Order order = Order(
          id: decoded_response['id'],
          description: decoded_response['Description'],
          date: decoded_response['date'],
          patient: decoded_response['patient'],
          facility: decoded_response['facility'],
        );
        return order;
      }
    } catch (error) {
      print(error);
    }
    return Order();
  }

  static Future<bool> DeleteOrder(String id) async {
    logout();
    var url = Uri.parse(db.APIurl + 'orders/delete/');
    Object? httperror;

    var body = jsonEncode({
      'id': id,
    });
    try {
      var response = await http
          .post(url, body: body, headers: {'Content-Type': 'application/json'});

      if (response.ok) {
        return true;
      }
    } catch (error) {
      httperror = error;
    }
    return false;
  }

  static Future<bool> CreateOrder(Map<String, String> creedentials) async {
    logout();
    var url = Uri.parse(db.APIurl + 'orders/register/');
    Object? httperror;

    var body = jsonEncode({
      'patient': creedentials['patient'],
      'facility': creedentials['facility'],
      'date': creedentials['date'],
      'Description': creedentials['Description'],
    });
    try {
      var response = await http
          .post(url, body: body, headers: {'Content-Type': 'application/json'});

      if (response.ok) {
        return true;
      }
    } catch (error) {
      httperror = error;
    }
    return false;
  }

  static Future<void> logout() async {
    var url = Uri.parse(db.APIurl + 'logout/');
    try {
      var response =
          await http.post(url, headers: {'Content-Type': 'application/json'});
    } catch (error) {
      print(error);
    }
  }
}
