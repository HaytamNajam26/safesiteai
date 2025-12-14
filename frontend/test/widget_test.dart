// Basic widget test for SafeSite AI app
import 'package:flutter_test/flutter_test.dart';

import 'package:safesite_ai/main.dart';

void main() {
  testWidgets('App starts with login screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SafeSiteApp());

    // Verify that we see the login screen title
    expect(find.text('SafeSite AI'), findsOneWidget);
  });
}
