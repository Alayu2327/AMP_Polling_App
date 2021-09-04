import 'dart:convert';

import 'package:polling_app/models/model.dart';
import 'package:http/http.dart' as http;

//Genymotion emulator address 192.168.60.1

class AuthenticationDataProvider {


  Future<User> register(User user) async {
    final http.Response response = await http.post(Uri.parse('http://127.0.0.1:5000/api/v1/users/register'),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "username": user.username,
          "email": user.email,
          "phone_number": user.phone_number,
          "password": user.password,
          "password_confirm":user.password_confirm
        }));

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    }
    {
      throw Exception("Failed to create user");
    }
  }
  
}
