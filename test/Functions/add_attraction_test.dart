import 'package:flutter_test/flutter_test.dart';
import 'package:journey_joy_client/Classes/Functions/add_attraction.dart';
import 'package:journey_joy_client/Classes/Functions/login.dart';

void main() {
  test('AddAttractionAction test', () async {
    final loginAction = LoginAction();

    final token = await loginAction.login('m@gmail.com', 'PiErZcHaLa.1002.');

    final addAttractionAction = AddAttractionAction();
    final name = 'Attraction Name';
    final description = 'Attraction Description';
    final timeNeeded = '100';
    final tripId = "effb0b7b-cb6a-4dae-acc5-090e85de701c";

    final result = await addAttractionAction.add(
      name,
      description,
      timeNeeded,
      tripId,
      token,
    );

    expect(result, true);
  });
}


