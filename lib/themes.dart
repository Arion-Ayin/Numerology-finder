import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumerologyThemes {
  // 수비학 앱 색상 팔레트 - 신비로운 숫자의 세계를 담다

  // Light Theme Colors
  static const Color _lightBackground = Color(0xFFF8F6F0); // 따뜻한 아이보리
  static const Color _lightSurface = Color(0xFFFFFDF8); // 부드러운 크림색
  static const Color _lightCard = Color(0xFFFFFFFF); // 순백
  static const Color _lightPrimary = Color(0xFF2C3E50); // 깊은 미드나잇 블루
  static const Color _lightSecondary = Color(0xFFD4AF37); // 골드
  static const Color _lightText = Color(0xFF1A1A2E); // 깊은 네이비
  static const Color _lightTextSecondary = Color(0xFF3A3A4A); // 부드러운 그레이

  // Dark Theme Colors
  static const Color _darkBackground = Color(0xFF0F0F1A); // 깊은 우주 블랙
  static const Color _darkSurface = Color(0xFF1A1A2E); // 미드나잇 네이비
  static const Color _darkCard = Color(0xFF16213E); // 깊은 인디고
  static const Color _darkPrimary = Color(0xFFE8D5B7); // 달빛 크림
  static const Color _darkSecondary = Color(0xFFD4AF37); // 골드
  static const Color _darkText = Color(0xFFF0EDE5); // 별빛 화이트
  static const Color _darkTextSecondary = Color(0xFFB8B5AD); // 부드러운 실버

  // 공통 색상
  static const Color gold = Color(0xFFD4AF37);
  static const Color midnightBlue = Color(0xFF2C3E50);
  static const Color cosmicBlack = Color(0xFF0F0F1A);

  // 공통 그림자 스타일
  static BoxShadow cardShadow(bool isDark) => BoxShadow(
    color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
    blurRadius: 15,
    offset: const Offset(0, 5),
  );

  // 카드 그라데이션
  static List<Color> cardGradient(bool isDark) => isDark
      ? [const Color(0xFF1E3A5F), const Color(0xFF16213E)]
      : [Colors.white, const Color(0xFFF8F6F0)];

  // 숫자 강조 그라데이션
  static const LinearGradient numberGradient = LinearGradient(
    colors: [Color(0xFFD4AF37), Color(0xFFE8D5B7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

final ThemeData numerologyTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blueGrey,
  colorScheme: const ColorScheme.light(
    primary: NumerologyThemes._lightPrimary,
    onPrimary: Colors.white,
    secondary: NumerologyThemes._lightSecondary,
    onSecondary: Colors.white,
    surface: NumerologyThemes._lightSurface,
    onSurface: NumerologyThemes._lightText,
  ),
  scaffoldBackgroundColor: NumerologyThemes._lightBackground,
  cardColor: NumerologyThemes._lightCard,
  shadowColor: Colors.black.withValues(alpha: 0.08),
  appBarTheme: const AppBarTheme(
    backgroundColor: NumerologyThemes._lightBackground,
    foregroundColor: NumerologyThemes._lightPrimary,
    elevation: 0,
    shadowColor: Colors.transparent,
    centerTitle: true,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
    titleTextStyle: TextStyle(
      color: NumerologyThemes._lightPrimary,
      fontSize: 22,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
    ),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: NumerologyThemes._lightText,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      color: NumerologyThemes._lightText,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      color: NumerologyThemes._lightText,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      color: NumerologyThemes._lightText,
      fontSize: 16,
    ),
    bodyMedium: TextStyle(
      color: NumerologyThemes._lightTextSecondary,
      fontSize: 14,
    ),
    headlineSmall: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: NumerologyThemes._lightSecondary,
    ),
  ),
  iconTheme: const IconThemeData(color: NumerologyThemes._lightPrimary),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: NumerologyThemes._lightSurface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(
        color: NumerologyThemes._lightPrimary.withValues(alpha: 0.2),
        width: 1.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: NumerologyThemes._lightSecondary,
        width: 2.0,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: NumerologyThemes._lightPrimary,
      foregroundColor: Colors.white,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: NumerologyThemes._lightPrimary,
      side: const BorderSide(color: NumerologyThemes._lightSecondary, width: 1.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: NumerologyThemes._lightCard,
    selectedItemColor: Colors.black,
    unselectedItemColor: NumerologyThemes._lightTextSecondary,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
    selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
    unselectedLabelStyle: TextStyle(fontSize: 12),
  ),
  dividerTheme: DividerThemeData(
    color: NumerologyThemes._lightPrimary.withValues(alpha: 0.1),
    thickness: 1,
  ),
  chipTheme: ChipThemeData(
    backgroundColor: NumerologyThemes._lightSurface,
    selectedColor: NumerologyThemes._lightSecondary.withValues(alpha: 0.2),
    labelStyle: const TextStyle(color: NumerologyThemes._lightText),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);

final ThemeData numerologyDarkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blueGrey,
  colorScheme: const ColorScheme.dark(
    primary: NumerologyThemes._darkPrimary,
    onPrimary: NumerologyThemes._darkBackground,
    secondary: NumerologyThemes._darkSecondary,
    onSecondary: NumerologyThemes._darkBackground,
    surface: NumerologyThemes._darkSurface,
    onSurface: NumerologyThemes._darkText,
  ),
  scaffoldBackgroundColor: NumerologyThemes._darkBackground,
  cardColor: NumerologyThemes._darkCard,
  shadowColor: Colors.black.withValues(alpha: 0.3),
  appBarTheme: const AppBarTheme(
    backgroundColor: NumerologyThemes._darkBackground,
    foregroundColor: NumerologyThemes._darkPrimary,
    elevation: 0,
    shadowColor: Colors.transparent,
    centerTitle: true,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
    titleTextStyle: TextStyle(
      color: NumerologyThemes._darkPrimary,
      fontSize: 22,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
    ),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: NumerologyThemes._darkText,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      color: NumerologyThemes._darkText,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      color: NumerologyThemes._darkText,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      color: NumerologyThemes._darkText,
      fontSize: 16,
    ),
    bodyMedium: TextStyle(
      color: NumerologyThemes._darkTextSecondary,
      fontSize: 14,
    ),
    headlineSmall: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: NumerologyThemes._darkSecondary,
    ),
  ),
  iconTheme: const IconThemeData(color: NumerologyThemes._darkPrimary),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: NumerologyThemes._darkSurface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(
        color: NumerologyThemes._darkPrimary.withValues(alpha: 0.2),
        width: 1.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: NumerologyThemes._darkSecondary,
        width: 2.0,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: NumerologyThemes._darkSecondary,
      foregroundColor: NumerologyThemes._darkBackground,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: NumerologyThemes._darkPrimary,
      side: const BorderSide(color: NumerologyThemes._darkSecondary, width: 1.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: NumerologyThemes._darkSurface,
    selectedItemColor: Colors.white,
    unselectedItemColor: NumerologyThemes._darkTextSecondary,
    type: BottomNavigationBarType.fixed,
    elevation: 0,
    selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
    unselectedLabelStyle: TextStyle(fontSize: 12),
  ),
  dividerTheme: DividerThemeData(
    color: NumerologyThemes._darkPrimary.withValues(alpha: 0.1),
    thickness: 1,
  ),
  chipTheme: ChipThemeData(
    backgroundColor: NumerologyThemes._darkSurface,
    selectedColor: NumerologyThemes._darkSecondary.withValues(alpha: 0.2),
    labelStyle: const TextStyle(color: NumerologyThemes._darkText),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);
