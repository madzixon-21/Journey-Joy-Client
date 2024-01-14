/// # Sign in dialog
/// ## Displays when a new user want to register
/// 
/// Contains text fields to collect the necessary data to create a new acoount. The user adds a nickname, an email address,
///  a password and confirms the password.

import 'package:flutter/material.dart';
import 'package:journey_joy_client/Screens/SignInForm/signin_form.dart';

class SigninDialog extends StatelessWidget {

  const SigninDialog({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color.fromARGB(255, 222, 235, 207),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SignInForm(),
    );
  }
}