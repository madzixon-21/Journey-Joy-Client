/// # Add attraction dialog
/// ## Dialog displayed before sending a request to add an attraction to a trip
///
/// Collects necessary information about the attraction that is needed for the planning algorithm.
/// The name and description of the atrraction are already filled and the user adds a description and the time needed for visiting.
/// Contains an Elevated Button that sends the http request.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journey_joy_client/Classes/attraction.dart';
import 'package:journey_joy_client/Classes/Functions/add_attraction.dart';

class AddAttractionDialog extends StatelessWidget {
  AddAttractionDialog(
      {required this.token,
      required this.tripId,
      required this.attraction,
      super.key});
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

    final _formKey = GlobalKey<FormState>();

    return Dialog(
      backgroundColor: const Color.fromARGB(255, 222, 235, 207),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        height: 600,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: const DecorationImage(
            image: AssetImage('assets/dialog_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Center(
                  child: Text(
                    'Add attraction to trip',
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
                TextFormField(
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontFamily: 'Lohit Tamil',
                    letterSpacing: 2,
                  ),
                  controller: _nameController,
                  maxLines: 3,
                  minLines: 1,
                  maxLength: 50,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 10),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontFamily: 'Lohit Tamil',
                    letterSpacing: 2,
                  ),
                  controller: _addressController,
                  maxLength: 50,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter street';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  key: const Key('tripDescriptionTextField'),
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontFamily: 'Lohit Tamil',
                    letterSpacing: 2,
                  ),
                  controller: _descriptionController,
                  maxLines: 3,
                  minLines: 1,
                  maxLength: 50,
                  decoration: InputDecoration(
                    hintText: 'Add description',
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  maxLength: 4,
                  controller: _timeNeededController,
                  decoration: InputDecoration(
                    hintText: 'Time in minutes',
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
                      Icons.access_time_filled_rounded,
                      color: Colors.grey.shade900,
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 60,
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter time';
                    } else if (int.parse(value) > 1440) {
                      return 'Time should be less than 1440';
                    } else if (int.parse(value) < 0) {
                      return 'Time should be positive';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        AddAttractionAction()
                            .add(
                                _nameController.text,
                                attraction.address,
                                _descriptionController.text,
                                List<int>.empty(),
                                _timeNeededController.text,
                                List<List<String>>.empty(),
                                List<String>.empty(),
                                attraction.locationId.toString(),
                                tripId,
                                token)
                            .then((bool successful) {
                          if (successful) {
                            Navigator.pop(context, 'attractionAdded');
                          } else {
                            _nameController.text = attraction.name;
                            _addressController.text =
                                attraction.address.toString();
                            _descriptionController.clear();
                            _timeNeededController.clear();
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
