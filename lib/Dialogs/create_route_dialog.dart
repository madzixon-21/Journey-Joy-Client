import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:journey_joy_client/Classes/Functions/get_route.dart';
import 'package:journey_joy_client/Dialogs/error_dialog.dart';

class CreateRouteDialog extends StatefulWidget {
  final String token;
  final String tripId;

  CreateRouteDialog({required this.token, required this.tripId, Key? key})
      : super(key: key);

  @override
  CreateRouteDialogState createState() => CreateRouteDialogState();
}

class CreateRouteDialogState extends State<CreateRouteDialog> {
  final TextEditingController _numDaysController = TextEditingController();
  List<String> week = <String>['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  String dropdownValue = 'Monday';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color.fromARGB(255, 222, 235, 207),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: 475,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: const DecorationImage(
            image: AssetImage('assets/dialog_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child:Column(
          children: [
            const SizedBox(height: 50),

            Center(
            child: Text('Set the last details',
              style: TextStyle(
                color: Colors.grey.shade900,
                fontFamily: 'Lohit Tamil',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                
                ),
              ),
            ),

            const SizedBox(height: 35),

            Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "How many days do you have?",
                  style: TextStyle(
                      color: Colors.grey.shade900,
                      fontFamily: 'Lohit Tamil',
                      letterSpacing: 2,
                      fontSize: 15,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            Container(
              height:40,
              width: 250,
              alignment: Alignment.center,
              
              child: TextField(
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontFamily: 'Lohit Tamil',
                  letterSpacing: 2,
                ),
                controller: _numDaysController,
                decoration: InputDecoration(
                  hintText: 'Number of days',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade900, 
                    fontFamily: 'Lohit Tamil', 
                    letterSpacing: 1.5,),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  prefixIcon: Icon(
                    Icons.calendar_month_rounded,
                    color: Colors.grey.shade900,
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 60, 
                  ),
                ),
              ),
            ),

            const SizedBox(height:20),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "When will you start?",
                style: TextStyle(
                    color: Colors.grey.shade900,
                    fontFamily: 'Lohit Tamil',
                    letterSpacing: 2,
                    fontSize: 15,
              ),
              ),
            ),

            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.only(left: 60.0, right: 60.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0), 
              ),
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.arrow_downward, color: Colors.grey.shade900,),
                elevation: 16,
                style: TextStyle(
                    color: Colors.grey.shade900,
                    fontFamily: 'Lohit Tamil',
                    letterSpacing: 2,
                  ),
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: week.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                dropdownColor: Colors.white,
              ),
            ),
            
            const SizedBox(height:25),

            Center(
              child: ElevatedButton(
                
                onPressed: (){
                  int startDay = convertDay(dropdownValue);

                  CreateRoute().create(
                    int.parse(_numDaysController.text), 
                    startDay, 
                    widget.tripId, 
                    widget.token).then((http.Response? response){
                      if(response != null){
                        if(response.statusCode == 200){
                          Navigator.pop(context, 'routeCreated');
                        }else{
                          print(widget.token);
                          showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => ErrorDialog(prop: response.body));
                          print(response.body);
                          _numDaysController.clear();
                          setState(() {
                            dropdownValue = week.first;
                          });
                        }
                      }
                    });
                },
                
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                ),
                child: Text('Save changes',
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
    );
  }
}

int convertDay(String startDay) {
  switch (startDay) {
    case 'Monday':
      return 0;
    case 'Tuesday':
      return 1;
    case 'Wednesday':
      return 2;
    case 'Thursday':
      return 3;
    case 'Friday':
      return 4;
    case 'Saturday':
      return 5;
    case 'Sunday':
      return 6;
    default:
      throw Exception();
  }
}