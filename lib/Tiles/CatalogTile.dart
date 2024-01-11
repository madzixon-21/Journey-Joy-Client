import 'package:flutter/material.dart';
import 'package:journey_joy_client/Classes/trip.dart';

class CatalogTile extends StatelessWidget {
  const CatalogTile({
    super.key,
    required this.trip,
  });
  
  final Trip trip;

  @override
    Widget build(BuildContext context) {
      return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10), 
            ),
            child: Column(
              children: [
                Container(
                  width: 170,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0), 
                      image: trip.picture.isNotEmpty
                        ? DecorationImage(
                            image: MemoryImage(trip.picture),
                            fit: BoxFit.cover,
                          )
                        : null,                 
                  ),
                ),
        
                const SizedBox(height: 25),
        
                Text(
                  trip.name,
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 17,
                    fontFamily: 'Lohit Tamil',
                    fontWeight: FontWeight.w400,
                    height: 0.15,
                    letterSpacing: 2,
                  ),
                ),
              ],
            )
      );
    }
}