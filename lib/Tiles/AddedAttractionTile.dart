import 'package:flutter/material.dart';
import 'package:journey_joy_client/Classes/attraction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journey_joy_client/Cubits/trip_cubit.dart';
import 'package:journey_joy_client/Classes/Functions/delete_attraction.dart';
import 'package:http/http.dart' as http;
import 'package:journey_joy_client/Dialogs/error_dialog.dart';
import 'dart:convert';
import 'package:journey_joy_client/Classes/Functions/set_startpoint.dart';
import 'package:journey_joy_client/Dialogs/Edit Form /form_dialog.dart';

class AddedAttractionTile extends StatelessWidget {
  const AddedAttractionTile({
    super.key,
    required this.attraction,
    required this.tripId,
    required this.token,
  });

  final AttractionToAdd attraction;
  final String tripId;
  final String token;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10), 
        ),
        child: Row(
          children: [
            
            Container(
              width: 80,
              height: 80,
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

            const SizedBox(width: 15, height: 80,),

            Expanded(
              child: Column(
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
                  
                  const SizedBox(height: 10),
                  
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

                ],
              ),
              ),
            
            MinusButton(attraction: attraction, tripId: tripId, token: token),
            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}

class MinusButton extends StatelessWidget {

  const MinusButton({super.key, required this.attraction, required this.tripId, required this.token});
  final AttractionToAdd attraction;
  final String tripId;
  final String token;

@override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 47, 
      height: 45, 
      child:  ElevatedButton(
        onPressed: () {
          
          showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text('Choose Action',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Lohit Tamil')),
            content: const Text('What would you like to do with this attraction?',
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
                        content: const Text('Are you sure you want to delete this attraction from your trip?',
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
                              DeleteAttractionAction().delete(tripId, attraction.tripAdvisorLocationId, token).then((http.Response? response){
                                if (response != null) {
                                  if(response.statusCode == 200)
                                  {
                                    context.read<TripsCubit>().fetch(token).then((_) {
                                      Navigator.pop(context);
                                    });
                                  }else {
                                    print(response.body);
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) => ErrorDialog(prop: response.body),
                                    );
                                  }
                                }
                              });
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditFormDialog(
                        attraction: attraction,
                        token: token,
                        tripId: tripId,
                      ),
                    ),
                  );

                  context.read<TripsCubit>().fetch(token).then((_) {Navigator.pop(context);});
                },
              
                child: const Text('Edit', 
                  style: TextStyle(color: Color.fromARGB(255, 124, 148, 106), fontFamily: 'Lohit Tamil'),),
              ),

              TextButton(
                onPressed: () {
                    SetStartPoint().patch(tripId, attraction.tripAdvisorLocationId, token).then((http.Response? response){
                      if(response != null){
                        if(response.statusCode == 200){
                          context.read<TripsCubit>().fetch(token).then((_) {
                            Navigator.pop(context);
                          });
                        }else {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => ErrorDialog(prop: response.body),
                          );
                        }
                      }
                    });
                
                  context.read<TripsCubit>().fetch(token);
                },
                child: const Text('Set as start point', 
                  style: TextStyle(color: Color.fromARGB(255, 124, 148, 106), fontFamily: 'Lohit Tamil'),),
              ),
            ],
          );
        },
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF9DC183), 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17.0), 
          ),
        ),
          
          child:  Row(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.settings,
              color: Colors.grey.shade800,
              size: 15,
              
            ),
          ],
        ),
          
      ),
      
    );

  }
}
