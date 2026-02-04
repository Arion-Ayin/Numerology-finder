import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ko.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ko'),
  ];

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @info.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get info;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @korean.
  ///
  /// In en, this message translates to:
  /// **'Korean'**
  String get korean;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @community.
  ///
  /// In en, this message translates to:
  /// **'Blog'**
  String get community;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @birthDate.
  ///
  /// In en, this message translates to:
  /// **'Birth Date'**
  String get birthDate;

  /// No description provided for @yourNumerologyResult.
  ///
  /// In en, this message translates to:
  /// **'Your Numerology Result :'**
  String get yourNumerologyResult;

  /// No description provided for @lifePathNumber.
  ///
  /// In en, this message translates to:
  /// **'Life Path Number'**
  String get lifePathNumber;

  /// No description provided for @destinyNumber.
  ///
  /// In en, this message translates to:
  /// **'Destiny Number'**
  String get destinyNumber;

  /// No description provided for @soulUrgeNumber.
  ///
  /// In en, this message translates to:
  /// **'Soul Urge Number'**
  String get soulUrgeNumber;

  /// No description provided for @personalityNumber.
  ///
  /// In en, this message translates to:
  /// **'Personality Number'**
  String get personalityNumber;

  /// No description provided for @maturityNumber.
  ///
  /// In en, this message translates to:
  /// **'Maturity Number'**
  String get maturityNumber;

  /// No description provided for @birthdayNumber.
  ///
  /// In en, this message translates to:
  /// **'Birthday Number :'**
  String get birthdayNumber;

  /// No description provided for @personalYearNumber.
  ///
  /// In en, this message translates to:
  /// **'Personal Year Number :'**
  String get personalYearNumber;

  /// No description provided for @personalMonthNumber.
  ///
  /// In en, this message translates to:
  /// **'Personal Month Number'**
  String get personalMonthNumber;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @calculate.
  ///
  /// In en, this message translates to:
  /// **'Calculate'**
  String get calculate;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @noDateChosen.
  ///
  /// In en, this message translates to:
  /// **'Entered date'**
  String get noDateChosen;

  /// No description provided for @chooseDate.
  ///
  /// In en, this message translates to:
  /// **'Choose Date'**
  String get chooseDate;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @pleaseEnterNameAndBirthDate.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name.'**
  String get pleaseEnterNameAndBirthDate;

  /// No description provided for @whoAreWeTitle.
  ///
  /// In en, this message translates to:
  /// **'Who are we?'**
  String get whoAreWeTitle;

  /// No description provided for @whoAreWeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'• Arion Ayin\'s Mission : \nFathoming the world with the eyes of a lion'**
  String get whoAreWeSubtitle;

  /// No description provided for @whoIsItUsefulForTitle.
  ///
  /// In en, this message translates to:
  /// **'Who is it useful for?'**
  String get whoIsItUsefulForTitle;

  /// No description provided for @whoIsItUsefulForSubtitle.
  ///
  /// In en, this message translates to:
  /// **'• Those who are curious about numerology, and want to understand themselves and others through numbers'**
  String get whoIsItUsefulForSubtitle;

  /// No description provided for @whyDidWeMakeThisAppTitle.
  ///
  /// In en, this message translates to:
  /// **'Why did We make this?'**
  String get whyDidWeMakeThisAppTitle;

  /// No description provided for @whyDidWeMakeThisAppSubtitle.
  ///
  /// In en, this message translates to:
  /// **'• With the hope that anyone can easily access this information.'**
  String get whyDidWeMakeThisAppSubtitle;

  /// No description provided for @copyrightText.
  ///
  /// In en, this message translates to:
  /// **'© 2025 Arion Ayin. All rights reserved.'**
  String get copyrightText;

  /// No description provided for @languageChanged.
  ///
  /// In en, this message translates to:
  /// **'Language changed to {languageName}'**
  String languageChanged(Object languageName);

  /// No description provided for @inputReset.
  ///
  /// In en, this message translates to:
  /// **'Input has been reset.'**
  String get inputReset;

  /// No description provided for @nameHint.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name here'**
  String get nameHint;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ko':
      return AppLocalizationsKo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
