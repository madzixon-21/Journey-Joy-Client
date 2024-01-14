/// # Form
/// ## Form screen used for collecting data about a personalized attraction.
/// 
/// Contains text fields for collecting attraction details and location data.
/// Uses checkBoxPrices and chackBoxHours for collecting information about opening hours and prices.

import 'package:flutter/material.dart';
import 'package:journey_joy_client/Tiles/FormTile.dart';
import 'package:journey_joy_client/Screens/Add%20Form/checkboxes_hours.dart';
import 'package:journey_joy_client/Screens/Add%20Form/checkboxes_prices.dart';
import 'package:journey_joy_client/Tiles/FormTileSmall.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journey_joy_client/Classes/attraction.dart';
import 'package:journey_joy_client/Classes/Functions/add_attraction.dart';
import 'package:journey_joy_client/Dialogs/error_dialog.dart';

class Form extends StatefulWidget {

  final String token;
  final String tripId;
 
  const Form({required this.token, required this.tripId, super.key});

  @override
  FormState createState() => FormState();
}

class FormState extends State<Form> {
  final TextEditingController _attractionNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  final TextEditingController _street1Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  late List<int>? imageBytes;

  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageBytes = await pickedFile.readAsBytes();
    }
  }

 final GlobalKey<CheckboxPricesState> pricesKey = GlobalKey<CheckboxPricesState>();
 final GlobalKey<CheckboxHoursState> hoursKey = GlobalKey<CheckboxHoursState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 219, 235, 199),
        title: const Text('Create a new attraction',
        style: TextStyle(
          color:  Colors.black,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(
                width: 300, 
                child: Text('Attraction details',
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

                    FormTile(
                      label: 'Attraction name:',
                      description: 'Name',
                      controller: _attractionNameController,
                    ),

                    FormTile(
                      label: 'Description:',
                      description: 'Description',
                      controller: _descriptionController,
                    ),

                    Row(
                      children: [
                        const SizedBox(width: 8,),

                        SizedBox(
                          width: 125, 
                          child: Text('Picture',
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
                          child:  Row(
                            children: [
                              Icon(
                                Icons.add_a_photo_rounded,
                                color: Colors.grey.shade900,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text('Choose photo',
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

                    FormTile(
                      label: 'Time needed:',
                      description: 'Time in minutes',
                      controller: _timeController,
                    ),
                  ],
                )
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: 300, 
                child: Text('Add the location',
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

                    const SizedBox(height: 10,),
                  
                    FormTileSmall(
                      label: 'Street:',
                      description: 'Add street name',
                      controller: _street1Controller,
                    ),

                    FormTileSmall(
                      label: 'City:',
                      description: 'Add city',
                      controller: _cityController,
                    ),

                    FormTileSmall(
                      label: 'State:',
                      description: 'Add state',
                      controller: _stateController,
                    ),

                    FormTileSmall(
                      label: 'Country:',
                      description: 'Add country',
                      controller: _countryController,
                    ),

                    FormTileSmall(
                      label: 'Postal code:',
                      description: '00000',
                      controller: _postalCodeController,
                    ),

                    FormTileSmall(
                      label: 'Address:',
                      description: 'Add address',
                      controller: _addressController,
                    ),

                    FormTileSmall(
                      label: 'Phone:',
                      description: '000 000 000',
                      controller: _phoneController,
                    ),

                  ],
                )
              ),

              const SizedBox(height: 25),

              SizedBox(
                  width: 300, 
                  child: Text('Specify the opening hours',
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
                child: CheckboxHours( key: hoursKey)),

              const SizedBox(height: 25),

              SizedBox(
                  width: 300, 
                  child: Text('Specify the prices',
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
                child: CheckboxPrices( key: pricesKey)),

              const SizedBox(height: 20),

              Center(
                child: TextButton(
                  onPressed: () {
                    Address ad = Address(
                      street1: _street1Controller.text, 
                      city: _cityController.text, 
                      state: _stateController.text, 
                      country: _countryController.text, 
                      postalcode: _postalCodeController.text, 
                      address: _addressController.text, 
                      phone: _phoneController.text, 
                      latitude: 0, 
                      longitude: 0);

                      List<String> prices = pricesKey.currentState?.getPrices() ?? [];
                      List<List<String>> openingHours = hoursKey.currentState?.getOpeningHours() ?? [];

                      AddAttractionAction().add(
                        _attractionNameController.text,
                        ad,
                        _descriptionController.text,
                        imageBytes,
                        _timeController.text,
                        openingHours,
                        prices,
                        '',
                        widget.tripId,
                        widget.token,
                      ).then((bool successful) {
                        if (successful) {
                          Navigator.of(context).pop();
                        } else {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => const ErrorDialog(prop: "We couldn't add the attraction to your trip."),
                          );
                        }
                      });
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text('Add attraction',
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
      ),
    );
  }
}