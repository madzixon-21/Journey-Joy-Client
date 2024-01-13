import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journey_joy_client/Screens/Add_Form/checkboxes_hours.dart';
import 'package:journey_joy_client/Screens/Add_Form/checkboxes_prices.dart';
import 'package:journey_joy_client/Tiles/FormTileSmall.dart';
import 'package:journey_joy_client/Tiles/NumberFormTile.dart';
import 'package:journey_joy_client/Tiles/TextFormTile.dart';

class AddForm extends StatefulWidget {
  const AddForm({super.key});

  @override
  AddFormState createState() {
    return AddFormState();
  }
}

class AddFormState extends State<AddForm> {
  final TextEditingController _attractionNameController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  final TextEditingController _street1Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  late List<int>? imageBytes;

  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageBytes = await pickedFile.readAsBytes();
    }
  }

  final GlobalKey<CheckboxPricesState> pricesKey =
      GlobalKey<CheckboxPricesState>();
  final GlobalKey<CheckboxHoursState> hoursKey =
      GlobalKey<CheckboxHoursState>();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 300,
            child: Text(
              'Attraction details',
              style: TextStyle(
                color: Colors.grey.shade900,
                fontFamily: 'Lohit Tamil',
                fontSize: 15,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.grey.shade500,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  TextFormTile(
                    label: 'Name',
                    description: 'name',
                    controller: _attractionNameController,
                  ),
                  TextFormTile(
                    label: 'Description',
                    description: 'description',
                    controller: _descriptionController,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 5.0),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 8,
                        ),
                        SizedBox(
                          width: 125,
                          child: Text(
                            'Picture',
                            style: TextStyle(
                              color: Colors.grey.shade900,
                              fontFamily: 'Lohit Tamil',
                              fontSize: 15,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        const SizedBox(width: 19),
                        ElevatedButton(
                          onPressed: () async {
                            await getImage();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add_a_photo_rounded,
                                color: Colors.grey.shade900,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Choose photo',
                                style: TextStyle(
                                  color: Colors.grey.shade900,
                                  fontFamily: 'Lohit Tamil',
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  NumberFormTile(
                    label: 'Time needed',
                    description: 'time in minutes',
                    controller: _timeController,
                  ),
                ],
              )),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: 300,
            child: Text(
              'Add the location',
              style: TextStyle(
                color: Colors.grey.shade900,
                fontFamily: 'Lohit Tamil',
                fontSize: 15,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.grey.shade500,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  TextFormTile(
                    label: 'Street:',
                    description: 'Add street name',
                    controller: _street1Controller,
                  ),
                  TextFormTile(
                    label: 'City:',
                    description: 'Add city',
                    controller: _cityController,
                  ),
                  TextFormTile(
                    label: 'Country:',
                    description: 'Add country',
                    controller: _countryController,
                  ),
                ],
              )),
          const SizedBox(height: 25),
          SizedBox(
            width: 300,
            child: Text(
              'Specify the opening hours',
              style: TextStyle(
                color: Colors.grey.shade900,
                fontFamily: 'Lohit Tamil',
                fontSize: 15,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.grey.shade500,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: CheckboxHours(key: hoursKey)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
