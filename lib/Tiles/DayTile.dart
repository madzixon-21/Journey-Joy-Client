import 'package:flutter/material.dart';
import 'package:journey_joy_client/Classes/attraction.dart';
import 'package:journey_joy_client/Tiles/RouteTile.dart';
import 'package:journey_joy_client/Classes/trip.dart';
import 'package:journey_joy_client/Classes/Functions/edit_route_order.dart';
import 'package:journey_joy_client/Dialogs/error_dialog.dart';
import 'package:http/http.dart' as http;

class DayTile extends StatelessWidget {
  final List<AttractionToAdd> attractions;
  final List<String> attractionIds;
  final Trip trip;
  final String token;
  final int dayNumber;
  final String weekDay;

  const DayTile({
    required this.weekDay,
    required this.attractions,
    required this.attractionIds,
    required this.dayNumber,
    required this.trip,
    required this.token,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<AttractionToAdd>(onWillAccept: (data) {
      return true;
    }, onAccept: (data) {
      AttractionToAdd droppedAttraction = data;
      int targetDayIndex = dayNumber - 1;

      // Znajdź indeks, z którego usuwamy atrakcję
      int droppedDayIndex = -1;
      for (int i = 0; i < trip.route.attractionsInOrder.length; i++) {
        if (trip.route.attractionsInOrder[i]
            .contains(droppedAttraction.tripAdvisorLocationId)) {
          droppedDayIndex = i;
          break;
        }
      }

      if (droppedDayIndex != -1) {
        // Usuń atrakcję z pierwotnego dnia
        trip.route.attractionsInOrder[dayNumber - 1].removeWhere(
          (attractionId) =>
              attractionId == droppedAttraction.tripAdvisorLocationId,
        );

        // Dodaj atrakcję do nowego dnia
        trip.route.attractionsInOrder[droppedDayIndex]
            .add(droppedAttraction.tripAdvisorLocationId);
      }

      // Aktualizuj trasę
      EditRouteAction()
          .edit(trip.route.attractionsInOrder, trip.id, token)
          .then((http.Response? response) {
        if (response != null) {
          if (response.statusCode != 200) {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) =>
                  ErrorDialog(prop: response.body),
            );
          }
        }
      });
    }, builder: (context, candidateData, rejectedData) {
      return Flexible(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  color: Colors.grey.shade900,
                  height: 1,
                  width: 50,
                ),
                const SizedBox(width: 10),
                Text(
                  "Day $dayNumber - $weekDay",
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 16,
                    fontFamily: 'Lohit Tamil',
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    color: Colors.grey.shade900,
                    height: 1,
                  ),
                ),
              ],
            ),
            for (var attractionId in attractionIds)
              Draggable<AttractionToAdd>(
                data: attractions.firstWhere(
                  (attraction) =>
                      attraction.tripAdvisorLocationId == attractionId,
                ),
                feedback: Opacity(
                  opacity: 0.7,
                  child: RouteTile(
                    day: 0,
                    attraction: attractions.firstWhere(
                      (attraction) =>
                          attraction.tripAdvisorLocationId == attractionId,
                    ),
                    tripId: trip.id,
                    token: token,
                  ),
                ),
                child: RouteTile(
                  day: 0,
                  attraction: attractions.firstWhere(
                    (attraction) =>
                        attraction.tripAdvisorLocationId == attractionId,
                  ),
                  tripId: trip.id,
                  token: token,
                ),
              ),
            const SizedBox(height: 20),
          ],
        ),
      );
    });
  }
}
