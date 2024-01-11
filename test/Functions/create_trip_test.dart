import 'package:test/test.dart';
import 'package:journey_joy_client/Classes/Functions/create_trip.dart';
import 'package:journey_joy_client/Classes/Functions/login.dart';
import 'dart:io';

void main() {
  group('CreateTripAction', () {
    test('create - success', () async {
      final loginAction = LoginAction();

      final token = await loginAction.login('m@gmail.com', 'PiErZcHaLa.1002.');

      if(token != null){

        CreateTripAction createTripAction = CreateTripAction();
        File imageFile = File('/Users/magdalenapierzchala/Library/Developer/CoreSimulator/Devices/307C9468-E9A0-4FE9-865C-EB3DE6E35188/data/Containers/Data/Application/055E5160-280D-41AE-BB36-6001120A2172/tmp/image_picker_621B4744-734A-4C2D-9BD5-EA656223937E-15376-000005E4AA92C41A.jpg');


        bool result = await createTripAction.create(
          'Test Trip',
          'This is a test trip.',
          imageFile,
          token,
        );

        expect(result, true);
      }
      
    });

    test('create - failure', () async {
      final loginAction = LoginAction();

      final token = await loginAction.login('m@gmail.com', 'PiErZcHaLa.1002.');

      if(token != null){

        CreateTripAction createTripAction = CreateTripAction();

        bool result = await createTripAction.create(
          '',
          '',
          null,
          '',
        );

        expect(result, false);
      }
  });
 });
}
