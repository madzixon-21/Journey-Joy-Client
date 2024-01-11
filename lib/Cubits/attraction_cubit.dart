/// # Attraction cubit
/// ## Cubit for fetching attractions from tripAdvisor
/// 
/// Includes three states: AttractionsData, AttractionsLoading, AttractionsError.
/// AttractionsData: contains the fetched lis of attractions.
/// AttractionsLoading: is used for displaying a circular progress indicator.
/// AttractionsError: contains an error message.

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journey_joy_client/Classes/attraction.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AttractionsCubit extends Cubit<AttractionsState>{
  
  AttractionsCubit() : super(AttractionsLoading());

  Future<void> fetch(String name, String token) async {
    emit(AttractionsLoading());
    try {
      if(name.isNotEmpty){
        final response = await http.get(
          Uri.parse('https://journeyjoy-app.azurewebsites.net/trips/attractions?name=$name'),
            headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          
          final List<dynamic> data = json.decode(response.body);
          final List<Attraction> attractions = data.map((attractionData) {
            return Attraction.fromJson(attractionData);
          }).toList();

          emit(AttractionsData(attractions: attractions));
        }
        else {
          emit(AttractionsError(message: 'Failed to fetch attractions'));
        }
        
      }else{
          final List<Attraction> emptyList = List.empty();
          emit(AttractionsData(attractions: emptyList)); 
      }
    } catch (e) {
      emit(AttractionsError(message: 'An error occurred while fetching attractions'));
    }
  }
}

sealed class AttractionsState{}

class AttractionsData extends AttractionsState{

  List<Attraction> attractions;

  AttractionsData({ required this.attractions}) : super();

}

class AttractionsLoading extends AttractionsState{}

class AttractionsError extends AttractionsState {
  final String message;

  AttractionsError({required this.message});
}