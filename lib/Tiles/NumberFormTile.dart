import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberFormTile extends StatelessWidget {
  final String label;
  final String description;
  final TextEditingController controller;

  const NumberFormTile(
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
                height: 70,
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
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  maxLength: 4,
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
                    else if (int.parse(value) > 1440){
                      return 'Time should be less than 1440';
                    }
                    else if (int.parse(value) < 0){
                      return 'Time should be positive';
                    }
                    return null;
                  },
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
