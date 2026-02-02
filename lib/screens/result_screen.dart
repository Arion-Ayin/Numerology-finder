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

    if (birthDate != null) {
      lifePathNumber = calculator.calculateLifePathNumber(birthDate!);
      maturityNumber = calculator.calculateMaturityNumber(
        lifePathNumber,
        destinyNumber,
      );
      birthdayNumber = calculator.calculateBirthdayNumber(birthDate!);
      monthNumbers = calculator.calculateAllPersonalMonths(birthDate!);
      reducedPersonalYear = calculator.calculatePersonalYearNumber(birthDate!);
    }

    final String languageCode = Localizations.localeOf(context).languageCode;

    String getMonthText(int month) {
      if (languageCode == 'ko') {
        return '$month월수';
      } else {
        const monthAbbreviations = [
          'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
          'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
        ];
        return monthAbbreviations[month - 1];
      }
    }

    final int currentYear = DateTime.now().year;

    Widget buildNumberCard(String label, String value, {Color? accentColor}) {
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: NumerologyThemes.cardGradient(isDark),
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [NumerologyThemes.cardShadow(isDark)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: (accentColor ?? Theme.of(context).colorScheme.secondary)
                    .withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                value,
                style: TextStyle(
                  color: accentColor ?? Theme.of(context).colorScheme.secondary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
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
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.15),
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
                                color: Theme.of(context).textTheme.titleLarge?.color,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (birthDate != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                birthDate!.toLocal().toString().split(' ')[0],
                                style: TextStyle(
                                  color: Theme.of(context).textTheme.bodyMedium?.color,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

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

            // 숫자 카드들
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

            if (birthDate != null) ...[
              const SizedBox(height: 24),

              // 개인 년수 섹션
              Text(
                '${AppLocalizations.of(context)!.personalYearNumber} $currentYear',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // 년수 카드
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
                child: Column(
                  children: [
                    // 년수 표시
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        gradient: NumerologyThemes.numberGradient,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          '$reducedPersonalYear',
                          style: TextStyle(
                            color: isDark ? Colors.black : Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 월수 그리드
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: List.generate(6, (index) {
                              final month = index + 1;
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      getMonthText(month),
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${monthNumbers![index]}',
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.secondary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: Column(
                            children: List.generate(6, (index) {
                              final month = index + 7;
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      getMonthText(month),
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${monthNumbers![index + 6]}',
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.secondary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ],
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
