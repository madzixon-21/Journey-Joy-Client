/// # CheckboxPrices
/// ## Creates the checkbox widget for the personalized attraction form and collects information about prices.
/// 
/// Creates three checkboxes for three prices options: Always free, same price every day
/// and different prices every day. 
/// When "Always free" is checked, the getPrices returns 0 for every opening and closing hour.
/// When "Same price every day" is checked, a new textField appears to collect information about the price.
/// When "Different hours every day" is checked, seven textFields appear to specify the price each day of the week.

import 'package:flutter/material.dart';
import 'package:journey_joy_client/Tiles/FormTileSmall.dart';

class CheckboxPrices extends StatefulWidget {
  const CheckboxPrices({Key? key}) : super(key: key);

  @override
  CheckboxPricesState createState() => CheckboxPricesState();
}

class CheckboxPricesState extends State<CheckboxPrices> {

  final TextEditingController _samePriceController = TextEditingController();
  final TextEditingController _mondayController = TextEditingController();
  final TextEditingController _tuesdayController = TextEditingController();
  final TextEditingController _wednesdayController = TextEditingController();
  final TextEditingController _thursdayController = TextEditingController();
  final TextEditingController _fridayController = TextEditingController();
  final TextEditingController _saturdayController = TextEditingController();
  final TextEditingController _sundayController = TextEditingController();

  bool isCheckedFree = true;
  bool isCheckedSamePrice = false;
  bool isCheckedDiffPrice = false;

  List<String> getPrices(){
    List<String> prices = List.generate(7, (index) => '');

    if(isCheckedFree){
      
      for (int i = 0; i < prices.length; i++) {
        prices[i] = '0';
      }

    }else if( isCheckedSamePrice){

      for (int i = 0; i < prices.length; i++) {
        prices[i] = _samePriceController.text;
      }

    }else{
      prices[0] = _mondayController.text;
      prices[1] = _tuesdayController.text;
      prices[2] = _wednesdayController.text;
      prices[3] = _thursdayController.text;
      prices[4] = _fridayController.text;
      prices[5] = _saturdayController.text;
      prices[6] = _sundayController.text;
    }

    return prices;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Row(
          children: [
            Checkbox(
              value: isCheckedFree,
              checkColor: Colors.grey.shade900,
              activeColor: Colors.transparent,
              onChanged: (value){
                setState(() {
                  isCheckedFree= value ?? false;
                  isCheckedDiffPrice= false;
                  isCheckedSamePrice = false;
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
              value: isCheckedSamePrice,
              checkColor: Colors.grey.shade900,
              activeColor: Colors.transparent,
              onChanged: (value){
                setState(() {
                  isCheckedSamePrice = value ?? false;
                  isCheckedFree = false;
                  isCheckedDiffPrice = false;
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
          visible: isCheckedSamePrice,
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
              value: isCheckedDiffPrice,
              checkColor: Colors.grey.shade900,
              activeColor: Colors.transparent,
              onChanged: (value){
                setState(() {
                  isCheckedDiffPrice = value ?? false;
                  isCheckedFree = false;
                  isCheckedSamePrice = false;
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
            visible: isCheckedDiffPrice,
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