/// # Log in screen
/// ## Allows a registered user to enter their account
/// 
/// The log in screen contains text fields for the user to write their e-mail address and password.
/// The "Log in" button sends the http request with this data. 
/// The "Sign in" button opens the sign in dialog which collects the necessary information to register
/// a new user.

import 'package:flutter/material.dart';
import 'package:journey_joy_client/Dialogs/sign_in_dialog.dart';
import '../Classes/Functions/login.dart';
import '../main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:journey_joy_client/Dialogs/error_dialog.dart';

class LoginScreen extends StatelessWidget {

  LoginScreen({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/login_background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
    
        child: Center(
          child: Column(
            children: [
      
              const SizedBox(height: 150),
        
              const Text(
                  ' JourneyJoy',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xDB9DC183),
                    fontSize: 62,
                    fontFamily: 'Satisfy',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 6.5,
                  ),
                ),
              
                const SizedBox(height: 50),
        
                Container(
                  width: 350,
                  height: 450,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: const Color.fromARGB(99, 170, 197, 151),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
        
                child: Column(
                  children: [
                    const SizedBox(height: 50),
        
                    Container(
                      height:45,
                      width: 300,
                      alignment: Alignment.center,
                      
                      child: TextField(
                        style: TextStyle(
                          color: Colors.grey.shade900,
                          fontFamily: 'Lohit Tamil',
                          letterSpacing: 2,
                        ),
                        controller: _emailController,
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
                            minWidth: 80, 
                          ),
                        ),
                      ),
                    ),
        
                    const SizedBox(height:20),
        
                    Container(
                      height:45,
                      width: 300,
                      alignment: Alignment.center,
                      
                      child: TextField(
                        style: TextStyle(
                          color: Colors.grey.shade900,
                          fontFamily: 'Lohit Tamil',
                          letterSpacing: 2,
                        ),
        
                        controller: _passwordController,
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
                            minWidth: 80, 
                          ),
                        ),
                      ),
                    ),
        
                    const SizedBox(height: 20,),
        
                    TextButton(
                      onPressed: () {
                        LoginAction().login(_emailController.text, _passwordController.text).then((http.Response? response) {
                          if (response != null && response.statusCode != 500) {
                            if(response.statusCode == 200)
                            {
                              final Map<String, dynamic> jsonResponse = json.decode(response.body);
                              final String token = jsonResponse['token'];
                              context.go('/user/$token');
                            }else if(response.statusCode == 400) {
                              _emailController.clear();
                              _passwordController.clear();
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => ErrorDialog(prop: response.body),
                              );
                            }
                          }else{
                            _emailController.clear();
                            _passwordController.clear();
                          }
                          
                        });
                      },
        
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  const Color(0xFF9DC183),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0), 
                        ),
                        minimumSize: const Size(305, 47),
                      ),
        
                      child:  Text(
                        'Log in',
                        style: TextStyle(
                          color: Colors.grey.shade900,
                          fontFamily: 'Lohit Tamil',
                          fontSize: 15,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
        
                    const SizedBox(height: 35,),
        
                    Row(
                      children: [
                        const SizedBox(width: 52,),
                        Container(
                          color: Colors.grey.shade900,
                          height: 1, 
                          width: 100,
                        ),
                      
                      Padding( 
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'or ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey.shade900,
                            fontSize: 14,
                            fontFamily: 'Lohit Tamil',
                            fontWeight: FontWeight.w400,
                            height: 0.23,
                            letterSpacing: 1.60,
                          ),
                        ),
                      ),
        
                        Container(
                            color: Colors.grey.shade900, 
                            height: 1, 
                            width: 100,
                          ),
                      ],
                    ),
        
                    const SizedBox(height: 35,),
        
                    TextButton(
                      onPressed: () {
                        showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => SigninDialog(),
                      );
                      }, 
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  const Color(0xFF9DC183),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0), 
                        ),
                        minimumSize: const Size(305, 47),
                      ),
                      child:  Text(
                        'Create account',
                        style: TextStyle(
                          color: Colors.grey.shade900,
                          fontFamily: 'Lohit Tamil',
                          fontSize: 15,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                      
                    const SizedBox(height: 20,),
        
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: ElevatedButton(
                        onPressed: () {}, 
                        style: ElevatedButton.styleFrom(
                          backgroundColor:  const Color(0xFF9DC183),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0), 
                          ),
                          minimumSize: const Size(305, 47),
                        ),
                        child:  Row(
                          children: [
                            const SizedBox(width: 15),
                            Container(
                              width: 20,
                              height: 20,
                              decoration:const BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage('https://cdn-icons-png.flaticon.com/128/104/104093.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 30),
                            Text(
                              'Sign in with Google',
                              style: TextStyle(
                                color: Colors.grey.shade900,
                                fontFamily: 'Lohit Tamil',
                                fontSize: 15,
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 25,),
                  ],
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
