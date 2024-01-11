import 'package:flutter/material.dart';


class ErrorDialog extends StatelessWidget {

  ErrorDialog({required this.prop, super.key});
  final String prop;

  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color.fromARGB(255, 236, 237, 235),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30),

            Center(
            child: Text('Something went wrong!',
              style: TextStyle(
                color: Colors.grey.shade900,
                fontFamily: 'Lohit Tamil',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Center(
            child: Text(prop,
              style: TextStyle(
                color: Colors.grey.shade900,
                fontFamily: 'Lohit Tamil',
                fontSize: 15,
                letterSpacing: 2,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: ElevatedButton(
                
                onPressed: (){
                   Navigator.of(context).pop();
                },
                
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                ),

                child: Text('Ok',
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
