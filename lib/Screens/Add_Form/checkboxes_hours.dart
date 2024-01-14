/// # CheckboxHours
/// ## Creates the checkbox widget for the personalized attraction form and collects information about opening hours
/// 
/// Creates three checkboxes for three opening hours options: Always open, same opening hours every day
/// and different opening hours every day. 
/// When "Always open" is checked, the getOpeningHours returns 0000 for every opening and closing hour.
/// When "Same hours every day" is checked, a new textField appears to collect information about the opening hours.
/// When "Different hours every day" is checked, seven textFields appear to specify the opening hours each day of the week.

import 'package:flutter/material.dart';
import 'package:journey_joy_client/Tiles/HourFormTile.dart';

class CheckboxHours extends StatefulWidget {
  const CheckboxHours({Key? key}) : super(key: key);

  @override
  CheckboxHoursState createState() => CheckboxHoursState();
}

class CheckboxHoursState extends State<CheckboxHours> {

  final TextEditingController _sameHoursControllerOpen = TextEditingController();
  final TextEditingController _sameHoursControllerClose = TextEditingController();

  final TextEditingController _mondayControllerOpen = TextEditingController();
  final TextEditingController _mondayControllerClose = TextEditingController();

  final TextEditingController _tuesdayControllerOpen = TextEditingController();
  final TextEditingController _tuesdayControllerClose = TextEditingController();

  final TextEditingController _wednesdayControllerOpen = TextEditingController();
  final TextEditingController _wednesdayControllerClose = TextEditingController();

  final TextEditingController _thursdayControllerOpen = TextEditingController();
  final TextEditingController _thursdayControllerClose = TextEditingController();

  final TextEditingController _fridayControllerOpen = TextEditingController();
  final TextEditingController _fridayControllerClose = TextEditingController();

  final TextEditingController _saturdayControllerOpen = TextEditingController();
  final TextEditingController _saturdayControllerClose = TextEditingController();
  
  final TextEditingController _sundayControllerOpen = TextEditingController();
  final TextEditingController _sundayControllerClose = TextEditingController();


  bool isCheckedAlwaysOpen = true;
  bool isCheckedSameHours = false;
  bool isCheckedDiffHours = false;

  List<List<String>> getOpeningHours(){
    List<List<String>> openingHours = List.generate(7, (_) => List<String>.filled(2, ''));

    if(isCheckedAlwaysOpen){
      
      for (int i = 0; i < openingHours.length; i++) {
        openingHours[i][0] = '0000';
        openingHours[i][1] = '2400';
      }

    }else if( isCheckedSameHours){
       var hours = getHours(_sameHoursControllerOpen.text, _sameHoursControllerClose.text);

      for (int i = 0; i < openingHours.length; i++) {
        openingHours[i][0] = hours[0];
        openingHours[i][1] = hours[1];
      }

    }else{
      var mon = getHours(_mondayControllerOpen.text, _mondayControllerClose.text);
      openingHours[0][0] = mon[0];
      openingHours[0][1] = mon[1];

      var tue = getHours(_tuesdayControllerOpen.text, _tuesdayControllerClose.text);
      openingHours[1][0] = tue[0];
      openingHours[1][1] = tue[1];

      var wed = getHours(_wednesdayControllerOpen.text, _wednesdayControllerClose.text);
      openingHours[2][0] = wed[0];
      openingHours[2][1] = wed[1];

      var thu = getHours(_thursdayControllerOpen.text, _thursdayControllerClose.text);
      openingHours[3][0] = thu[0];
      openingHours[3][1] = thu[1];

      var fri = getHours(_fridayControllerOpen.text, _fridayControllerClose.text);
      openingHours[4][0] = fri[0];
      openingHours[4][1] = fri[1];

      var sat = getHours(_saturdayControllerOpen.text, _saturdayControllerClose.text);
      openingHours[5][0] = sat[0];
      openingHours[5][1] = sat[1];

      var sun = getHours(_sundayControllerOpen.text, _sundayControllerClose.text);
      openingHours[6][0] = sun[0];
      openingHours[6][1] = sun[1];
    }

    return openingHours;
  }

  @override
  Widget build(BuildContext context) {

    _sameHoursControllerOpen.text = '00:00';
    _sameHoursControllerClose.text = '23:59';

    _mondayControllerOpen.text = '00:00';
    _mondayControllerClose.text = '23:59';

    _tuesdayControllerOpen.text = '00:00';
    _tuesdayControllerClose.text = '23:59';

    _wednesdayControllerOpen.text = '00:00';
    _wednesdayControllerClose.text = '23:59';

    _thursdayControllerOpen.text = '00:00';
    _thursdayControllerClose.text = '23:59'; 

    _fridayControllerOpen.text = '00:00';
    _fridayControllerClose.text = '23:59'; 

    _saturdayControllerOpen.text = '00:00';
    _saturdayControllerClose.text = '23:59'; 

    _sundayControllerOpen.text = '00:00';
    _sundayControllerClose.text = '23:59'; 

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
          child: HoursFormTile(
            label: 'Set opening hours',
            controllerOpen: _sameHoursControllerOpen,
            controllerClose: _sameHoursControllerClose,
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
                HoursFormTile(
                  label: 'Monday',
                  controllerOpen: _mondayControllerOpen,
                  controllerClose: _mondayControllerClose,
                ),
                HoursFormTile(
                  label: 'Tuesday',
                  controllerOpen: _tuesdayControllerOpen,
                  controllerClose: _tuesdayControllerClose,
                ),

                HoursFormTile(
                  label: 'Wednesday',
                  controllerOpen: _wednesdayControllerOpen,
                  controllerClose: _wednesdayControllerClose,
                ),

                HoursFormTile(
                  label: 'Thursday',
                  controllerOpen: _thursdayControllerOpen,
                  controllerClose: _thursdayControllerClose,
                ),

                HoursFormTile(
                  label: 'Friday',
                  controllerOpen: _fridayControllerOpen,
                  controllerClose: _fridayControllerClose,
                ),

                HoursFormTile(
                  label: 'Saturday',
                  controllerOpen: _saturdayControllerOpen,
                  controllerClose: _saturdayControllerClose,
                ),

                HoursFormTile(
                  label: 'Sunday',
                  controllerOpen: _sundayControllerOpen,
                  controllerClose: _sundayControllerClose,
                ),

              ],
            ),
          ),

        ],
    );
  }
}

List<String> getHours(String inputOpen, String inputClose) {
  String part1 = inputOpen.replaceAll(RegExp(r'[^0-9]'), '');
  String part2 = inputClose.replaceAll(RegExp(r'[^0-9]'), '');

  return [part1, part2];
}