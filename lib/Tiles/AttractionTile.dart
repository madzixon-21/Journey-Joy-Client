/// # Attraction Tile 
/// ## Displays the attraction found in Trip Advisor after a search 
/// 
/// Shows the attraction's name and address. Has a plus button that allows the user to add the attraction directly to the trip.

import 'package:flutter/material.dart';
import 'package:journey_joy_client/Classes/attraction.dart';
import 'package:journey_joy_client/Dialogs/add_attraction_dialog.dart';
import 'package:journey_joy_client/Cubits/trip_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttractionTile extends StatelessWidget {
  const AttractionTile({
    super.key,
    required this.attraction,
    required this.tripId,
    required this.token,
  });

  final Attraction attraction;
  final String tripId;
  final String token;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10), 
        ),
        child: Row(
          children: [
            
            const SizedBox(width: 14, height: 80,),
            
            Flexible(
              fit: FlexFit.tight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(attraction.name,
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 15,
                      fontFamily: 'Lohit Tamil',
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                      letterSpacing: 2,
                    ),
                  ),
                  
                  const SizedBox(height: 10,),
                  
                  Text(attraction.address.toString(),
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 13,
                      fontFamily: 'Lohit Tamil',
                      fontWeight: FontWeight.w400,
                      height: 1,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            
            PlusButton(attraction: attraction, tripId: tripId, token: token),

            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}

class PlusButton extends StatelessWidget {

  const PlusButton({super.key, required this.attraction, required this.tripId, required this.token});
  final Attraction attraction;
  final String tripId;
  final String token;

@override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48, 
      height: 48, 
      child:  ElevatedButton(
        onPressed: () {
             showDialog(
              context: context,
              builder: (BuildContext context) {
                return AddAttractionDialog(
                  token: token,
                  tripId: tripId,
                  attraction: attraction,
                );
              },
            ).then((result) {
              if (result == 'attractionAdded') {
                context.read<TripsCubit>().fetch(token);
                 Navigator.pop(context);
              }
            });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF9DC183), 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), 
          ),
        ),
          
          child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_rounded,
              color: Colors.grey.shade900,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
