///# Attraction Screen
///## Screen for displaying attraction from tripAdvisor after making a search.
///
/// Screen consisting of a Scaffold with an appar that contains a search bar where the user can search 
/// attractions using key words. The body displays a list of attractions provided by tripAdvisor that match 
/// the search key word. Each attraction has a plus button that allows the user to add the attraction to the trip.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journey_joy_client/Cubits/attraction_cubit.dart';
import 'package:journey_joy_client/Tiles/AttractionTile.dart';
import 'package:go_router/go_router.dart';
import 'package:journey_joy_client/Cubits/trip_cubit.dart';

class AttractionScreen extends StatefulWidget {

   final String token;
  final String tripId;
  const AttractionScreen({required this.token, required this.tripId, super.key});
@override
  AttractionScreenState createState() => AttractionScreenState();
}

class AttractionScreenState extends State<AttractionScreen> {


  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
    context.read<AttractionsCubit>().fetch(_searchController.text, widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async {
        context.read<TripsCubit>().fetch(widget.token);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 219, 235, 199),
          title: Container(
            height:40,
            width: 350,
            alignment: Alignment.center,
            child: TextField(
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Lohit Tamil',
                letterSpacing: 1.5,
              ),
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: const TextStyle(
                  color: Colors.black, 
                  fontFamily: 'Lohit Tamil', 
                  letterSpacing: 1.5,),
                contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear, color: Colors.black,),
                  onPressed: () => _searchController.clear(),
                ),
                prefixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.black,),
                  onPressed: () {context.read<AttractionsCubit>().fetch(_searchController.text, widget.token);},
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
            ),
          ) 
        ),
        body: BlocBuilder<AttractionsCubit, AttractionsState>(
          builder: (context, state) {
            final attractionsCubit = context.watch<AttractionsCubit>();
            final currentState = attractionsCubit.state;

            if(currentState is AttractionsLoading){
              return const Center(
                  child: CircularProgressIndicator(),
                );
            }

            switch (currentState.runtimeType) {
              case AttractionsLoading():
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case AttractionsData:
                final attractions = (currentState as AttractionsData).attractions;

                 if (attractions.isEmpty) {
                  return  const  Align(
                    alignment: Alignment(0.8, -0.6),
                    child: SizedBox(
                      width: 300,
                      child: Text(
                        "Make your first search!",
                        style: TextStyle(
                          color:  Color.fromARGB(201, 49, 46, 46),
                          fontFamily: 'Lohit Tamil',
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: attractions.length,
                  itemBuilder: (_, i) {
                    final attraction = attractions[i];
                    return AttractionTile(attraction: attraction, tripId: widget.tripId, token: widget.token);
                  },
                );
              case AttractionsError:
                final errorMessage = (currentState as AttractionsError).message;
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

        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
              
              backgroundColor: const Color.fromARGB(255, 224, 245, 210),
              child: const Icon(
                Icons.add_location_alt_outlined,
                color: Colors.black45,
                size: 32,
              ),
              onPressed: () {
                context.go('/user/${widget.token}/trip/${widget.tripId}/newAttraction');
              },
            ),
      ),
      );
  }
}