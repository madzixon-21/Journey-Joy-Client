/// # Sign in dialog
/// ## Displays when a new user wants to register
/// 
/// Screen used to display Sign in form.

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
      child: const SignInForm(),
    );
  }
}