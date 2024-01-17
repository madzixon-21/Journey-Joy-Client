/// # Edit Trip dialog
/// ## Dialog displayed for editing data related to a trip
///
/// Contains two text fields, one for the trip's name and one for the description, which are already filled with the
/// current name and descprition. It allows the user to choose a different photo for the trip's catalog cover.
/// The elevated button sends the http request.

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:journey_joy_client/Classes/Functions/edit_trip.dart';
import 'package:image_picker/image_picker.dart';

class EditTripDialog extends StatefulWidget {
  const EditTripDialog({required this.token, required this.tripId, super.key});
  final String token;
  final String tripId;
  @override
  EditTripDialogState createState() => EditTripDialogState();
}

class EditTripDialogState extends State<EditTripDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late List<int>? imageBytes;
  int _ifPictureAdded = 0;

  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageBytes = await pickedFile.readAsBytes();
      _ifPictureAdded = 1;
    }
  }

  Widget _buildSelectedImage() {
    if (_ifPictureAdded == 1) {
      return Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: MemoryImage(Uint8List.fromList(imageBytes!)),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color.fromARGB(255, 222, 235, 207),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Form(
        key: _formKey,
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Edit your trip',
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontFamily: 'Lohit Tamil',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                TextFormField(
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontFamily: 'Lohit Tamil',
                    letterSpacing: 2,
                  ),
                  controller: _nameController,
                  maxLength: 14,
                  maxLines: 3,
                  minLines: 1,
                  decoration: InputDecoration(
                    hintText: 'Change name',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade900,
                      fontFamily: 'Lohit Tamil',
                      letterSpacing: 1.5,
                    ),
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
                const SizedBox(height: 10),
                TextFormField(
                  key: const Key('tripDescriptionTextField'),
                  maxLines: 3,
                  minLines: 1,
                  maxLength: 50,
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
                      letterSpacing: 1.5,
                    ),
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
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(child: Container()),
                    Container(
                      height: 50,
                      width: 200,
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () async {
                          await getImage();
                          setState(() {}); 
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.add_a_photo_rounded,
                              color: Colors.grey.shade900,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Choose photo',
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
                    Center(child: _buildSelectedImage()),
                  ],
                ),
                const SizedBox(height: 25),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_ifPictureAdded == 0) {
                          imageBytes = List.empty();
                        }
                        EditTripAction()
                            .edit(
                                _nameController.text,
                                _descriptionController.text,
                                imageBytes,
                                widget.token,
                                widget.tripId)
                            .then((bool editionSuccessful) {
                          if (editionSuccessful) {
                            Navigator.pop(context, 'tripEdited');
                          } else {
                            _nameController.clear();
                            _descriptionController.clear();
                          }
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      'Save changes',
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
        ),
      ),
    );
  }
}
