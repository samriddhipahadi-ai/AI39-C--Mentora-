import 'package:flutter_test/flutter_test.dart';
import 'package:mentora/main.dart';

void main() {
  testWidgets('Mentora welcome page loads', (WidgetTester tester) async {
    // Start the Mentora application.
    await tester.pumpWidget(const MentoraApp());

    // Check that the welcome page appears.
    expect(find.text('Welcome to Mentora'), findsOneWidget);

    // Check that the Sign In button appears.
    expect(find.text('Sign In'), findsOneWidget);

    // Check that the Create Account button appears.
    expect(find.text('Create an Account'), findsOneWidget);
  });
}
