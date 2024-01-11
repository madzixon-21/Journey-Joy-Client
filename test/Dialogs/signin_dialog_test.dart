import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journey_joy_client/Dialogs/sign_in_dialog.dart';

void main() {
  testWidgets('SigninDialog widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            return ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => SigninDialog(),
                );
              },
              child: const Text('Open Dialog'),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Open Dialog'));
    await tester.pumpAndSettle();

    final nicknameTextField = find.byKey(const Key('nicknameTextField')).first;
    final emailTextField = find.byKey(const Key('emailTextField')).first;
    final passwordTextField = find.byKey(const Key('passwordTextField')).first;
    final repeatPasswordTextField = find.byKey(const Key('repeatPasswordTextField')).first;


    await tester.enterText(nicknameTextField, 'testUser');
    await tester.enterText(emailTextField, 'test@example.com');
    await tester.enterText(passwordTextField, 'password');
    await tester.enterText(repeatPasswordTextField, 'password');

  });
}