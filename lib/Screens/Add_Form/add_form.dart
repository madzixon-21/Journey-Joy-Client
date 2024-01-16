/// # AddForm
/// ## Form screen used for collecting data about a personalized attraction.
///
/// Contains text fields for collecting attraction details and location data.
/// Uses checkBoxPrices and chackBoxHours for collecting information about opening hours and prices.

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journey_joy_client/Classes/Functions/add_attraction.dart';
import 'package:journey_joy_client/Classes/attraction.dart';
import 'package:journey_joy_client/Dialogs/error_dialog.dart';
import 'package:journey_joy_client/Screens/Add_Form/checkboxes_hours.dart';
import 'package:journey_joy_client/Screens/Add_Form/checkboxes_prices.dart';
import 'package:journey_joy_client/Tiles/NumberFormTile.dart';
import 'package:journey_joy_client/Tiles/TextFormTile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journey_joy_client/Cubits/trip_cubit.dart';

class AddForm extends StatefulWidget {
  final String token;
  final String tripId;

  const AddForm({required this.token, required this.tripId, super.key});

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
  int _ifPictureAdded = 0;

  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageBytes = await pickedFile.readAsBytes();
      _ifPictureAdded = 1;
    }
  }

  Widget _buildSelectedImage() {
    if (_ifPictureAdded == 1) {
      return Row(
        children: [
          const SizedBox(width: 15,),
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: MemoryImage(Uint8List.fromList(imageBytes!)),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  final GlobalKey<CheckboxPricesState> pricesKey =
      GlobalKey<CheckboxPricesState>();
  final GlobalKey<CheckboxHoursState> hoursKey =
      GlobalKey<CheckboxHoursState>();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    _timeController.text = '0';
    
    return Stack(
      children: [

      Form(
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
                          width: 120,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 80,
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await getImage();
                                  setState(() {});
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(70, 60),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13.0),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add_a_photo_rounded,
                                      color: Colors.grey.shade900,
                                      size: 24,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Choose \n photo',
                                      style: TextStyle(
                                        color: Colors.grey.shade900,
                                        fontFamily: 'Lohit Tamil',
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Center(child: _buildSelectedImage()),
                          ],
                        ),
                      ],
                    ),
                  ),
                  NumberFormTile(
                    label: 'Time needed',
                    description: 'Time',
                    controller: _timeController,
                    maximumValue: 1440,
                    maxLength: 4,
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
                    label: 'Street',
                    description: 'street name',
                    controller: _street1Controller,
                  ),
                  TextFormTile(
                    label: 'City',
                    description: 'city',
                    controller: _cityController,
                  ),
                  TextFormTile(
                    label: 'Country',
                    description: 'country',
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
            child: CheckboxHours(key: hoursKey),
          ),
          const SizedBox(height: 25),
          SizedBox(
            width: 300,
            child: Text(
              'Specify the prices',
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
              child: CheckboxPrices(key: pricesKey)),
          const SizedBox(height: 20),
          Center(
            child: TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Address ad = Address(
                      street1: _street1Controller.text,
                      city: _cityController.text,
                      state: '',
                      country: _countryController.text,
                      postalcode: '',
                      address: '',
                      phone: '',
                      latitude: 0,
                      longitude: 0);

                  List<String> prices =
                      pricesKey.currentState?.getPrices() ?? [];
                  List<List<String>> openingHours =
                      hoursKey.currentState?.getOpeningHours() ?? [];

                  if (_ifPictureAdded == 0) {
                    imageBytes = List.empty();
                  }
                  setState(() {
                    isLoading = true;
                  });
                  AddAttractionAction()
                      .add(
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
                  )
                      .then((bool successful) {
                    if (successful) {
                      context.read<TripsCubit>().fetch(widget.token);
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pop(context);
                    } else {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => const ErrorDialog(
                            prop:
                                "We couldn't add the attraction to your trip."),
                      );
                    }
                  });
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                'Add attraction',
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
    
          
      Visibility(
        visible: isLoading,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.transparent, 
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        ),
      

      ],
    );

  }
}
