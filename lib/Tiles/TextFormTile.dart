import 'package:flutter/material.dart';

class TextFormTile extends StatelessWidget {
  final String label;
  final String description;
  final TextEditingController controller;

  const TextFormTile(
      {required this.label,
      required this.description,
      required this.controller,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 8,
              ),
              SizedBox(
                width: 100,
                height: 50,
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontFamily: 'Lohit Tamil',
                    fontSize: 15,
                    letterSpacing: 2,
                  ),
                ),
              ),

              const SizedBox(width: 9),

              SizedBox(
                width: 250,
                child: TextFormField(
                  maxLines: 3,
                  minLines: 1,
                  maxLength: 50,
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Enter $description',
                    hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Lohit Tamil',
                        letterSpacing: 1.5,
                        fontSize: 14),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 12),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter $description';
                    }
                    return null;
                  },
                ),
              )
            ],
          ),
          //const SizedBox(height: 2),
        ],
      ),
    );
  }
}