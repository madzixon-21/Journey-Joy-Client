/// # Trip class
/// ## Contains trip and route
/// 
/// The trip class contains all the trip related data, including the list of attractions to visit.
/// The route class is used in the trip class to store information about the planned visiting order.

import 'package:journey_joy_client/Classes/attraction.dart';
import 'dart:convert';
import 'dart:typed_data';

class Trip{
    final String id;
    final String userID;
    final String name;
    final String description;
    final Uint8List picture;
    final List<AttractionToAdd> attractions;
    final Route route;

    Trip({
      required this.id,
      required this.userID,
      required this.name,
      required this.description,
      required this.picture,
      required this.attractions,
      required this.route,
    });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'] ?? '',
      userID: json['userID'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      picture: json['picture'] != null
          ? base64Decode(json['picture'])
          : Uint8List(0),
       attractions: (json['attractions'] as List<dynamic>?)
        ?.map((attractionJson) => AttractionToAdd.fromJson(attractionJson))
        .toList() ??
        [],
        route: Route.fromJson(json['route'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userID': userID,
      'name': name,
      'description': description,
      'picture': picture.isNotEmpty ? base64Encode(picture) : null,
      'attractions': attractions.map((attraction) => attraction.toJson()).toList(),
      'route': route.toJson(),
    };
  }
}

class Route{
  final String id;
  final int startDay;
  final List<List<String>> attractionsInOrder;
  final String startPointAttractionId;

  Route({
    required this.id,
    required this.startDay,
    required this.attractionsInOrder,
    required this.startPointAttractionId,
  });

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      id: json['id'] ?? '',
      startDay: json['startDay'] ?? 0,
     attractionsInOrder: (json['attractionsInOrder'] as List<dynamic>?)
      ?.map<List<String>>((attractionList) =>
        (attractionList as List<dynamic>?)
          ?.map<String>((attractionId) => attractionId?.toString() ?? "")
          .toList() ?? [])
      .toList() ?? [],
      startPointAttractionId: json['starePointAttractionId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startDay': startDay,
      'attractionsInOrder': attractionsInOrder,
      'startPointAttractionId': startPointAttractionId,
    };
  }
}

