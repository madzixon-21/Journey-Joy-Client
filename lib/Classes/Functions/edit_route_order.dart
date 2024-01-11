/// # Edit route action
/// ## Edits the order of attractions in the trip
/// 
/// Sends a POST request where the request body is a new two-dimensional list of attractions IDs in the 
/// desired order. Returns the http response.

import 'dart:convert';
import 'package:http/http.dart' as http;

class EditRouteAction{
  Future<http.Response?> edit(List<List<String>> attractionsInOrder, String tripId, String token) async {
    
    final response = await http.post(
      Uri.parse('https://journeyjoy-app.azurewebsites.net/trips/editRoute/$tripId'), 
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(attractionsInOrder),
    );

    return response;
  }
}