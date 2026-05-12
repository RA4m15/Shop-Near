// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shop_near/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
<<<<<<< HEAD
    await tester.pumpWidget(const ShopNearApp());

    // Verify that our onboarding screen shows the brand name.
    expect(find.text('ShopNear', findRichText: true), findsOneWidget);
    expect(find.text('Get Started as Buyer', findRichText: true), findsNothing); // It's in a button with an emoji

    // You can add more tests here for onboarding navigation, etc.
=======
    await tester.pumpWidget(
      const ProviderScope(
        child: BazarLiveApp(),
      ),
    );

    // Verify that the app builds without errors.
    expect(find.byType(BazarLiveApp), findsOneWidget);
>>>>>>> 156ccf516472535c56e5e4a5f6e50a942847eeb6
  });
}
