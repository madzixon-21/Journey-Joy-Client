import 'package:journey_joy_client/Screens/Add_Form/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('FormDialog widget count test', (WidgetTester tester) async {
    
    await tester.pumpWidget(MaterialApp(
      home: Form(),
    ));

    expect(find.byType(TextField), findsNWidgets(12));

    expect(find.byType(TextButton), findsNWidgets(1));

  });
}
