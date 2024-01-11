import 'package:flutter_test/flutter_test.dart';
import 'package:journey_joy_client/Classes/Functions/signin.dart';

void main() {
  group('SignInAction', () {
    test('signIn - success', () async {
     
      final signInAction = SignInAction();

      final result = await signInAction.signIn('testNickname2', 'test.Password2', 'test2@gmail.com');
      expect(result, true);
    });

    test('signIn - failure', () async {
      
      final signInAction = SignInAction();

      final result = await signInAction.signIn('testNickname1', 'testPassword1', 'test1');
      expect(result, false);
    });
  });
}
