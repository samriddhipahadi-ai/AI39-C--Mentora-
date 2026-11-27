import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mentora/models/account_role.dart';
import 'package:mentora/models/user_profile.dart';
import 'package:mentora/theme/app_text_styles.dart';
import 'package:mentora/views/widgets/profile_photo_picker.dart';

void main() {
  setUp(() {
    AppText.useGoogleFonts = false;
  });

  const profile = UserProfile(
    role: AccountRole.student,
    name: 'Kritima',
    email: 'k@mentora.com',
  );

  testWidgets(
    'shows the first letter and camera badge when there is no photo',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProfilePhotoPicker(
              profile: profile,
              onChanged: (Uint8List _) {},
            ),
          ),
        ),
      );

      expect(find.text('K'), findsOneWidget);
      expect(find.byIcon(Icons.camera_alt), findsOneWidget);
    },
  );

  test('copyWith keeps the photo bytes', () {
    final bytes = Uint8List.fromList([1, 2, 3]);

    final updated = profile.copyWith(photoBytes: bytes);

    expect(updated.photoBytes, bytes);

    expect(updated.copyWith(name: 'New name').photoBytes, bytes);
  });
}
