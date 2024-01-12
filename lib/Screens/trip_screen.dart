import 'package:flutter/material.dart';
import 'package:journey_joy_client/Classes/trip.dart';
import 'package:journey_joy_client/Dialogs/create_route_dialog.dart';
import 'package:journey_joy_client/main.dart';
import 'package:journey_joy_client/Tiles/AddedAttractionTile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journey_joy_client/Cubits/trip_cubit.dart';
import 'package:journey_joy_client/Dialogs/error_dialog.dart';
import 'package:journey_joy_client/Tiles/DayTile.dart';
import 'package:journey_joy_client/Classes/Functions/remove_route.dart';
import 'package:http/http.dart' as http;

class TripScreen extends StatefulWidget {
  final String tripId;
  final String token;
  const TripScreen({required this.tripId, required this.token, super.key});
  @override
  TripScreenState createState() => TripScreenState();
}

class TripScreenState extends State<TripScreen> {
  bool isRoute = false;
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripsCubit, TripsState>(
      builder: (context, state) {
        if (state is TripsData) {
          final trip = state.trips.firstWhere((t) => t.id == widget.tripId);
          if(trip.route.attractionsInOrder.isNotEmpty) isRoute = true;

          return buildTrip(trip, context);
        } else if (state is TripsLoading) {
          return Scaffold(
           appBar: AppBar(backgroundColor: const Color.fromARGB(255, 219, 235, 199),
          title: const Text('Trip details',
          style: TextStyle(
            color:  Colors.black,
            fontFamily: 'Lohit Tamil',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            ),
          ),
        ),
          body:Container(
             decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/trip_background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          );
        } else if (state is TripsError) {
          String error = state.message;
          return Center(
                  child: Text(
                    'Error: $error',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
        }else{
          return Container();
        }
      },
    );
  }


  Widget buildTrip(Trip trip, BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 219, 235, 199),
        title: const Text('Trip details',
        style: TextStyle(
          color:  Colors.black,
          fontFamily: 'Lohit Tamil',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/trip_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: trip.picture.isNotEmpty
                          ? DecorationImage(
                              image: MemoryImage(trip.picture),
                              fit: BoxFit.cover,
                            )
                          : null,   
                      ),
                    ),
      
                    const SizedBox(width: 16), 
      
                     Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            trip.name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Lohit Tamil',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            trip.description,
                            style: TextStyle(
                              color: Colors.grey.shade900,
                              fontFamily: 'Lohit Tamil',
                              fontSize: 15,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),

               isRoute
                ? buildRouteList(trip)
                : buildAttractionsList(trip),
        
                
      
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),


       floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              
              backgroundColor: const Color(0xFF9DC183),
              child: const Icon(
                Icons.add,
                color: Colors.black45,
                size: 32,
              ),
              onPressed: () {
                context.go('/user/${widget.token}/trip/${trip.id}/attraction');
              }
            );
          },
        ),
    );
  }

Widget buildAttractionsList(Trip trip) {
  return Column(
    children: [
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: trip.attractions.length,
        itemBuilder: (context, index) {
          return AddedAttractionTile(
            attraction: trip.attractions[index],
            tripId: trip.id,
            token: widget.token,
          );
        },
      ),

      Center(
                  child: ElevatedButton(
                    onPressed: () {
                      bool hasStartPoint = trip.attractions.any((attraction) => attraction.isStartPoint);
      
                      if (hasStartPoint) {
                        showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => CreateRouteDialog(token: widget.token, tripId: widget.tripId,))
                        .then((result){
                          if (result == 'routeCreated') {
                            context.read<TripsCubit>().fetch(widget.token);
                            setState(() {
                              isRoute = true;
                            });
                          }});
                      } else {
                        showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => const ErrorDialog(prop: "Make sure to add your hotel accomodation and set it as a starting point of your trip."));
                      } 
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text('Find route',
                        style: TextStyle(
                          color: Colors.grey.shade900,
                          fontFamily: 'Lohit Tamil',
                          letterSpacing: 2,
                        ),
                      ),
                  ),
                ),
      
    ],
  );
}

Widget buildRouteList(Trip trip) {
  return Column(
    children: [
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: trip.route.attractionsInOrder.length,
        itemBuilder: (context, dayIndex) {
          if( trip.route.attractionsInOrder[dayIndex].isNotEmpty){
            int weekDay = (trip.route.startDay + dayIndex - 1) % 7 + 1;
            return DayTile( weekDay: weekDay, attractions: trip.attractions, attractionIds: trip.route.attractionsInOrder[dayIndex], dayNumber: dayIndex+1, trip: trip, token: widget.token);
          }else{return null;}
        },
      ),
      

      ElevatedButton(
        onPressed: () {
          RemoveRouteAction().delete(widget.tripId, widget.token).then((http.Response? response){
            if(response != null){
              if(response.statusCode == 200){
                setState(() {
                  isRoute = false;
                });
                context.read<TripsCubit>().fetch(widget.token);
              }else{
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => ErrorDialog(prop: response.body));
              }
            }
          });
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text('Remove route',
            style: TextStyle(
              color: Colors.grey.shade900,
              fontFamily: 'Lohit Tamil',
              letterSpacing: 2,
            ),
          ),
      ),
                
      
    ],
  );

}
}