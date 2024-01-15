import 'package:flutter/material.dart';
import 'package:journey_joy_client/Classes/attraction.dart';
import 'dart:convert';

class RouteTile extends StatelessWidget {
  const RouteTile({
    super.key,
    required this.day,
    required this.attraction,
    required this.tripId,
    required this.token,
    required this.showHours,
  });

  final AttractionToAdd attraction;
  final String tripId;
  final String token;
  final int day;
  final bool showHours;

  @override
  Widget build(BuildContext context) {
    String visitingHours = calculateVisitingHours(attraction.timeNeeded, day, attraction.openHours);

    return Padding(
      padding: const EdgeInsets.all(12),
      
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10), 
        ),
        child:Flexible(

          child: Row(
            mainAxisSize: MainAxisSize.min,

          children: [
            
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: attraction.photo.isNotEmpty
                  ? attraction.photo.startsWith('http')
                      ? DecorationImage(
                          image: NetworkImage(attraction.photo),
                          fit: BoxFit.cover,
                        )
                      : DecorationImage(
                          image: MemoryImage(base64Decode(attraction.photo)),
                          fit: BoxFit.cover,
                        )
                  : null,
              ),
            ),

            const SizedBox(width: 15, height: 90,),

            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(attraction.name,
                      style: TextStyle(
                        color: Colors.grey.shade900,
                        fontSize: 15,
                        fontFamily: 'Lohit Tamil',
                        fontWeight: FontWeight.w400,
                        height: 1,
                        letterSpacing: 2,
                      ),
                    ),
                  
                  const SizedBox(height: 8),
                  
                  Text(attraction.location.toString(),
                      style: TextStyle(
                        color: Colors.grey.shade900,
                        fontSize: 13,
                        fontFamily: 'Lohit Tamil',
                        fontWeight: FontWeight.w400,
                        height: 1,
                        letterSpacing: 1,
                      ),
                    ),

                  const SizedBox(height: 8),
                  Visibility(
                    visible: !showHours,
                    child: Text("Enter attraction between: \n $visitingHours",
                      style: TextStyle(
                        color: Colors.grey.shade900,
                        fontSize: 13,
                        fontFamily: 'Lohit Tamil',
                        fontWeight: FontWeight.w400,
                        height: 1.3,
                        letterSpacing: 1,
                      ),
                    ),
                    )
                  
                ],
              ),
            ),
           
            const SizedBox(width: 15),
          ],
        ),
      ),
      ),
    );
  }

  String calculateVisitingHours(int timeNeeded, int day, List<List<String>> openingHours) {
  
    if(openingHours.isEmpty){
      return "Attraction is always open";
    }
    else{
    String openingHour = openingHours[day%7][0];
    String closingHour = openingHours[day%7][1];
  
    int closingHourInMinutes = int.parse(closingHour.substring(0, 2)) * 60 + int.parse(closingHour.substring(2, 4));

    int lastHour = closingHourInMinutes - timeNeeded;

    int hour = lastHour ~/ 60;
    int minutes = lastHour % 60;

    String lastHourString = hour.toString().padLeft(2, '0');
    String lastMinuteString = minutes.toString().padLeft(2, '0');
    String openingHourString = openingHour.substring(0, 2);
    String openingMinuteString = openingHour.substring(2, 4);

    return "$openingHourString:$openingMinuteString - $lastHourString:$lastMinuteString";
    }
  }
}