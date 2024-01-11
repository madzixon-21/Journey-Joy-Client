/// # Add attraction action 
/// ## Adds an attraction to the trip with the corresponding tripId
/// 
/// Creates a request body with the required data and encodes the attraction photo to base64.
/// Sends the POST request and returns a boolean indicating the succes of the action.

import 'package:http/http.dart' as http;
import 'package:journey_joy_client/Classes/attraction.dart';
import 'dart:convert';
import 'dart:typed_data';

class AddAttractionRequest{
  final String name;
  final String description;
  final List<int>? imageBytes;
  late String base64Picture;
  final String timeNeeded;
  final Address address;
  final String attractionId;
  final List<List<String>> openingHours;
  final List<String> prices;
  late AttractionToAdd attraction;

  AddAttractionRequest( this.name, this.address, this.description, this.imageBytes, this.timeNeeded, this.openingHours, this.prices, this.attractionId){ 
    if (imageBytes != null) {
      base64Picture = base64Encode(Uint8List.fromList(imageBytes!));
    }
    else{
      base64Picture = '';
    }
    
    attraction = AttractionToAdd(
      name: name,
      description: description,
      photo: base64Picture,
      location: address,
      tripAdvisorLocationId: attractionId,
      locationType: 0,
      openHours: openingHours,
      prices: prices,
      timeNeeded: int.parse(timeNeeded),
      isStartPoint: false,
    );
  }
}

class AddAttractionAction{
  
  Future<bool> add(name, address, description, photo, timeNeeded, openingHours, prices,  attractionId, tripId, token) async {

    AddAttractionRequest request = AddAttractionRequest(name, address, description, photo, timeNeeded, openingHours, prices, attractionId);

    final response = await http.post(
      Uri.parse('https://journeyjoy-app.azurewebsites.net/trips/$tripId'), 
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(request.attraction),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}