/// # Create trip action 
/// ## Creates a new trip
/// 
/// Creates a request body with the trip name, description and photo. Encodes the photo to base64.
/// Sends the POST request and returns a boolean indicating the success of the action.

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:typed_data';


class CreateTripRequest {
  final String name;
  final String description;
  final List<int>? imageBytes;
  late String? base64Picture;

  CreateTripRequest(this.name, this.description, this.imageBytes){
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


class CreateTripAction{
  Future<bool> create(String name, String description, List<int>? imageBytes, String token) async {
    
    final CreateTripRequest newTrip = CreateTripRequest(name, description, imageBytes);
    final response = await http.post(
      Uri.parse('https://journeyjoy-app.azurewebsites.net/trips'), 
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(newTrip),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}