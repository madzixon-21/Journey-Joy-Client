import 'package:http/http.dart' as http;
import 'package:journey_joy_client/Classes/attraction.dart';
import 'dart:convert';
import 'dart:typed_data';

class EditAttractionRequest{
  final String name;
  final String description;
  final List<int>? imageBytes;
  late String base64Picture;
  final String timeNeeded;
  final Address address;
  final String attractionId;
  final List<List<String>> opening_hours;
  final List<String> prices;
  late AttractionToAdd attraction;

  EditAttractionRequest( this.name, this.address, this.description, this.imageBytes, this.timeNeeded, this.opening_hours, this.prices, this.attractionId){ 
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
      openHours: opening_hours,
      prices: prices,
      timeNeeded: int.parse(timeNeeded),
      isStartPoint: false,
    );
  }

  
}

class EditAttractionAction{
  Future<bool> edit(name, address, description, photo, timeNeeded, opening_hours, prices,  attractionId, tripId, token) async {

    EditAttractionRequest request = EditAttractionRequest(name, address, description, photo, timeNeeded, opening_hours, prices, attractionId);
    print('Request Body jsonEncode: ${jsonEncode(request.attraction)}');
    final response = await http.post(
      Uri.parse('https://journeyjoy-app.azurewebsites.net/trips/$tripId/$attractionId'), 
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(request.attraction),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Request Body jsonEncode: ${jsonEncode(request.attraction)}');
      print('Response: ${response.body}');
      return false;
    }
  }
}