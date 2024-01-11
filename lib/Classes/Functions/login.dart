/// # Log in action
/// ## Sends the POST request to log in
/// 
/// Creates a request body with the email and password and sends the POST request.
/// Returns the http response.

import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginRequest {
  final String email;
  final String password;

  LoginRequest(this.email, this.password);

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  } 
}

class LoginAction {
  Future<http.Response?> login(String email, String password) async {
    final LoginRequest user = LoginRequest(email, password);
    final response = await http.post(
      Uri.parse('https://journeyjoy-app.azurewebsites.net/users/login'), 
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user),
    );

    return response;
  }
}