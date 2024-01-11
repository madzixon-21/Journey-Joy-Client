import 'package:test/test.dart';
import 'package:journey_joy_client/Classes/Functions/login.dart';

void main() {
  group('LoginAction', () {
    test('login - success', () async {
      
      final loginAction = LoginAction();

      final result = await loginAction.login('m@gmail.com', 'PiErZcHaLa.1002.');

      expect(result, isNotNull);
    });

    test('login - failure', () async {

      final loginAction = LoginAction();

      final result = await loginAction.login('m@gmail.com', 'm');

      expect(result, null);
    });
  });
}

