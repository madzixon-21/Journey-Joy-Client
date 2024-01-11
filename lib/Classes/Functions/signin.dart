/// # Sign in action
/// 
/// Creates a request body with the new user's nickname, password and email and sends the POST request.
/// Returns the http response.

import 'dart:convert';
import 'package:http/http.dart' as http;

class SignInRequest{
  final String nickname;
  final String password;
  final String email;

  SignInRequest(this.nickname, this.password, this.email);

  Map<String, dynamic> toJson() {
    return {
      'nickname': nickname,
      'password': password,
      'email': email,
    };
  }
}

class SignInAction{

  Future<http.Response?> signIn(String nickname, String password, String email) async {
    final SignInRequest newUser = SignInRequest(nickname, password, email);
    final response = await http.post(
      Uri.parse('https://journeyjoy-app.azurewebsites.net/users/register'), 
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(newUser),
    );

    return response;
  }
}