import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Text styles from the Figma design.
/// Headings use Manrope, body text uses DM Sans.
class AppText {
/// Widget tests set this to false so no font download is attempted.
static bool useGoogleFonts = true;

static TextStyle _manrope(
double size,
FontWeight weight, {
Color color = AppColors.navy,
double? height,
double? letterSpacing,
}) {
if (!useGoogleFonts) {
return TextStyle(
fontSize: size,
fontWeight: weight,
color: color,
height: height,
letterSpacing: letterSpacing,
);
}
return GoogleFonts.manrope(
fontSize: size,
fontWeight: weight,
color: color,
height: height,
letterSpacing: letterSpacing,
);
}

static TextStyle _dmSans(
double size,
FontWeight weight, {
Color? color,
double? height,
double? letterSpacing,
}) {
if (!useGoogleFonts) {
return TextStyle(
fontSize: size,
fontWeight: weight,
color: color,
height: height,
letterSpacing: letterSpacing,
);
}
return GoogleFonts.dmSans(
fontSize: size,
fontWeight: weight,
color: color,
height: height,
letterSpacing: letterSpacing,
);
}


static TextStyle get greeting => _manrope(28, FontWeight.w800, height: 1.15);
static TextStyle get pageTitle => _manrope(26, FontWeight.w800, height: 1.15);
static TextStyle get sectionTitle => _manrope(20, FontWeight.w700);
static TextStyle get cardTitle => _manrope(16, FontWeight.w700);

/// Small uppercase label above a title, e.g. "YOUR SPACE".
static TextStyle get eyebrow => _dmSans(10, FontWeight.w700,
    color: AppColors.label, letterSpacing: 1.4);

static TextStyle get body =>
    _dmSans(13, FontWeight.w400, color: AppColors.textSoft, height: 1.4);
static TextStyle get bodyDark =>
    _dmSans(13, FontWeight.w500, color: AppColors.navy);
static TextStyle get small =>
    _dmSans(11, FontWeight.w400, color: AppColors.label);
static TextStyle get link =>
    _dmSans(12, FontWeight.w600, color: AppColors.accent);

/// No color on purpose: the button decides the color.
static TextStyle get button => _dmSans(14, FontWeight.w700);
static TextStyle get chip =>
    _dmSans(10, FontWeight.w700, color: AppColors.success);
}
