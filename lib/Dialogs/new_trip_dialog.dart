/// # New Trip Dialog
/// ## Dialog displayed when the user wants to create a new trip
/// 
/// Displays the New Trip Form.

import 'package:flutter/material.dart';
import 'package:journey_joy_client/Screens/Add_Trip_Form/add_trip_form.dart';

class NewTripDialog extends StatefulWidget {

  const NewTripDialog({required this.token, super.key});
  final String token;
   @override
  NewTripDialogState createState() => NewTripDialogState();
}

class NewTripDialogState extends State<NewTripDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color.fromARGB(255, 222, 235, 207),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: AddTripForm(token: widget.token),
    );
  }
}
