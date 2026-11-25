import 'package:flutter_test/flutter_test.dart';
import 'package:mentora/main.dart';
<<<<<<< HEAD

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
=======
import 'package:mentora/theme/app_text_styles.dart';

void main() {
  // Tests have no internet, so tell AppText not to download Google Fonts.
  setUp(() => AppText.useGoogleFonts = false);

  testWidgets('App starts', (tester) async {
    await tester.pumpWidget(const MentoraApp());
    expect(find.byType(MentoraApp), findsOneWidget);
>>>>>>> 7c840d8694eadb60ad9443a06bb987619e20d690
  });
}