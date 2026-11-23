import 'package:flutter_test/flutter_test.dart';
import 'package:mentora/main.dart';
import 'package:mentora/theme/app_text_styles.dart';

void main() {
  // Tests have no internet, so tell AppText not to download Google Fonts.
  setUp(() => AppText.useGoogleFonts = false);

  testWidgets('App starts', (tester) async {
    await tester.pumpWidget(const MentoraApp());
    expect(find.byType(MentoraApp), findsOneWidget);
  });
}