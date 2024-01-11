import 'package:http/http.dart' as http;

class DeleteAttraction{
  Future<http.Response?> delete(tripId, attractionId, token) async {

    final response = await http.delete(
      Uri.parse('https://journeyjoy-app.azurewebsites.net/trips/$tripId/$attractionId'), 
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }
}