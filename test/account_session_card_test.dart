import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mentora/models/account_role.dart';
import 'package:mentora/services/profile_store.dart';
import 'package:mentora/theme/app_text_styles.dart';
import 'package:mentora/views/widgets/account_session_card.dart';

Future<void> _open(WidgetTester tester) async {
  final store = ProfileStore.instance;

  store.signIn(
    store.demoProfile(AccountRole.student, 'demo@mentora.com'),
  );

  await tester.pumpWidget(
    const MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: AccountSessionCard(),
        ),
      ),
    ),
  );
}

void main() {
  setUp(() => AppText.useGoogleFonts = false);

  tearDown(() => ProfileStore.instance.signOut());

  testWidgets('asks for confirmation and stays signed in on cancel',
          (tester) async {
        await _open(tester);

        await tester.tap(find.text('Log out'));
        await tester.pumpAndSettle();

        expect(find.text('Log out?'), findsOneWidget);

        await tester.tap(find.text('Stay signed in'));
        await tester.pumpAndSettle();

        expect(ProfileStore.instance.current, isNotNull);
      });

  testWidgets('signs out after the person confirms', (tester) async {
    await _open(tester);

    await tester.tap(find.text('Log out'));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Log out'));
    await tester.pumpAndSettle();

    expect(ProfileStore.instance.current, isNull);
  });
}