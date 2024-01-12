/// # New Trip Dialog
/// ## Dialog display when the user wants to create a new trip
/// 
/// Allows the user to set the trip's name, description and choose a catalog cover picture.
/// The elevated button send the http request.

import 'package:flutter/material.dart';
import 'package:journey_joy_client/Classes/Functions/create_trip.dart';
import 'package:image_picker/image_picker.dart';

class NewTripDialog extends StatefulWidget {

  const NewTripDialog({required this.token, super.key});
  final String token;
   @override
  NewTripDialogState createState() => NewTripDialogState();
}

class NewTripDialogState extends State<NewTripDialog> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late List<int>? imageBytes;

  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageBytes = await pickedFile.readAsBytes();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color.fromARGB(255, 222, 235, 207),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: 450,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: const DecorationImage(
            image: AssetImage('assets/small_dialog_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child:Column(
          children: [
            const SizedBox(height: 50),

            Center(
            child: Text('Create a new trip',
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
              height:40,
              width: 250,
              alignment: Alignment.center,
              
              child: TextField(
                key: const Key('tripNameTextField'),
                maxLines: null,
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontFamily: 'Lohit Tamil',
                  letterSpacing: 2,
                ),
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Name of the trip',
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
              height:40,
              width: 250,
              alignment: Alignment.center,
              
              child: TextField(
                key: const Key('tripDescriptionTextField'),
                maxLines: null,
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontFamily: 'Lohit Tamil',
                  letterSpacing: 2,
                ),
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: 'Description',
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
              height: 40,
              width: 200,
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () async {
                  await getImage();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                ),
                child:  Row(
                  children: [
                    Icon(
                      Icons.add_a_photo_rounded,
                      color: Colors.grey.shade900,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text('Choose photo',
                      style: TextStyle(
                        color: Colors.grey.shade900,
                        fontFamily: 'Lohit Tamil',
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height:20),

            Center(
              child: ElevatedButton(
                
                onPressed: (){
                  CreateTripAction().create(
                        _nameController.text,
                        _descriptionController.text,
                        imageBytes,
                        widget.token,
                      ).then((bool successful) {
                        if (successful) {
                          Navigator.pop(context, 'tripCreated');
                        } else {
                          _nameController.clear();
                        _descriptionController.clear();
                        }
                      });
                },
                
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                ),
                child: Text('Plan your trip',
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
