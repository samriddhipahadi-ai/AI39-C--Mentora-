import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mentora/models/account_role.dart';
import 'package:mentora/services/profile_store.dart';
import 'package:mentora/theme/app_text_styles.dart';
import 'package:mentora/views/profile/teacher_profile_page.dart';

Future<void> _open(WidgetTester tester) async {
  // A tall screen so the whole form is built at once.
  tester.view.physicalSize = const Size(800, 3000);
  tester.view.devicePixelRatio = 1;

  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  final store = ProfileStore.instance;

  store.signIn(
    store.demoProfile(AccountRole.teacher, 'diya@mentora.com'),
  );

  await tester.pumpWidget(
    const MaterialApp(
      home: Scaffold(
        body: TeacherProfilePage(),
      ),
    ),
  );
}

void main() {
  setUp(() => AppText.useGoogleFonts = false);

  tearDown(() => ProfileStore.instance.signOut());

  testWidgets('view mode shows the teacher profile card', (tester) async {
    await _open(tester);

    expect(find.text('Teacher profile'), findsOneWidget);
    expect(find.text('Verified teacher'), findsOneWidget);
    expect(find.text('Save profile'), findsNothing);
  });

  testWidgets('experience must be a whole number', (tester) async {
    await _open(tester);

    await tester.tap(find.text('Edit profile'));
    await tester.pumpAndSettle();

    // Field order in the form: name, phone, location, qualification,
    // experience, availability, about.
    await tester.enterText(
      find.byType(TextFormField).at(4),
      'five',
    );

    await tester.tap(find.text('Save profile'));
    await tester.pump();

    expect(find.text('Enter a whole number'), findsOneWidget);
  });

  testWidgets('valid data is saved to ProfileStore', (tester) async {
    await _open(tester);

    await tester.tap(find.text('Edit profile'));
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);

    await tester.enterText(fields.at(1), '9812345678');
    await tester.enterText(fields.at(2), 'Kathmandu');
    await tester.enterText(fields.at(3), 'MSc Mathematics');
    await tester.enterText(fields.at(4), '5');
    await tester.enterText(fields.at(5), 'Weekdays after 4pm');

    await tester.tap(find.text('Mathematics'));
    await tester.pump();

    await tester.tap(find.text('Save profile'));
    await tester.pumpAndSettle();

    final saved = ProfileStore.instance.current!;

    expect(saved.qualification, 'MSc Mathematics');
    expect(saved.experienceYears, '5');
    expect(saved.subjects, contains('Mathematics'));
  });
}