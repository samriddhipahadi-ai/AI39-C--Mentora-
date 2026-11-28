
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mentora/models/account_role.dart';
import 'package:mentora/services/profile_store.dart';
import 'package:mentora/theme/app_text_styles.dart';
import 'package:mentora/views/profile/student_profile_page.dart';

Future<void> _open(WidgetTester tester) async {
  tester.view.physicalSize = const Size(800, 3000);
  tester.view.devicePixelRatio = 1;

  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  final store = ProfileStore.instance;
  store.signIn(
    store.demoProfile(AccountRole.student, 'kritima@mentora.com'),
  );

  await tester.pumpWidget(
    const MaterialApp(
      home: Scaffold(body: StudentProfilePage()),
    ),
  );
}

void main() {
  setUp(() => AppText.useGoogleFonts = false);

  tearDown(() => ProfileStore.instance.signOut());

  testWidgets('view mode shows "Not provided" for empty fields',
          (tester) async {
        await _open(tester);

        expect(find.text('Student profile'), findsOneWidget);
        expect(find.text('Not provided'), findsWidgets);
        expect(find.text('Save profile'), findsNothing);
      });

  testWidgets('Edit profile opens the form and Cancel closes it',
          (tester) async {
        await _open(tester);

        await tester.tap(find.byTooltip('Edit profile'));
        await tester.pumpAndSettle();

        expect(find.text('Save profile'), findsOneWidget);

        await tester.tap(find.byTooltip('Cancel editing'));
        await tester.pumpAndSettle();

        expect(find.text('Save profile'), findsNothing);
      });

  testWidgets('an invalid phone number shows an error and is not saved',
          (tester) async {
        await _open(tester);

        await tester.tap(find.byTooltip('Edit profile'));
        await tester.pumpAndSettle();

        await tester.enterText(
          find.byType(TextFormField).at(1),
          '123',
        );

        await tester.tap(find.text('Save profile'));
        await tester.pump();

        expect(find.textContaining('valid Nepal number'), findsOneWidget);
        expect(ProfileStore.instance.current!.phone, isNot('123'));
      });

  testWidgets('valid data is saved to ProfileStore', (tester) async {
    await _open(tester);

    await tester.tap(find.byTooltip('Edit profile'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byType(TextFormField).at(1),
      '+977 9812345678',
    );

    await tester.tap(find.text('Physics'));
    await tester.pump();

    await tester.tap(find.text('Save profile'));
    await tester.pumpAndSettle();

    final saved = ProfileStore.instance.current!;

    expect(saved.phone, '+977 9812345678');
    expect(saved.subjects, contains('Physics'));
  });
}
