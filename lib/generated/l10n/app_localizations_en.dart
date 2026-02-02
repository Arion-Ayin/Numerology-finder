// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get home => 'Home';

  @override
  String get settings => 'Settings';

  @override
  String get info => 'Info';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get language => 'Language';

  @override
  String get korean => 'Korean';

  @override
  String get english => 'English';

  @override
  String get community => 'Blog';

  @override
  String get name => 'Name';

  @override
  String get birthDate => 'Birth Date';

  @override
  String get yourNumerologyResult => 'Your Numerology Result :';

  @override
  String get lifePathNumber => 'Life Path Number';

  @override
  String get destinyNumber => 'Destiny Number';

  @override
  String get soulUrgeNumber => 'Soul Urge Number';

  @override
  String get personalityNumber => 'Personality Number';

  @override
  String get maturityNumber => 'Maturity Number';

  @override
  String get birthdayNumber => 'Birthday Number :';

  @override
  String get personalYearNumber => 'Personal Year Number :';

  @override
  String get personalMonthNumber => 'Personal Month Number';

  @override
  String get back => 'Back';

  @override
  String get calculate => 'Calculate';

  @override
  String get reset => 'Reset';

  @override
  String get noDateChosen => 'No date chosen (Optional)';

  @override
  String get chooseDate => 'Choose Date';

  @override
  String get history => 'History';

  @override
  String get pleaseEnterNameAndBirthDate => 'Please enter your name.';

  @override
  String get whoAreWeTitle => 'Who are we?';

  @override
  String get whoAreWeSubtitle =>
      '• Arion Ayin\'s Mission : \nFathoming the world with the eyes of a lion';

  @override
  String get whoIsItUsefulForTitle => 'Who is it useful for?';

  @override
  String get whoIsItUsefulForSubtitle =>
      '• Those who are curious about numerology, and want to understand themselves and others through numbers';

  @override
  String get whyDidWeMakeThisAppTitle => 'Why did We make this?';

  @override
  String get whyDidWeMakeThisAppSubtitle =>
      '• With the hope that anyone can easily access this information.';

  @override
  String get copyrightText => '© 2025 Arion Ayin. All rights reserved.';

  @override
  String languageChanged(Object languageName) {
    return 'Language changed to $languageName';
  }

  @override
  String get inputReset => 'Input has been reset.';
}
