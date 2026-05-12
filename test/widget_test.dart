import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_near/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: ShopNearApp(),
      ),
    );

    // Verify that the app builds without errors.
    expect(find.byType(ShopNearApp), findsOneWidget);
  });
}
