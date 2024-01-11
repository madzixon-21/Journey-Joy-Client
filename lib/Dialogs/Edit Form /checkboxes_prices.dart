import 'package:flutter/material.dart';
import 'package:journey_joy_client/Tiles/FormTileSmall.dart';

class EditCheckboxPrices extends StatefulWidget {
  List<String> prices;
  EditCheckboxPrices({required this.prices, Key? key}) : super(key: key);

  @override
  EditCheckboxPricesState createState() => EditCheckboxPricesState();
}

class EditCheckboxPricesState extends State<EditCheckboxPrices> {

  final TextEditingController _samePriceController = TextEditingController();
  final TextEditingController _mondayController = TextEditingController();
  final TextEditingController _tuesdayController = TextEditingController();
  final TextEditingController _wednesdayController = TextEditingController();
  final TextEditingController _thursdayController = TextEditingController();
  final TextEditingController _fridayController = TextEditingController();
  final TextEditingController _saturdayController = TextEditingController();
  final TextEditingController _sundayController = TextEditingController();

  bool isChecked_free = false;
  bool isChecked_samePrice = false;
  bool isChecked_diffPrice = true;

  List<String> GetPrices(){
    if(widget.prices.isEmpty){
      widget.prices = List.generate(7, (index) => '');
    }

    if(isChecked_free){
      
      for (int i = 0; i < widget.prices.length; i++) {
        widget.prices[i] = '0';
      }

    }else if( isChecked_samePrice){

      for (int i = 0; i < widget.prices.length; i++) {
        widget.prices[i] = _samePriceController.text;
      }

    }else{
      widget.prices[0] = _mondayController.text;
      widget.prices[1] = _tuesdayController.text;
      widget.prices[2] = _wednesdayController.text;
      widget.prices[3] = _thursdayController.text;
      widget.prices[4] = _fridayController.text;
      widget.prices[5] = _saturdayController.text;
      widget.prices[6] = _sundayController.text;
    }

    return widget.prices;
  }

  @override
  Widget build(BuildContext context) {
    if(widget.prices.isEmpty){
      _mondayController.text = "00.00";
      _tuesdayController.text = "00.00";
      _wednesdayController.text = "00.00";
      _thursdayController.text = "00.00";
      _fridayController.text = "00.00";
      _saturdayController.text = "00.00";
      _sundayController.text = "00.00";
    }else{
      _mondayController.text = widget.prices[0];
      _tuesdayController.text = widget.prices[1];
      _wednesdayController.text = widget.prices[2];
      _thursdayController.text = widget.prices[3];
      _fridayController.text = widget.prices[4];
      _saturdayController.text = widget.prices[5];
      _sundayController.text = widget.prices[6];
    }


    return Column(
      children: [

        Row(
          children: [
            Checkbox(
              value: isChecked_free,
              checkColor: Colors.grey.shade900,
              activeColor: Colors.transparent,
              onChanged: (value){
                setState(() {
                  isChecked_free= value ?? false;
                  isChecked_diffPrice= false;
                  isChecked_samePrice = false;
                });
              }
            ),
            const SizedBox(width: 8), 
            Text(
              'Always free',
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
              value: isChecked_samePrice,
              checkColor: Colors.grey.shade900,
              activeColor: Colors.transparent,
              onChanged: (value){
                setState(() {
                  isChecked_samePrice = value ?? false;
                  isChecked_free = false;
                  isChecked_diffPrice = false;
                });
              },
            ),

            const SizedBox(width: 8), 

            Text(
              'Same price everyday',
              style: TextStyle(
                color: Colors.grey.shade900,
                fontFamily: 'Lohit Tamil',
                letterSpacing: 2,
              ),
            ),
          ],
        ),

        Visibility(
          visible: isChecked_samePrice,
          child: FormTileSmall(
            label: 'Set the price:',
            description: '00.00',
            controller: _samePriceController,
          ),
        ),

        const SizedBox(height: 10),

        Row(
          children: [
            Checkbox(
              value: isChecked_diffPrice,
              checkColor: Colors.grey.shade900,
              activeColor: Colors.transparent,
              onChanged: (value){
                setState(() {
                  isChecked_diffPrice = value ?? false;
                  isChecked_free = false;
                  isChecked_samePrice = false;
                });
              },
            ),
            const SizedBox(width: 8), 
            Text(
              'Specific prices',
              style: TextStyle(
                color: Colors.grey.shade900,
                fontFamily: 'Lohit Tamil',
                letterSpacing: 2,
              ),
            ),
          ],
        ),

        Visibility(
            visible: isChecked_diffPrice,
            child: Column(
              children: [
                FormTileSmall(
                  label: 'Monday:',
                  description: '00.00',
                  controller: _mondayController,
                ),
                const SizedBox(height: 8),
                FormTileSmall(
                  label: 'Tuesday:',
                  description: '00.00',
                  controller: _tuesdayController,
                ),
                const SizedBox(height: 8),
                FormTileSmall(
                  label: 'Wednesday:',
                  description: '00.00',
                  controller: _wednesdayController,
                ),
                const SizedBox(height: 8),
                FormTileSmall(
                  label: 'Thursday:',
                  description: '00.00',
                  controller: _thursdayController,
                ),
                const SizedBox(height: 8),
                FormTileSmall(
                  label: 'Friday:',
                  description: '00.00',
                  controller: _fridayController,
                ),
                const SizedBox(height: 8),
                FormTileSmall(
                  label: 'Saturday:',
                  description: '00.00',
                  controller: _saturdayController,
                ),
                const SizedBox(height: 8),
                FormTileSmall(
                  label: 'Sunday:',
                  description: '00.00',
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