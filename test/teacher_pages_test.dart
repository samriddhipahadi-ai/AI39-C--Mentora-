import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mentora/models/account_role.dart';
import 'package:mentora/services/profile_store.dart';
import 'package:mentora/theme/app_text_styles.dart';
import 'package:mentora/views/dashboard/dashboard_shell.dart';
import 'package:mentora/views/dashboard/messages_page.dart';
import 'package:mentora/views/dashboard/teacher_create_class_page.dart';

void _tallScreen(WidgetTester tester) {
  tester.view.physicalSize = const Size(800, 3000);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void main() {
  setUp(() => AppText.useGoogleFonts = false);
  tearDown(() => ProfileStore.instance.signOut());

  testWidgets('create class form shows errors when it is empty',
          (tester) async {
        _tallScreen(tester);
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: TeacherCreateClassPage())),
        );

        await tester.tap(find.text('Create draft class'));
        await tester.pump();

        expect(find.text('Class title is required'), findsOneWidget);
        expect(find.text('Subject is required'), findsOneWidget);
        expect(find.text('Enter a valid price'), findsOneWidget);
      });

  testWidgets('messages page switches to Mentora AI', (tester) async {
    _tallScreen(tester);
    final store = ProfileStore.instance;
    store.signIn(store.demoProfile(AccountRole.student, 'asha@mentora.com'));

    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: MessagesPage(isTeacher: false)),
    ));
    expect(find.text('Start a conversation'), findsOneWidget);

    await tester.tap(find.text('Mentora AI').first);
    await tester.pump();
    expect(find.textContaining("I'm Mentora AI"), findsOneWidget);
  });

  testWidgets('a teacher can open every tab without errors', (tester) async {
    _tallScreen(tester);
    final store = ProfileStore.instance;
    store.signIn(store.demoProfile(AccountRole.teacher, 'diya@mentora.com'));
    await tester.pumpWidget(const MaterialApp(home: DashboardShell()));

    for (final label in ['Classes', 'Create', 'Messages', 'Profile', 'Home']) {
      await tester.tap(find.text(label).last);
      await tester.pumpAndSettle();
    }
    expect(tester.takeException(), isNull);
  });
}