
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/user_profile.dart';
import '../../theme/app_colors.dart';
import 'profile_avatar.dart';

/// Profile photo with a small camera badge.
/// Tapping it opens the gallery.
/// The selected photo is sent to onChanged as bytes.
class ProfilePhotoPicker extends StatefulWidget {
  const ProfilePhotoPicker({
    super.key,
    required this.profile,
    required this.onChanged,
    this.size = 64,
  });

  final UserProfile profile;
  final ValueChanged<Uint8List> onChanged;
  final double size;

  @override
  State<ProfilePhotoPicker> createState() => _ProfilePhotoPickerState();
}

class _ProfilePhotoPickerState extends State<ProfilePhotoPicker> {
  static const _maxBytes = 5 * 1024 * 1024;
  static const _allowed = ['jpg', 'jpeg', 'png'];

  final _picker = ImagePicker();

  bool _busy = false;

  void _message(String text) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  Future<void> _pick() async {
    if (_busy) return;

    setState(() => _busy = true);

    try {
      final file = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        imageQuality: 85,
      );

      if (file == null) return;

      final name = file.name.toLowerCase();

      if (name.contains('.') &&
          !_allowed.contains(name.split('.').last)) {
        _message('Please choose a JPG or PNG image.');
        return;
      }

      final bytes = await file.readAsBytes();

      if (bytes.lengthInBytes > _maxBytes) {
        _message('Photo must be smaller than 5 MB.');
        return;
      }

      if (!mounted) return;

      widget.onChanged(bytes);
    } catch (_) {
      _message('Could not open your photos. Please try again.');
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Change profile photo',
      child: GestureDetector(
        onTap: _pick,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ProfileAvatar(
              profile: widget.profile,
              size: widget.size,
            ),
            Positioned(
              right: -4,
              bottom: -4,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: _busy
                    ? const SizedBox(
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(
                        Icons.camera_alt,
                        size: 12,
                        color: Colors.white,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
