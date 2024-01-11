import 'package:flutter/material.dart';
import 'package:journey_joy_client/Tiles/FormTile.dart';
import 'package:journey_joy_client/Dialogs/Edit Form /checkboxes_hours.dart';
import 'package:journey_joy_client/Dialogs/Edit Form /checkboxes_prices.dart';
import 'package:journey_joy_client/Tiles/FormTileSmall.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journey_joy_client/Classes/attraction.dart';
import 'package:journey_joy_client/Classes/Functions/edit_attraction.dart';
import 'package:journey_joy_client/Dialogs/error_dialog.dart';

class EditFormDialog extends StatelessWidget {

  AttractionToAdd attraction;
  final String token;
  final String tripId;

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
  
 

  EditFormDialog({required this.attraction, required this.token, required this.tripId, super.key});

  List<int>? imageBytes;

  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageBytes = await pickedFile.readAsBytes();
    }
  }

 final GlobalKey<EditCheckboxPricesState> pricesKey = GlobalKey<EditCheckboxPricesState>();
 final GlobalKey<EditCheckboxHoursState> hoursKey = GlobalKey<EditCheckboxHoursState>();

  @override
  Widget build(BuildContext context) {
    _attractionNameController.text = attraction.name;
    _descriptionController.text = attraction.description;
    _timeController.text = attraction.timeNeeded.toString();
    _street1Controller.text = attraction.location.street1;
    _cityController.text = attraction.location.city;
    _stateController.text = attraction.location.state;
    _countryController.text =attraction.location.country;
    _postalCodeController.text = attraction.location.postalcode;
    _addressController.text = attraction.location.address;
    _phoneController.text = attraction.location.phone;

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
                child: Text('Edit attraction ${attraction.name}',
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
                child: EditCheckboxHours(opening_hours: attraction.openHours, key: hoursKey)),

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
                child: EditCheckboxPrices(prices: attraction.prices, key: pricesKey)),

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

                      List<String> prices = pricesKey.currentState?.GetPrices() ?? [];
                      List<List<String>> opening_hours = hoursKey.currentState?.GetOpeningHours() ?? [];

                      EditAttractionAction().edit(
                        _attractionNameController.text,
                        ad,
                        _descriptionController.text,
                        imageBytes,
                        _timeController.text,
                        opening_hours,
                        prices,
                        '',
                        tripId,
                        token,
                      ).then((bool successful) {
                        if (successful) {
                          Navigator.of(context).pop();
                        } else {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => ErrorDialog(prop: "We couldn't edit the attraction"),
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