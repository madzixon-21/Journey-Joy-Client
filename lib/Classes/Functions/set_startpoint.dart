import 'package:http/http.dart' as http;

class SetStartPoint{
  Future<http.Response?> patch(tripId, attractionId, token) async {

    final response = await http.patch(
      Uri.parse('https://journeyjoy-app.azurewebsites.net/trips/$tripId/$attractionId'), 
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }
}