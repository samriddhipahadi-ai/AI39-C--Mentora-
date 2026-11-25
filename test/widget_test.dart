
import 'package:flutter_test/flutter_test.dart';
import 'package:mentora/main.dart';
import 'package:mentora/theme/app_text_styles.dart';

void main() {
  setUp(() => AppText.useGoogleFonts = false);

  testWidgets('Mentora welcome page loads', (WidgetTester tester) async {
    await tester.pumpWidget(const MentoraApp());

    expect(find.byType(MentoraApp), findsOneWidget);
    expect(find.text('Welcome to Mentora'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
    expect(find.text('Create an Account'), findsOneWidget);
  });
}
