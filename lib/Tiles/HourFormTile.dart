import 'package:flutter/material.dart';
import 'package:journey_joy_client/Dialogs/timeDialog.dart';

class HoursFormTile extends StatefulWidget {
  final String label;
  final TextEditingController controllerOpen;
  final TextEditingController controllerClose;

  const HoursFormTile(
      {required this.label,
      required this.controllerOpen,
      required this.controllerClose,
      super.key});

  @override
  _HoursFormTileState createState() => _HoursFormTileState();
}

class _HoursFormTileState extends State<HoursFormTile> {
  TimeOfDay selectedOpen = const TimeOfDay(hour: 00, minute: 00);
  TimeOfDay selectedClose = const TimeOfDay(hour: 23, minute: 59);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontFamily: 'Lohit Tamil',
                  fontSize: 13,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        widget.controllerOpen.text,
                        style: TextStyle(
                          color: Colors.grey.shade900,
                          fontFamily: 'Lohit Tamil',
                          fontSize: 30,
                          letterSpacing: 2,
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          'Set open time',
                          style: TextStyle(
                            color: Colors.grey.shade900,
                            fontFamily: 'Lohit Tamil',
                            letterSpacing: 2,
                          ),
                        ),
                        onPressed: () async {
                          TimeOfDay? newTime = await showTimePicker(
                              context: context, initialTime: selectedOpen);
                          if (newTime != null) {
                            if (newTime.hour > selectedClose.hour ||
                                (newTime.hour == selectedClose.hour &&
                                    newTime.minute > selectedClose.minute)) {
                              // ignore: use_build_context_synchronously
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    const TimeDialog(),
                              );
                            } else {
                              setState(() {
                                selectedOpen = newTime;
                                widget.controllerOpen.text =
                                    '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}';
                              });
                            }
                          }
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        widget.controllerClose.text,
                        style: TextStyle(
                          color: Colors.grey.shade900,
                          fontFamily: 'Lohit Tamil',
                          fontSize: 30,
                          letterSpacing: 2,
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          'Set close time',
                          style: TextStyle(
                            color: Colors.grey.shade900,
                            fontFamily: 'Lohit Tamil',
                            letterSpacing: 2,
                          ),
                        ),
                        onPressed: () async {
                          TimeOfDay? newTime = await showTimePicker(
                              context: context, initialTime: selectedClose);
                          if (newTime != null) {
                            if (newTime.hour < selectedOpen.hour ||
                                (newTime.hour == selectedOpen.hour &&
                                    newTime.minute < selectedOpen.minute)) {
                              // ignore: use_build_context_synchronously
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    const TimeDialog(),
                              );
                            } else {
                              setState(() {
                                selectedClose = newTime;
                                widget.controllerClose.text =
                                    '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}';
                              });
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
