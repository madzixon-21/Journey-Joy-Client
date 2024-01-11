/// # Attraction classes
/// ## Contains Attraction, AttractionToAdd and Adress classes
/// 
/// Attraction: attraction class used to get only the essential data from tripAdvisor
/// AttractionToAdd: attraction class used for attractions that will be part of the trip. 
///                  Contains all the necessary data for the planning algorithm
/// Address: address class used in both attraction classes

import 'package:flutter/material.dart';

class Attraction {
  final int locationId;
  final String name;
  final String distance;
  final String rating;
  final String bearing;
  final Address address;
  final String imgUrl;

  Attraction({
    required this.locationId,
    required this.name,
    required this.distance,
    required this.rating,
    required this.bearing,
    required this.address,
     this.imgUrl = '',
  });

  factory Attraction.fromJson(Map<String, dynamic> json) {
    return Attraction(
      locationId: json['locationId'] ?? 0,
      name: json['name'] ?? '',
      distance: json['distance'] ?? '',
      rating: json['rating'] ?? '',
      bearing: json['bearing'] ?? '',
      address: Address.fromJson(json['address'] ?? {}),
      imgUrl: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'locationId': locationId,
      'name': name,
      'distance': distance,
      'rating': rating,
      'bearing': bearing,
      'address': address.toJson(),
      'imgUrl': imgUrl,
    };
  }
}

class Address {
  final String street1;
  final String city;
  final String state;
  final String country;
  final String postalcode;
  final String address;
  final String phone;
  final double latitude;
  final double longitude;

  Address({
    required this.street1,
    required this.city,
    required this.state,
    required this.country,
    required this.postalcode,
    required this.address,
    required this.phone,
    required this.latitude,
    required this.longitude,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street1: json['street1'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      postalcode: json['postalcode'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street1': street1,
      'city': city,
      'state': state,
      'country': country,
      'postalcode': postalcode,
      'address': address,
      'phone': phone,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  @override
  String toString() {
    return street1;
  }
}

class AttractionToAdd {
  final String name;
  final String description;
  final String photo;
  final Address location;
  final String tripAdvisorLocationId;
  final int locationType;
  final List<List<String>> openHours;
  final List<String> prices;
  final int timeNeeded;
  final bool isStartPoint;

  AttractionToAdd({
    required this.name,
    required this.description,
    required this.photo,
    required this.location,
    required this.tripAdvisorLocationId,
    required this.locationType,
    required this.openHours,
    required this.prices,
    required this.timeNeeded,
    required this.isStartPoint,
  });

  factory AttractionToAdd.fromJson(Map<String, dynamic> json) {
    return AttractionToAdd(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      photo: json['photo'] ?? '',
      location: Address.fromJson(json['location'] ?? {}),
      tripAdvisorLocationId: json['id'] ?? '',
      locationType: json['locationType'] ?? 0,
      openHours: (json['openHours'] as List<dynamic>?)
          ?.map<List<String>>((hoursList) => (hoursList as List<dynamic>?)
              ?.map<String>((hour) => hour?.toString() ?? "")
              .toList() ?? [])
          .toList() ?? [],
      prices: (json['prices'] as List<dynamic>?)
          ?.map((price) => price.toString())
          .toList() ?? [],
      timeNeeded: json['timeNeeded'] ?? 0,
      isStartPoint: json['isStartPoint'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'photo': photo,
      'location': location.toJson(),
      'tripAdvisorLocationId': tripAdvisorLocationId,
      'locationType': locationType,
      'openHours': openHours,
      'prices': prices,
      'timeNeeded': timeNeeded,
      'isStartPoint': isStartPoint,
    };
  }

}

class RatingWidget extends StatelessWidget {
  final String rating;

  const RatingWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    final int ratingInt = int.tryParse(rating) ?? 0;
    return Row(
      children: List.generate(
        ratingInt,
        (index) => Icon(
          Icons.star,
          color: Colors.grey.shade900,
          size: 12,
        ),
      ),
    );
  }
}