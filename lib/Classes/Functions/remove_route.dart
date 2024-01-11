import 'package:http/http.dart' as http;

class RemoveRoute{
  Future<http.Response?> delete(tripId, token) async {

    final response = await http.delete(
      Uri.parse('https://journeyjoy-app.azurewebsites.net/trips/route/$tripId'), 
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }
}