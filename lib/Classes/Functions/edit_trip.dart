/// # Edit trip action
/// 
/// Creates a request body with the new desired data and encodes the trip photo to base64.
/// Sends the POST request and returns a boolean indicating the succes of the action.

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

class EditTripRequest {
  final String name;
  final String description;
  final List<int>? imageBytes;
  late String? base64Picture;

  EditTripRequest(this.name, this.description, this.imageBytes){
    if (imageBytes != null) {
      base64Picture = base64Encode(Uint8List.fromList(imageBytes!));
    }
    else{
      base64Picture = null;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'picture': base64Picture,
    };
  }
  
}


class EditTripAction{
  Future<bool> edit(String name, String description, List<int>? imageBytes, String token, String tripId) async {
    
    final EditTripRequest editedTrip = EditTripRequest(name, description, imageBytes);
    final response = await http.post(
      Uri.parse('https://journeyjoy-app.azurewebsites.net/trips/edit/$tripId'), 
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(editedTrip),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}