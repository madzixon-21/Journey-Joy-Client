/// # Form Tile Small
/// ## Used to collect data for the attraction form.
import 'package:flutter/material.dart';

class FormTileSmall extends StatelessWidget {
  final String label;
  final String description;
  final TextEditingController controller;

  const FormTileSmall({required this.label, required this.description, required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 25), 

              SizedBox(
                width: 130, 
                child: Text(label,
                      style: TextStyle(
                        color: Colors.grey.shade900,
                        fontFamily: 'Lohit Tamil',
                        fontSize: 13,
                        letterSpacing: 2,
                        ),
                      ),
                ),
              
              const SizedBox(width: 6), 

              SizedBox(
                width: 180,
                height: 35,
                child: TextField(
                maxLines: null,
                  controller: controller,
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontFamily: 'Lohit Tamil',
                    letterSpacing: 1.5,
                  ),
                  decoration: InputDecoration(
                    hintText: description,
                    hintStyle: TextStyle(
                      color: Colors.grey.shade700, 
                      fontFamily: 'Lohit Tamil', 
                      letterSpacing: 1.5,
                      fontSize: 12
                      ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              
            ],
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}