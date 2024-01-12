/// # EditCheckboxHours
/// ## Creates the checkbox widget for the personalized attraction form and edits information about opening hours
/// 
/// Creates three checkboxes for three opening hours options: Always open, same opening hours every day
/// and different opening hours every day. 
/// When "Always open" is checked, the getOpeningHours returns 0000 for every opening and closing hour.
/// When "Same hours every day" is checked, a new textField appears to collect information about the opening hours.
/// When "Different hours every day" is checked, seven textFields appear to specify the opening hours each day of the week.
/// By default, "Different hours every day" is checked and the text fields are filled with the attraction openin hours.

import 'package:flutter/material.dart';
import 'package:journey_joy_client/Tiles/FormTileSmall.dart';

class EditCheckboxHours extends StatefulWidget {
  final List<List<String>> openingHours;
  const EditCheckboxHours({required this.openingHours, Key? key}) : super(key: key);

  @override
  EditCheckboxHoursState createState() => EditCheckboxHoursState();
}

class EditCheckboxHoursState extends State<EditCheckboxHours> {

  final TextEditingController _sameHoursController = TextEditingController();
  final TextEditingController _mondayController = TextEditingController();
  final TextEditingController _tuesdayController = TextEditingController();
  final TextEditingController _wednesdayController = TextEditingController();
  final TextEditingController _thursdayController = TextEditingController();
  final TextEditingController _fridayController = TextEditingController();
  final TextEditingController _saturdayController = TextEditingController();
  final TextEditingController _sundayController = TextEditingController();

  bool isCheckedAlwaysOpen = false;
  bool isCheckedSameHours = false;
  bool isCheckedDiffHours = true;

  late List<List<String>> mutableOpeningHours;

  @override
  void initState() {
    super.initState();
    mutableOpeningHours = List.from(widget.openingHours);
  }

  List<List<String>> getOpeningHours(){

    if(mutableOpeningHours.isEmpty){
      mutableOpeningHours = List.generate(7, (_) => List<String>.filled(2, ''));
    }

    if(isCheckedAlwaysOpen){
      
      for (int i = 0; i < mutableOpeningHours.length; i++) {
        mutableOpeningHours[i][0] = '0000';
        mutableOpeningHours[i][1] = '2400';
      }

    }else if( isCheckedSameHours){
      var hours = getHours(_sameHoursController.text);

      for (int i = 0; i < mutableOpeningHours.length; i++) {
        mutableOpeningHours[i][0] = hours[0];
        mutableOpeningHours[i][1] = hours[1];
      }

    }else{
      var mon = getHours(_mondayController.text);
      mutableOpeningHours[0][0] = mon[0];
      mutableOpeningHours[0][1] = mon[1];

      var tue = getHours(_tuesdayController.text);
      mutableOpeningHours[1][0] = tue[0];
      mutableOpeningHours[1][1] = tue[1];

      var wed = getHours(_wednesdayController.text);
      mutableOpeningHours[2][0] = wed[0];
      mutableOpeningHours[2][1] = wed[1];

      var thu = getHours(_thursdayController.text);
      mutableOpeningHours[3][0] = thu[0];
      mutableOpeningHours[3][1] = thu[1];

      var fri = getHours(_fridayController.text);
      mutableOpeningHours[4][0] = fri[0];
      mutableOpeningHours[4][1] = fri[1];

      var sat = getHours(_saturdayController.text);
      mutableOpeningHours[5][0] = sat[0];
      mutableOpeningHours[5][1] = sat[1];

      var sun = getHours(_sundayController.text);
      mutableOpeningHours[6][0] = sun[0];
      mutableOpeningHours[6][1] = sun[1];
    }

    return mutableOpeningHours;
  }

  @override
  Widget build(BuildContext context) {

    if(widget.openingHours.isEmpty){
      _mondayController.text = "00:00 - 24:00";
      _tuesdayController.text = "00:00 - 24:00";
      _wednesdayController.text = "00:00 - 24:00";
      _thursdayController.text = "00:00 - 24:00";
      _fridayController.text = "00:00 - 24:00";
      _saturdayController.text = "00:00 - 24:00";
      _sundayController.text = "00:00 - 24:00";
    }else{
      _mondayController.text = getHoursString(widget.openingHours[0]);
      _tuesdayController.text = getHoursString(widget.openingHours[1]);
      _wednesdayController.text = getHoursString(widget.openingHours[2]);
      _thursdayController.text = getHoursString(widget.openingHours[3]);
      _fridayController.text = getHoursString(widget.openingHours[4]);
      _saturdayController.text = getHoursString(widget.openingHours[5]);
      _sundayController.text = getHoursString(widget.openingHours[6]);
    }

    return Column(
      children: [

        Row(
          children: [
            Checkbox(
              value: isCheckedAlwaysOpen,
              checkColor: Colors.grey.shade900,
              activeColor: Colors.transparent,
              onChanged: (value){
                setState(() {
                  isCheckedAlwaysOpen = value ?? false;
                  isCheckedDiffHours = false;
                  isCheckedSameHours = false;
                });
              }
            ),
            const SizedBox(width: 8), 
            Text(
              'Always open',
              style: TextStyle(
                color: Colors.grey.shade900,
                fontFamily: 'Lohit Tamil',
                letterSpacing: 2,
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        Row(
          children: [
            Checkbox(
              value: isCheckedSameHours,
              checkColor: Colors.grey.shade900,
              activeColor: Colors.transparent,
              onChanged: (value){
                setState(() {
                  isCheckedSameHours = value ?? false;
                  isCheckedAlwaysOpen = false;
                  isCheckedDiffHours = false;
                });
              },
            ),

            const SizedBox(width: 8), 

            Text(
              'Same opening hours everyday',
              style: TextStyle(
                color: Colors.grey.shade900,
                fontFamily: 'Lohit Tamil',
                letterSpacing: 2,
              ),
            ),
          ],
        ),

        Visibility(
          visible: isCheckedSameHours,
          child: FormTileSmall(
            label: 'Set opening hours:',
            description: '00:00 - 00:00',
            controller: _sameHoursController,
          ),
        ),

        const SizedBox(height: 10),

        Row(
          children: [
            Checkbox(
              value: isCheckedDiffHours,
              checkColor: Colors.grey.shade900,
              activeColor: Colors.transparent,
              onChanged: (value){
                setState(() {
                  isCheckedDiffHours = value ?? false;
                  isCheckedAlwaysOpen = false;
                  isCheckedSameHours = false;
                });
              },
            ),
            const SizedBox(width: 8), 
            Text(
              'Specific opening hours',
              style: TextStyle(
                color: Colors.grey.shade900,
                fontFamily: 'Lohit Tamil',
                letterSpacing: 2,
              ),
            ),
          ],
        ),

        Visibility(
            visible: isCheckedDiffHours,
            child: Column(
              children: [
                FormTileSmall(
                  label: 'Monday:',
                  description: '00:00 - 00:00',
                  controller: _mondayController,
                ),
                const SizedBox(height: 8),
                FormTileSmall(
                  label: 'Tuesday:',
                  description: '00:00 - 00:00',
                  controller: _tuesdayController,
                ),
                const SizedBox(height: 8),
                FormTileSmall(
                  label: 'Wednesday:',
                  description: '00:00 - 00:00',
                  controller: _wednesdayController,
                ),
                const SizedBox(height: 8),
                FormTileSmall(
                  label: 'Thursday:',
                  description: '00:00 - 00:00',
                  controller: _thursdayController,
                ),
                const SizedBox(height: 8),
                FormTileSmall(
                  label: 'Friday:',
                  description: '00:00 - 00:00',
                  controller: _fridayController,
                ),
                const SizedBox(height: 8),
                FormTileSmall(
                  label: 'Saturday:',
                  description: '00:00 - 00:00',
                  controller: _saturdayController,
                ),
                const SizedBox(height: 8),
                FormTileSmall(
                  label: 'Sunday:',
                  description: '00:00 - 00:00',
                  controller: _sundayController,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),

        ],
    );
  }
}

List<String> getHours(String input) {
  String numericString = input.replaceAll(RegExp(r'[^0-9]'), '');

  String part1 = numericString.substring(0, 4);
  String part2 = numericString.substring(4);

  return [part1, part2];
}

String getHoursString(List<String> openingHours) {

    if(openingHours.isEmpty){
      return "00:00 - 00:00";
    }
    else{
    String openingHour = openingHours[0];
    String closingHour = openingHours[1];

    String openingHourString = openingHour.substring(0, 2);
    String openingMinuteString = openingHour.substring(2, 4);
    String closingHourString = closingHour.substring(0, 2);
    String closingMinuteString = closingHour.substring(2, 4);

    return "$openingHourString:$openingMinuteString - $closingHourString:$closingMinuteString";
    }
  }