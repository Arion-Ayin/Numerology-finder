import 'package:flutter/material.dart';
import 'package:numerology/numerology_calc.dart';
import 'package:numerology/generated/l10n/app_localizations.dart';
import 'package:numerology/themes.dart';

class ResultScreen extends StatelessWidget {
  final String name;
  final DateTime? birthDate;

  const ResultScreen({super.key, required this.name, this.birthDate});

  @override
  Widget build(BuildContext context) {
    final NumerologyCalculator calculator = NumerologyCalculator();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Calculate name-based numbers (Always available)
    final int destinyNumber = calculator.calculateDestinyNumber(name);
    final int soulUrgeNumber = calculator.calculateSoulUrgeNumber(name);
    final int personalityNumber = calculator.calculatePersonalityNumber(name);

    // Calculate date-based numbers (Only if birthDate is provided)
    int? lifePathNumber;
    int? maturityNumber;
    int? birthdayNumber;
    List<int>? monthNumbers;
    int? reducedPersonalYear;
    List<Map<String, dynamic>>? pinnacleChallengeList;
    List<Map<String, dynamic>>? lifeCycleList;
    int? ageVibrationNumber;

    if (birthDate != null) {
      lifePathNumber = calculator.calculateLifePathNumber(birthDate!);
      maturityNumber = calculator.calculateMaturityNumber(
        lifePathNumber,
        destinyNumber,
      );
      birthdayNumber = calculator.calculateBirthdayNumber(birthDate!);
      monthNumbers = calculator.calculateAllPersonalMonths(birthDate!);
      reducedPersonalYear = calculator.calculatePersonalYearNumber(birthDate!);
      pinnacleChallengeList = calculator.calculatePinnacleAndChallenge(
        birthDate!,
        lifePathNumber,
      );
      lifeCycleList = calculator.calculateLifeCycles(birthDate!);
      ageVibrationNumber = calculator.calculateAgeVibrationNumber(birthDate!);
    }

    final String languageCode = Localizations.localeOf(context).languageCode;

    String getMonthText(int month) {
      if (languageCode == 'ko') {
        return '$month월수';
      } else {
        const monthAbbreviations = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ];
        return monthAbbreviations[month - 1];
      }
    }

    final int currentYear = DateTime.now().year;

    Widget buildNumberCard(String label, String value, {Color? accentColor}) {
      return Container(
        width:
            (MediaQuery.of(context).size.width / 3) - 22, // 3열 레이아웃을 위한 너비 조정
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: NumerologyThemes.cardGradient(isDark),
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [NumerologyThemes.cardShadow(isDark)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Theme.of(
                  context,
                ).textTheme.bodyLarge?.color?.withOpacity(0.8),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 1),
            Text(
              value,
              style: TextStyle(
                color: accentColor ?? Theme.of(context).colorScheme.secondary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    Widget buildTableCell(
      String text, {
      bool isHighlight = false,
      bool isHeader = false,
    }) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: isHeader ? 10.0 : 12.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isHeader ? 13 : (isHighlight ? 18 : 14),
            fontWeight:
                isHeader || isHighlight ? FontWeight.bold : FontWeight.normal,
            color:
                isHighlight
                    ? Theme.of(context).colorScheme.secondary
                    : (isHeader
                        ? Theme.of(context).textTheme.bodyMedium?.color
                        : Theme.of(context).textTheme.bodyLarge?.color),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 프로필 카드
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: NumerologyThemes.cardGradient(isDark),
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [NumerologyThemes.cardShadow(isDark)],
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.secondary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      Icons.person_outline,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.titleLarge?.color,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (birthDate != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            birthDate!.toLocal().toString().split(' ')[0],
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // 당신의 행운 숫자 섹션
            Text(
              '당신의 행운 숫자',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: NumerologyThemes.cardGradient(isDark),
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(
                    context,
                  ).colorScheme.secondary.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children:
                    calculator.getNameDecomposition(name).map((syllableList) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.secondary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children:
                              syllableList.map((item) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        item['char'],
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(
                                                context,
                                              ).textTheme.bodyLarge?.color,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${item['value']}',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.secondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                        ),
                      );
                    }).toList(),
              ),
            ),
            const SizedBox(height: 14),

            // 섹션 타이틀
            Text(
              AppLocalizations.of(context)!.yourNumerologyResult,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // 숫자 카드들 (Wrap으로 변경)
            Wrap(
              spacing: 12, // 가로 간격
              runSpacing: 12, // 세로 간격
              children: [
                if (lifePathNumber != null)
                  buildNumberCard(
                    AppLocalizations.of(context)!.lifePathNumber,
                    calculator.getNumberText(lifePathNumber),
                  ),
                buildNumberCard(
                  AppLocalizations.of(context)!.destinyNumber,
                  calculator.getNumberText(destinyNumber),
                ),
                buildNumberCard(
                  AppLocalizations.of(context)!.soulUrgeNumber,
                  calculator.getNumberText(soulUrgeNumber),
                ),
                buildNumberCard(
                  AppLocalizations.of(context)!.personalityNumber,
                  calculator.getNumberText(personalityNumber),
                ),
                if (maturityNumber != null)
                  buildNumberCard(
                    AppLocalizations.of(context)!.maturityNumber,
                    calculator.getNumberText(maturityNumber),
                  ),
                if (birthdayNumber != null)
                  buildNumberCard(
                    AppLocalizations.of(context)!.birthdayNumber,
                    calculator.getNumberText(birthdayNumber),
                  ),
              ],
            ),

            if (birthDate != null && pinnacleChallengeList != null) ...[
              const SizedBox(height: 24),
              Text(
                languageCode == 'ko' ? '절정수 및 도전수' : 'Pinnacles & Challenges',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: NumerologyThemes.cardGradient(isDark),
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [NumerologyThemes.cardShadow(isDark)],
                ),
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: const {
                    0: FlexColumnWidth(1.2), // 기간
                    1: FlexColumnWidth(1.0), // 나이
                    2: FlexColumnWidth(1.2), // 절정수
                    3: FlexColumnWidth(1.2), // 도전수
                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color:
                                Theme.of(context).dividerTheme.color ??
                                Colors.grey.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                      ),
                      children: [
                        buildTableCell(
                          languageCode == 'ko' ? '기간' : 'Period',
                          isHeader: true,
                        ),
                        buildTableCell(
                          languageCode == 'ko' ? '나이' : 'Age',
                          isHeader: true,
                        ),
                        buildTableCell(
                          languageCode == 'ko' ? '절정수' : 'Pin.',
                          isHeader: true,
                          isHighlight: true,
                        ),
                        buildTableCell(
                          languageCode == 'ko' ? '도전수' : 'Chal.',
                          isHeader: true,
                          isHighlight: true,
                        ),
                      ],
                    ),
                    ...pinnacleChallengeList.map((data) {
                      return TableRow(
                        children: [
                          buildTableCell(
                            languageCode == 'ko'
                                ? data['phaseKo']
                                : data['phaseEn'],
                          ),
                          buildTableCell('${data['age']}'),
                          buildTableCell(
                            '${data['pinnacle']}',
                            isHighlight: true,
                          ),
                          buildTableCell(
                            '${data['challenge']}',
                            isHighlight: true,
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],

            if (birthDate != null && lifeCycleList != null) ...[
              const SizedBox(height: 24),
              Text(
                languageCode == 'ko' ? '대주기' : 'Life Cycles',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: NumerologyThemes.cardGradient(isDark),
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [NumerologyThemes.cardShadow(isDark)],
                ),
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: const {
                    0: FlexColumnWidth(1.2), // 기간
                    1: FlexColumnWidth(1.5), // 나이
                    2: FlexColumnWidth(1.5), // 대주기 수
                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color:
                                Theme.of(context).dividerTheme.color ??
                                Colors.grey.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                      ),
                      children: [
                        buildTableCell(
                          languageCode == 'ko' ? '기간' : 'Period',
                          isHeader: true,
                        ),
                        buildTableCell(
                          languageCode == 'ko' ? '나이' : 'Age',
                          isHeader: true,
                        ),
                        buildTableCell(
                          languageCode == 'ko' ? '대주기 수' : 'Cycle Num',
                          isHeader: true,
                          isHighlight: true,
                        ),
                      ],
                    ),
                    ...lifeCycleList.map((data) {
                      return TableRow(
                        children: [
                          buildTableCell(
                            languageCode == 'ko'
                                ? data['phaseKo']
                                : data['phaseEn'],
                          ),
                          buildTableCell('${data['age']}'),
                          buildTableCell(
                            '${data['cycleNumber']}',
                            isHighlight: true,
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],

            if (birthDate != null) ...[
              const SizedBox(height: 24),

              // 연령진동수 섹션
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    languageCode == 'ko'
                        ? '연령진동수 : $currentYear - '
                        : 'Age Vibration : $currentYear - ',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      gradient: NumerologyThemes.numberGradient,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(
                            context,
                          ).colorScheme.secondary.withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '$ageVibrationNumber',
                        style: TextStyle(
                          color: isDark ? Colors.black : Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 개인 년수 섹션
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    languageCode == 'ko'
                        ? '1년수 : $currentYear - '
                        : 'Personal Year : $currentYear - ',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      gradient: NumerologyThemes.numberGradient,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(
                            context,
                          ).colorScheme.secondary.withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '$reducedPersonalYear',
                        style: TextStyle(
                          color: isDark ? Colors.black : Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 월수 카드
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: NumerologyThemes.cardGradient(isDark),
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [NumerologyThemes.cardShadow(isDark)],
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    final month = index + 1;
                    return FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            getMonthText(month),
                            style: TextStyle(
                              fontSize: 11,
                              color: Theme.of(
                                context,
                              ).textTheme.bodySmall?.color?.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.secondary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                '${monthNumbers![index]}',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
