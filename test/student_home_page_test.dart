import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mentora/models/account_role.dart';
import 'package:mentora/services/profile_store.dart';
import 'package:mentora/theme/app_text_styles.dart';
import 'package:mentora/views/dashboard/student_home_page.dart';

void main() {
  setUp(() => AppText.useGoogleFonts = false);
  tearDown(() => ProfileStore.instance.signOut());

  testWidgets('shows the greeting, stat cards and recommended teachers',
          (tester) async {
        // A tall screen so the whole list is built at once.
        tester.view.physicalSize = const Size(800, 3000);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        final store = ProfileStore.instance;
        store.signIn(store.demoProfile(AccountRole.student, 'websmith@mentora.com'));

        int? tappedTab;
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(body: StudentHomePage(onGoTo: (i) => tappedTab = i)),
        ));

        expect(find.textContaining('websmith.'), findsOneWidget);
        expect(find.text('Enrolled classes'), findsOneWidget);
        expect(find.text('Tanka Prasad'), findsOneWidget);

        await tester.tap(find.text('Continue learning'));
        expect(tappedTab, 2);
      });
}