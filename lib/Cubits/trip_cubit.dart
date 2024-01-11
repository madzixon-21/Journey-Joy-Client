/// # Trip cubit
/// ## Cubit for fetching trips for the user
/// 
/// Includes three states: TripssData, TripssLoading, TripsError.
/// TripsData: contains the fetched list of trips.
/// TripsLoading: is used for displaying a circular progress indicator.
/// TripsError: contains an error message.

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journey_joy_client/Classes/trip.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TripsCubit extends Cubit<TripsState>{
    TripsCubit() : super(TripsLoading());

    Future<void> fetch(String token) async {
        emit(TripsLoading());

        try {
          final response = await http.get(
            Uri.parse('https://journeyjoy-app.azurewebsites.net/trips'),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          );
          if (response.statusCode == 200) {
            if(response.body.isNotEmpty){
              final List<Trip> tripsList = (json.decode(response.body) as List)
                  .map((tripJson) => Trip.fromJson(tripJson))
                  .toList();

              emit(TripsData(trips: tripsList));
            }
             else{
               List<Trip> trips= List.empty();
               emit(TripsData(trips: trips));
            }

          } else {
            emit(TripsError(message: 'Failed to fetch trips'));
          }
        } catch (error) {
          emit(TripsError(message: 'Failed to fetch trips: $error'));
        }
      }


    void removeTrip(String tripId, String token) async {
      if (state is TripsData) {
        try {
          final response = await http.delete(
            Uri.parse('https://journeyjoy-app.azurewebsites.net/trips/$tripId'),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          );
          emit(TripsLoading());
          if (response.statusCode == 200) {
            await fetch(token);
          } else {
            emit(TripsError(message: 'Failed to remove trip:$tripId'));
          }
        } catch (error) {
          emit(TripsError(message: 'Failed to remove trip: $error'));
        }
      }
    }
}

sealed class TripsState{}

class TripsData extends TripsState{

  List<Trip> trips;

  TripsData({ required this.trips}) : super();

}

class TripsLoading extends TripsState{}

class TripsError extends TripsState {
  final String message;

  TripsError({required this.message});
}