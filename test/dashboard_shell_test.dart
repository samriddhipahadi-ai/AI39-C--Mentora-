import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mentora/models/account_role.dart';
import 'package:mentora/services/profile_store.dart';
import 'package:mentora/theme/app_text_styles.dart';
import 'package:mentora/views/dashboard/dashboard_shell.dart';

Future<void> _open(WidgetTester tester, AccountRole role) async {
  final store = ProfileStore.instance;
  store.signIn(store.demoProfile(role, 'demo@mentora.com'));
  await tester.pumpWidget(const MaterialApp(home: DashboardShell()));
}

void main() {
  setUp(() => AppText.useGoogleFonts = false);
  tearDown(() => ProfileStore.instance.signOut());

  testWidgets('a student sees the student tabs', (tester) async {
    await _open(tester, AccountRole.student);
    expect(find.text('Discover'), findsOneWidget);
    expect(find.text('My Classes'), findsOneWidget);
    expect(find.text('Create'), findsNothing);
  });

  testWidgets('a teacher sees the teacher tabs', (tester) async {
    await _open(tester, AccountRole.teacher);
    expect(find.text('Classes'), findsOneWidget);
    expect(find.text('Create'), findsOneWidget);
    expect(find.text('Discover'), findsNothing);
  });

  testWidgets('tapping Profile opens the profile tab', (tester) async {
    await _open(tester, AccountRole.teacher);
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.textContaining('Teacher profile'), findsWidgets);
  });
}