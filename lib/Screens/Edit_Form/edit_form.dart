/// # Edit Form
/// ## Form screen used for editing a personalized attraction that has been added to a trip.
///
/// Contains text fields for collecting attraction details and location data.
/// Uses editCheckBoxPrices and editCheckBoxHours for collecting information about opening hours and prices.

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:journey_joy_client/Tiles/NumberFormTile.dart';
import 'package:journey_joy_client/Tiles/TextFormTile.dart';
import 'package:journey_joy_client/Screens/Edit_Form/checkboxes_hours.dart';
import 'package:journey_joy_client/Screens/Edit_Form/checkboxes_prices.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journey_joy_client/Classes/attraction.dart';
import 'package:journey_joy_client/Classes/Functions/edit_attraction.dart';
import 'package:journey_joy_client/Dialogs/error_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journey_joy_client/Cubits/trip_cubit.dart';

class EditForm extends StatefulWidget {
  final AttractionToAdd attraction;
  final String token;
  final String tripId;

  const EditForm(
      {required this.attraction,
      required this.token,
      required this.tripId,
      super.key});

  @override
  EditFormState createState() => EditFormState();
}

class EditFormState extends State<EditForm> {
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

  final GlobalKey<EditCheckboxPricesState> pricesKey =
      GlobalKey<EditCheckboxPricesState>();
  final GlobalKey<EditCheckboxHoursState> hoursKey =
      GlobalKey<EditCheckboxHoursState>();

  Widget _buildSelectedImage() {
    if (_ifPictureAdded == 1) {
      return Row(
        children: [
          const SizedBox(
            width: 15,
          ),
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

  @override
  Widget build(BuildContext context) {
    _attractionNameController.text = widget.attraction.name;
    _descriptionController.text = widget.attraction.description;
    _timeController.text = widget.attraction.timeNeeded.toString();
    _street1Controller.text = widget.attraction.location.street1;
    _cityController.text = widget.attraction.location.city;
    _countryController.text = widget.attraction.location.country;

    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 219, 235, 199),
        title: const Text(
          'Edit attraction',
          style: TextStyle(
            color: Colors.black,
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 300,
                  child: Text(
                    'Edit attraction ${widget.attraction.name}',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                          borderRadius:
                                              BorderRadius.circular(13.0),
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
                const SizedBox(height: 15),
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
                    child: EditCheckboxHours(
                        openingHours: widget.attraction.openHours,
                        key: hoursKey)),
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
                    child: EditCheckboxPrices(
                        prices: widget.attraction.prices, key: pricesKey)),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_ifPictureAdded == 0) {
                          imageBytes = List.empty();
                        }
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

                        EditAttractionAction()
                            .edit(
                          _attractionNameController.text,
                          ad,
                          _descriptionController.text,
                          imageBytes,
                          _timeController.text,
                          openingHours,
                          prices,
                          widget.attraction.tripAdvisorLocationId,
                          widget.tripId,
                          widget.token,
                        )
                            .then((bool successful) {
                          if (successful) {
                            context
                                .read<TripsCubit>()
                                .fetch(widget.token)
                                .then((_) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            });
                          } else {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  const ErrorDialog(
                                      prop: "We couldn't edit the attraction"),
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
                      'Save attraction',
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
      ),
    );
  }
}
