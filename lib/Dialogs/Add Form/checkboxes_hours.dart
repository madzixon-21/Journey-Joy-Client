/// # CheckboxHours
/// ## Creates the checkbox widget for the personalized attraction form 

import 'package:flutter/material.dart';
import 'package:journey_joy_client/Tiles/FormTileSmall.dart';

class CheckboxHours extends StatefulWidget {
  const CheckboxHours({Key? key}) : super(key: key);

  @override
  CheckboxHoursState createState() => CheckboxHoursState();
}

class CheckboxHoursState extends State<CheckboxHours> {

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
  bool isCheckedDiffHours = false;

  List<List<String>> getOpeningHours(){
    List<List<String>> openingHours = List.generate(7, (_) => List<String>.filled(2, ''));

    if(isCheckedAlwaysOpen){
      
      for (int i = 0; i < openingHours.length; i++) {
        for (int j = 0; j < openingHours[i].length; j++) {
          openingHours[i][j] = '0000';
        }
      }

    }else if( isCheckedSameHours){
      var hours = getHours(_sameHoursController.text);

      for (int i = 0; i < openingHours.length; i++) {
        openingHours[i][0] = hours[0];
        openingHours[i][1] = hours[1];
      }

    }else{
      var mon = getHours(_mondayController.text);
      openingHours[0][0] = mon[0];
      openingHours[0][1] = mon[1];

      var tue = getHours(_tuesdayController.text);
      openingHours[1][0] = tue[0];
      openingHours[1][1] = tue[1];

      var wed = getHours(_wednesdayController.text);
      openingHours[2][0] = wed[0];
      openingHours[2][1] = wed[1];

      var thu = getHours(_thursdayController.text);
      openingHours[3][0] = thu[0];
      openingHours[3][1] = thu[1];

      var fri = getHours(_fridayController.text);
      openingHours[4][0] = fri[0];
      openingHours[4][1] = fri[1];

      var sat = getHours(_saturdayController.text);
      openingHours[5][0] = sat[0];
      openingHours[6][1] = sat[1];

      var sun = getHours(_sundayController.text);
      openingHours[7][0] = sun[0];
      openingHours[7][1] = sun[1];
    }

    return openingHours;
  }

  @override
  Widget build(BuildContext context) {
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