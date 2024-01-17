/// # Form
/// ## Form screen used for displaying the Add Form

import 'package:flutter/material.dart';
import 'package:journey_joy_client/Screens/Add_Form/add_form.dart';

class AddFormScreen extends StatefulWidget {
  final String token;
  final String tripId;

  const AddFormScreen({required this.token, required this.tripId, super.key});

  @override
  AddFormScreenState createState() => AddFormScreenState();
}

class AddFormScreenState extends State<AddFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 219, 235, 199),
        title: const Text(
          'Create a new attraction',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Lohit Tamil',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: AddForm(token: widget.token, tripId: widget.tripId,),
        ),
      ),
    );
  }
}
