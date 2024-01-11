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
    print(jsonEncode(request));
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