/// # Sign in dialog
/// ## Displays when a new user want to register
/// 
/// Contains text fields to collect the necessary data to create a new acoount. The user adds a nickname, an email address,
///  a password and confirms the password.

import 'package:flutter/material.dart';
import 'package:journey_joy_client/Classes/Functions/signin.dart';
import 'package:http/http.dart' as http;
import 'package:journey_joy_client/Dialogs/error_dialog.dart';

class SigninDialog extends StatelessWidget {

  SigninDialog({super.key});

  final TextEditingController _sIemailController = TextEditingController();
  final TextEditingController _sIpasswordController = TextEditingController();
  final TextEditingController _sIpasswordController2 = TextEditingController();
  final TextEditingController _sInicknameController = TextEditingController();
  
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
            child: Text('Create a new account',
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
              height:45,
              width: 270,
              alignment: Alignment.center,
              
              child: TextField(
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontFamily: 'Lohit Tamil',
                  letterSpacing: 2,
                ),
                controller: _sInicknameController,
                decoration: InputDecoration(
                  hintText: 'Username',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade900, 
                    fontFamily: 'Lohit Tamil', 
                    letterSpacing: 1.5,),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
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
              height:45,
              width: 270,
              alignment: Alignment.center,
              child: TextField(
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontFamily: 'Lohit Tamil',
                  letterSpacing: 2,
                ),
                controller: _sIemailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade900, 
                    fontFamily: 'Lohit Tamil', 
                    letterSpacing: 1.5,),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  prefixIcon: Icon(
                    Icons.email_rounded,
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
              height:45,
              width: 270,
              alignment: Alignment.center,
              
              child: TextField(
                key:const Key('passwordTextField'),
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontFamily: 'Lohit Tamil',
                  letterSpacing: 2,
                ),

                controller: _sIpasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade900, 
                    fontFamily: 'Lohit Tamil', 
                    letterSpacing: 1.5,),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  prefixIcon: Icon(
                    Icons.lock_rounded,
                    color: Colors.grey.shade900,
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 60, 
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20,),

            Container(
              height:45,
              width: 270,
              alignment: Alignment.center,
              
              child: TextField(
                key:const Key('confirmPasswordTextField'),
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontFamily: 'Lohit Tamil',
                  letterSpacing: 2,
                ),

                controller: _sIpasswordController2,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Confirm password',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade900, 
                    fontFamily: 'Lohit Tamil', 
                    letterSpacing: 1.5,),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  prefixIcon: Icon(
                    Icons.lock_rounded,
                    color: Colors.grey.shade900,
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 60, 
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            Center(
              child: ElevatedButton(
                  onPressed: () {
                    if (_sIpasswordController.text == _sIpasswordController2.text) {
                      SignInAction().signIn(
                        _sInicknameController.text,
                        _sIpasswordController.text,
                        _sIemailController.text,
                      ).then((http.Response? response) {
                        if(response != null){
                          if (response.statusCode == 200) {
                            Navigator.pop(context);
                          } else {
                            _sInicknameController.clear();
                            _sIemailController.clear();
                            _sIpasswordController.clear();
                            _sIpasswordController2.clear();

                            showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => ErrorDialog(prop: response.body),
                          );
                          }
                        }
                      });
                    }  
                    else {
                      _sInicknameController.clear();
                      _sIemailController.clear();
                      _sIpasswordController.clear();
                      _sIpasswordController2.clear();
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text('Sign in',
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontFamily: 'Lohit Tamil',
                      letterSpacing: 2,
                      fontSize: 15,
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