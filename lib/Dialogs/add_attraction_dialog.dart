import 'package:flutter/material.dart';
import 'package:journey_joy_client/Classes/attraction.dart';
import 'package:journey_joy_client/Classes/Functions/add_attraction.dart';

class AddAttractionDialog extends StatelessWidget {

  AddAttractionDialog({required this.token, required this.tripId, required this.attraction, super.key});
  final String token;
  final String tripId;
  final Attraction attraction;
  

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _timeNeededController = TextEditingController();

  
  
  @override
  Widget build(BuildContext context) {
    _nameController.text = attraction.name;
    _addressController.text = attraction.address.toString();

    return Dialog(
      backgroundColor: const Color.fromARGB(255, 222, 235, 207),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: 600,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: const DecorationImage(
            image: AssetImage('assets/dialog_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child:Column(
          children: [
            const SizedBox(height: 50),

            Center(
            child: Text('Add attraction to trip',
              style: TextStyle(
                color: Colors.grey.shade900,
                fontFamily: 'Lohit Tamil',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                
                ),
              ),
            ),

            const SizedBox(height: 35),

            Container(
              width: 250,
              alignment: Alignment.center,
              child: TextField(
                
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontFamily: 'Lohit Tamil',
                  letterSpacing: 2,
                ),
                controller: _nameController,
                maxLines: null, 
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  prefixIcon: Icon(
                    Icons.account_circle,
                    color: Colors.grey.shade900,
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 60, 
                  ),
                ),
              ),
            ),

            const SizedBox(height:20),

            Container(
              width: 250,
              alignment: Alignment.center,
              
              child: TextField(
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontFamily: 'Lohit Tamil',
                  letterSpacing: 2,
                ),
                controller: _addressController,
                maxLines: null, 
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  prefixIcon: Icon(
                    Icons.location_on_rounded,
                    color: Colors.grey.shade900,
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 60, 
                  ),
                ),
              ),
            ),

            const SizedBox(height:20),
            
            Container(
              width: 250,
              alignment: Alignment.center,
              
              child: TextField(
                key: const Key('tripDescriptionTextField'),
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontFamily: 'Lohit Tamil',
                  letterSpacing: 2,
                ),
                controller: _descriptionController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Add description',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade900, 
                    fontFamily: 'Lohit Tamil', 
                    letterSpacing: 1.5,),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  prefixIcon: Icon(
                    Icons.article_rounded,
                    color: Colors.grey.shade900,
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 60, 
                  ),
                ),
              ),
            ),

            const SizedBox(height:20),

            Container(
              width: 250,
              alignment: Alignment.center,
              
              child: TextField(
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontFamily: 'Lohit Tamil',
                  letterSpacing: 2,
                ),
                controller: _timeNeededController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Time needed in \nminutes',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade900, 
                    fontFamily: 'Lohit Tamil', 
                    letterSpacing: 1.5,),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  prefixIcon: Icon(
                    Icons.access_time_filled_rounded,
                    color: Colors.grey.shade900,
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 60, 
                  ),
                ),
              ),
            ),

            const SizedBox(height:20),
            Center(
              child: ElevatedButton(
                
                onPressed: (){
                  AddAttractionAction().add(
                        _nameController.text,
                        attraction.address,
                        _descriptionController.text,
                        List<int>.empty(),
                        _timeNeededController.text,
                        List<List<String>>.empty(),
                        List<String>.empty(),
                        attraction.locationId.toString(),
                        tripId,
                        token
                      ).then((bool successful) {
                        if (successful) {
                          Navigator.pop(context, 'attractionAdded');
                        } else {
                          _nameController.text = attraction.name;
                          _addressController.text = attraction.address.toString();
                          _descriptionController.clear();
                          _timeNeededController.clear();
                        }
                      });
                },
                
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                ),
                child: Text('Save changes',
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontFamily: 'Lohit Tamil',
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
