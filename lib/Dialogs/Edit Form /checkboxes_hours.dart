import 'package:flutter/material.dart';
import 'package:journey_joy_client/Tiles/FormTileSmall.dart';

class EditCheckboxHours extends StatefulWidget {
  List<List<String>> opening_hours;
  EditCheckboxHours({required this.opening_hours, Key? key}) : super(key: key);

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

  bool isChecked_alwaysOpen = false;
  bool isChecked_sameHours = false;
  bool isChecked_diffHours = true;

  @override
  void initState() {
    super.initState();

    setState(() {
      isChecked_diffHours = true;
      isChecked_alwaysOpen = false;
      isChecked_sameHours = false;
    });
  }

  List<List<String>> GetOpeningHours(){

    if(widget.opening_hours.isEmpty){
          widget.opening_hours = List.generate(7, (_) => List<String>.filled(2, ''));

    }

    if(isChecked_alwaysOpen){
      
      for (int i = 0; i < widget.opening_hours.length; i++) {
        for (int j = 0; j < widget.opening_hours[i].length; j++) {
          widget.opening_hours[i][j] = '1';
        }
      }

    }else if( isChecked_sameHours){
      var hours = GetHours(_sameHoursController.text);

      for (int i = 0; i < widget.opening_hours.length; i++) {
        widget.opening_hours[i][0] = hours[0];
        widget.opening_hours[i][1] = hours[1];
      }

    }else{
      var mon = GetHours(_mondayController.text);
      widget.opening_hours[0][0] = mon[0];
      widget.opening_hours[0][1] = mon[1];

      var tue = GetHours(_tuesdayController.text);
      widget.opening_hours[1][0] = tue[0];
      widget.opening_hours[1][1] = tue[1];

      var wed = GetHours(_wednesdayController.text);
      widget.opening_hours[2][0] = wed[0];
      widget.opening_hours[2][1] = wed[1];

      var thu = GetHours(_thursdayController.text);
      widget.opening_hours[3][0] = thu[0];
      widget.opening_hours[3][1] = thu[1];

      var fri = GetHours(_fridayController.text);
      widget.opening_hours[4][0] = fri[0];
      widget.opening_hours[4][1] = fri[1];

      var sat = GetHours(_saturdayController.text);
      widget.opening_hours[5][0] = sat[0];
      widget.opening_hours[5][1] = sat[1];

      var sun = GetHours(_sundayController.text);
      widget.opening_hours[6][0] = sun[0];
      widget.opening_hours[6][1] = sun[1];
    }

    return widget.opening_hours;
  }

  @override
  Widget build(BuildContext context) {

    if(widget.opening_hours.isEmpty){
      _mondayController.text = "00:00 - 00:00";
      _tuesdayController.text = "00:00 - 00:00";
      _wednesdayController.text = "00:00 - 00:00";
      _thursdayController.text = "00:00 - 00:00";
      _fridayController.text = "00:00 - 00:00";
      _saturdayController.text = "00:00 - 00:00";
      _sundayController.text = "00:00 - 00:00";
    }else{
      _mondayController.text = getHoursString(widget.opening_hours[0]);
      _tuesdayController.text = getHoursString(widget.opening_hours[1]);
      _wednesdayController.text = getHoursString(widget.opening_hours[2]);
      _thursdayController.text = getHoursString(widget.opening_hours[3]);
      _fridayController.text = getHoursString(widget.opening_hours[4]);
      _saturdayController.text = getHoursString(widget.opening_hours[5]);
      _sundayController.text = getHoursString(widget.opening_hours[6]);
    }

    return Column(
      children: [

        Row(
          children: [
            Checkbox(
              value: isChecked_alwaysOpen,
              checkColor: Colors.grey.shade900,
              activeColor: Colors.transparent,
              onChanged: (value){
                setState(() {
                  isChecked_alwaysOpen = value ?? false;
                  isChecked_diffHours = false;
                  isChecked_sameHours = false;
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
              value: isChecked_sameHours,
              checkColor: Colors.grey.shade900,
              activeColor: Colors.transparent,
              onChanged: (value){
                setState(() {
                  isChecked_sameHours = value ?? false;
                  isChecked_alwaysOpen = false;
                  isChecked_diffHours = false;
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
          visible: isChecked_sameHours,
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
              value: isChecked_diffHours,
              checkColor: Colors.grey.shade900,
              activeColor: Colors.transparent,
              onChanged: (value){
                setState(() {
                  isChecked_diffHours = value ?? false;
                  isChecked_alwaysOpen = false;
                  isChecked_sameHours = false;
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
            visible: isChecked_diffHours,
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

List<String> GetHours(String input) {
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