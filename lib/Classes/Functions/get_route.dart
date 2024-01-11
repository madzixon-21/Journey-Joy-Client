/// # Create route action
/// ## Creates a planned route for the attractions in the trip
/// 
/// Creates a request body with the number of days the user has for the trip and the day of the week
/// when the trip must start. Returns the http response.

import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateRouteRequest{
  final int numberOfDays; 
  final int startDay;

  CreateRouteRequest(this.numberOfDays, this.startDay);

  Map<String, dynamic> toJson() {
    return {
      'numberOfDays': numberOfDays,
      'startDay': startDay,
    };
  }
}
class CreateRoute{
  Future<http.Response?> create(numberOfDays, startDay, tripId, token) async {
    CreateRouteRequest request = CreateRouteRequest(numberOfDays, startDay);
    
    final response = await http.post(
      Uri.parse('https://journeyjoy-app.azurewebsites.net/trips/route/$tripId'), 
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(request),
    );

    return response;
  }
}