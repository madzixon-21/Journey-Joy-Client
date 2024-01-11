import 'dart:convert';
import 'package:http/http.dart' as http;

// class EditRouteRequest {
//   final List<List<String>> attractionsInOrder;

//   EditRouteRequest(this.attractionsInOrder);

//   Map<String, dynamic> toJson() {
//     return {
//       'attractionsInOrder': attractionsInOrder.map((attractions) => attractions.map((id) => id).toList()).toList(),
//     };
//   }
  
// }


class EditRouteAction{
  Future<http.Response?> edit(List<List<String>> attractionsInOrder, String tripId, String token) async {
    
    //final EditRouteRequest request = EditRouteRequest(attractionsInOrder);
    final response = await http.post(
      Uri.parse('https://journeyjoy-app.azurewebsites.net/trips/editRoute/$tripId'), 
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(attractionsInOrder),
    );
    print(jsonEncode(attractionsInOrder));

    return response;
  }
}