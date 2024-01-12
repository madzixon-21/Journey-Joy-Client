/// # EditCheckboxPrices
/// ## Creates the checkbox widget for the personalized attraction EditForm and edits information about prices.
/// 
/// Creates three checkboxes for three prices options: Always free, same price every day
/// and different prices every day. 
/// When "Always free" is checked, the getPrices returns 0 for every opening and closing hour.
/// When "Same price every day" is checked, a new textField appears to collect information about the price.
/// When "Different hours every day" is checked, seven textFields appear to specify the price each day of the week.
/// By default, "Different hours every day" is checked and the text fields are filled with the atrraction prices.

import 'package:flutter/material.dart';
import 'package:journey_joy_client/Tiles/FormTileSmall.dart';

class EditCheckboxPrices extends StatefulWidget {
  final List<String> prices;
  const EditCheckboxPrices({required this.prices, Key? key}) : super(key: key);

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

  bool isCheckedFree = false;
  bool isCheckedSamePrice = false;
  bool isCheckedDiffPrice = true;

  late List<String> mutablePrices;

  @override
  void initState() {
    super.initState();
    mutablePrices = List.from(widget.prices);
  }

  List<String> getPrices(){
    if(mutablePrices.isEmpty){
      mutablePrices = List.generate(7, (index) => '');
    }

    if(isCheckedFree){
      
      for (int i = 0; i < mutablePrices.length; i++) {
        mutablePrices[i] = '0';
      }

    }else if( isCheckedSamePrice){

      for (int i = 0; i < mutablePrices.length; i++) {
        mutablePrices[i] = _samePriceController.text;
      }

    }else{
      mutablePrices[0] = _mondayController.text;
      mutablePrices[1] = _tuesdayController.text;
      mutablePrices[2] = _wednesdayController.text;
      mutablePrices[3] = _thursdayController.text;
      mutablePrices[4] = _fridayController.text;
      mutablePrices[5] = _saturdayController.text;
      mutablePrices[6] = _sundayController.text;
    }

    return mutablePrices;
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