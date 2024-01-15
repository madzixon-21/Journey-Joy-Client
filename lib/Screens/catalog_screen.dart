/// # Catalog screen
/// ## Displays all the trips as catalogs of attractions
/// 
/// The catalog screen shows the user's trips in a grid structure, displaying the name and photo of each trip.
/// The screen uses the TripsCubit and adapts to the different states. For the loading state it shows a circular
/// progress indicator and for the error it displays the error message. 
/// The gesture detector enables editing and deleting on long press and entering the trip's details on tap.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journey_joy_client/Cubits/trip_cubit.dart';
import 'package:journey_joy_client/Tiles/CatalogTile.dart';
import 'package:journey_joy_client/Dialogs/new_trip_dialog.dart';
import 'package:journey_joy_client/Dialogs/edit_trip_dialog.dart';
import 'package:go_router/go_router.dart';

class CatalogScreen extends StatefulWidget {
  final String token;

  const CatalogScreen({Key? key, required this.token}) : super(key: key);

  @override
  CatalogScreenState createState() => CatalogScreenState();
}

class CatalogScreenState extends State<CatalogScreen> {

  @override
  void initState() {
    super.initState();
    context.read<TripsCubit>().fetch(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 219, 235, 199),
        title: const Text('Your planned trips',
        style: TextStyle(
          color:  Colors.black,
          fontFamily: 'Lohit Tamil',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          ),
        ),
      ),
        body: Stack(
        children: [
          Image.asset(
            'assets/catalog_background.png', 
            fit: BoxFit.cover,
          ),
          BlocBuilder<TripsCubit, TripsState>(
          builder: (context, state) {

            final tripsCubit = context.watch<TripsCubit>();
            final currentState = tripsCubit.state;

            if(currentState is TripsLoading){
              return const Center(
                  child: CircularProgressIndicator(),
                );
            }
            
            switch (currentState.runtimeType) {
              case TripsLoading():
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case TripsData:
                final trips = (currentState as TripsData).trips;

                if (trips.isEmpty) {
                  return  const  Align(
                    alignment: Alignment(0.8, -0.6),
                    child: SizedBox(
                      width: 300,
                      child: Text(
                        "Looks like you haven't planned any trips yet.\n \nPlan your first one!",
                        style: TextStyle(
                          color:  Colors.black,
                          fontFamily: 'Lohit Tamil',
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  );
                }

                return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, 
                      crossAxisSpacing: 8.0, 
                      mainAxisSpacing: 8.0, 
                    ),
                    itemCount: trips.length,
                
                    itemBuilder: (_, i) {
                      final trip = trips[i];
                      BuildContext catalogContext = context;
                
                      return GestureDetector(
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: const Text('Choose Action',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Lohit Tamil')),
                                content: const Text('Do you want to delete or edit this trip?',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Lohit Tamil')
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.white,
                                            title: const Text('Confirm Delete',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Lohit Tamil')),
                                            content: const Text('Are you sure you want to delete this trip?',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Lohit Tamil')),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context); 
                                                },
                                                child: const Text('Cancel',
                                                  style: TextStyle(color: Color.fromARGB(255, 124, 148, 106), fontFamily: 'Lohit Tamil')),
                                                  ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context); 
                                                  catalogContext.read<TripsCubit>().removeTrip(trip.id, widget.token);
                                                },
                                                child: const Text('Delete', 
                                                  style: TextStyle(color: Color.fromARGB(255, 124, 148, 106), fontFamily: 'Lohit Tamil'),),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: const Text('Delete', 
                                      style: TextStyle(color: Color.fromARGB(255, 124, 148, 106), fontFamily: 'Lohit Tamil'),),
                                  ),
                                    
                                  TextButton(
                                    onPressed: () {
                                      showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) => EditTripDialog(token: widget.token, tripId: trip.id,),
                                        ).then((result){
                                          if (result == 'tripEdited') {
                                            Navigator.pop(context);
                                            context.read<TripsCubit>().fetch(widget.token);
                                          }
                                        }
                                    );
                                    },
                                    child: const Text('Edit', 
                                      style: TextStyle(color: Color.fromARGB(255, 124, 148, 106), fontFamily: 'Lohit Tamil'),),
                                  ),
                                ],
                              );
                            },
                          );
                        }, 
                          
                        onTap: (){
                          context.go('/user/${widget.token}/trip/${trip.id}');
                        },
                        child: Center(
                        child: SizedBox(
                          width: 170,
                          height: 240,
                          child: CatalogTile(trip: trip),
                        ),
                      )
                    );
                      
                    },
         
                );
              case TripsError:
                final errorMessage = (currentState as TripsError).message;
                return Center(
                  child: Text(
                    'Error: $errorMessage',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              default:
                return Container();
            }
          },
        ),
        ],
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
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => NewTripDialog(token: widget.token),
            ).then((result){
              if (result == 'tripCreated') {
                context.read<TripsCubit>().fetch(widget.token);
              }
            });
          }
        );
      },
    ),
    );
  }
}