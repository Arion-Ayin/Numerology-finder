// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get home => '홈';

  @override
  String get settings => '세팅';

  @override
  String get info => '인포';

  @override
  String get darkMode => '다크 모드';

  @override
  String get language => '언어';

  @override
  String get korean => '한국어';

  @override
  String get english => '영어';

  @override
  String get community => '블로그';

  @override
  String get discord => '디스코드';

  @override
  String get name => '이름';

  @override
  String get birthDate => '생년월일';

  @override
  String get yourNumerologyResult => '당신의 수비학 결과 :';

  @override
  String get lifePathNumber => '인생여정 수';

  @override
  String get destinyNumber => '운명 수';

  @override
  String get soulUrgeNumber => '혼의 수';

  @override
  String get personalityNumber => '성격 수';

  @override
  String get maturityNumber => '완성 수';

  @override
  String get birthdayNumber => '생일 수';

  @override
  String get personalYearNumber => '1년수 :';

  @override
  String get personalMonthNumber => '1달수';

  @override
  String get back => '뒤로';

  @override
  String get calculate => '계산';

  @override
  String get reset => '초기화';

  @override
  String get noDateChosen => '입력된 날짜';

  @override
  String get chooseDate => '날짜 선택';

  @override
  String get history => '기록';

  @override
  String get pleaseEnterNameAndBirthDate => '이름을 입력해주세요.';

  @override
  String get whoAreWeTitle => '우리는 누구인가요';

  @override
  String get whoAreWeSubtitle => '• 아리온아인의 사명 : \n사자의 눈으로 세상을 헤아립니다';

  @override
  String get whoIsItUsefulForTitle => '누구에게 유용한가요?';

  @override
  String get whoIsItUsefulForSubtitle =>
      '• 수비학에 대해 궁금하거나, 자신과 타인의 성향을 숫자를 통해 이해하고 싶은 모든 분들';

  @override
  String get whyDidWeMakeThisAppTitle => '왜 이 앱을 만들었나요?';

  @override
  String get whyDidWeMakeThisAppSubtitle => '• 누구나 손쉽게 이 정보들에 접근 가능하면 좋겠다는 마음에';

  @override
  String get copyrightText => '© 2025 Arion Ayin. All rights reserved.';

  @override
  String languageChanged(Object languageName) {
    return '언어가 $languageName으로 변경되었습니다.';
  }

  @override
  String get inputReset => '입력이 초기화되었습니다.';

  @override
  String get nameHint => '이름을 여기에 입력해주세요';
}
