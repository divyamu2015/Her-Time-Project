import 'dart:convert';
import 'dart:io';

import 'package:her_time_project/authantication/registration_screen/registration_page_model.dart';
import 'package:her_time_project/constant_uri.dart';
import 'package:http/http.dart' as http;

Future<PatientRegModel> userRegister({
  // required String id,
  required String name,
  required String password,
  required String email,
  required int phone,
  required String address,
 required int age,
}) async {
  try {
    
    final Map<String, dynamic> body = {
      "name": name,
      "password": password,
      "email": email,
      "phone": phone,
      "address": address,
     "age": age,
     // "role": "patient", // Assuming role is always 'patient' for registration
    }; 
    final res = await http.post(
      Uri.parse(Urlsss.registerUrl),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    final Map<String, dynamic> decoded = jsonDecode(res.body);
    print(res.body);

    if (res.statusCode == 200 || res.statusCode == 201) {
      print(res.statusCode);
      //  final Map<String, dynamic> decoded = jsonDecode(res.body);
      final response = PatientRegModel.fromJson(decoded);
      return response;
    } else {
      throw Exception("Failed to register user: ${res.statusCode}");
    }
  } on SocketException {
    throw Exception('Server Error');
  } on HttpException {
    throw Exception('Something went wrong');
  } on FormatException {
    throw Exception('Bad Request');
  } catch (e) {
    throw Exception(e.toString());
  }
}
