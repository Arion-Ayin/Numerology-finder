// 이 파일은 앱의 '설정' 화면을 만드는 코드예요.
// 여기서 앱의 여러 가지 설정을 바꿀 수 있어요.
import 'package:flutter/material.dart'; // Flutter 앱을 만드는 데 필요한 기본 도구들을 가져와요.
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart'; // 앱의 중요한 정보(테마 같은 것)를 여러 화면에서 함께 쓸 수 있게 도와주는 도구예요.
import 'package:numerology/theme_provider.dart'; // 앱의 테마(밝은 모드, 어두운 모드)를 관리하는 특별한 도구를 가져와요.
import 'package:numerology/generated/l10n/app_localizations.dart'; // 앱의 다국어 문자열을 가져와요.
import 'package:numerology/locale_provider.dart'; // 앱의 언어 설정을 관리하는 도구를 가져와요.
import 'package:numerology/widgets/setting_card.dart'; // 설정 화면에 들어가는 한 줄짜리 카드를 만드는 위젯을 가져와요.
import 'package:url_launcher/url_launcher.dart'; // 웹사이트나 이메일 앱을 열어주는 라이브러리예요.
import 'package:numerology/ads/ad_ids.dart';

// '설정' 화면을 보여주는 위젯이에요.
class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  NativeAd? _nativeAd;
  bool _isNativeAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadNativeAd();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  void _loadNativeAd() {
    _nativeAd = NativeAd(
      adUnitId: AdIds.nativeAdUnitId,
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            _isNativeAdLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          print('Native ad failed to load: $error');
        },
      ),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
      ),
    )..load();
  }

  Future<void> _showAdAndNavigate(String url) async {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final isKorean = localeProvider.locale?.languageCode == 'ko';

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isKorean ? '블로그로 이동' : 'Go to Blog'),
          content: (_isNativeAdLoaded && _nativeAd != null)
              ? ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 300,
                  ),
                  child: AdWidget(ad: _nativeAd!),
                )
              : const SizedBox.shrink(),
          actions: <Widget>[
            TextButton(
              child: Text(isKorean ? '취소' : 'Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(isKorean ? '이동' : 'Go'),
              onPressed: () async {
                Navigator.of(context).pop();
                final Uri uri = Uri.parse(url);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                } else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Could not launch $url'),
                      ),
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showUrlConfirmationDialog(
    BuildContext context, {
    required String url,
    required String serviceNameKo,
    required String serviceNameEn,
  }) async {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final isKorean = localeProvider.locale?.languageCode == 'ko';

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isKorean ? '$serviceNameKo로 이동' : 'Go to $serviceNameEn'),
          content: (_isNativeAdLoaded && _nativeAd != null)
              ? ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 300,
                  ),
                  child: AdWidget(ad: _nativeAd!),
                )
              : Text(isKorean ? '이 서비스로 이동하시겠습니까?' : 'Open this service in your browser?'),
          actions: <Widget>[
            TextButton(
              child: Text(isKorean ? '취소' : 'Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(isKorean ? '이동' : 'Open'),
              onPressed: () async {
                Navigator.of(context).pop();
                final Uri uri = Uri.parse(url);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                } else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Could not launch $url'),
                      ),
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  // 이 함수는 화면에 무엇을 그릴지 정해줘요.
  @override
  Widget build(BuildContext context) {
    // 'ThemeProvider'라는 도구에서 현재 앱의 테마 정보를 가져와요.
    // 이 정보로 앱이 밝은 모드인지 어두운 모드인지 알 수 있어요.
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);
    final appLocalizations = AppLocalizations.of(context)!;

    // 화면 전체를 감싸는 큰 상자를 만들어요.
    return Container(
      // 상자 안쪽에 16만큼의 여백을 줘서 내용이 벽에 붙지 않게 해요.
      padding: const EdgeInsets.all(16.0),
      // 상자 안에 내용들을 위에서 아래로 차례대로 쌓을 거예요.
      child: Column(
        // 내용들을 왼쪽으로 정렬해요.
        crossAxisAlignment: CrossAxisAlignment.start,
        // 상자 안에 들어갈 내용들이에요.
        children: [
          // 글씨 아래에 20만큼의 빈 공간을 만들어요.
          const SizedBox(height: 20),
          // 다크 모드 설정 카드
          SettingCard(
            icon: Icons.wb_sunny_outlined,
            title: appLocalizations.darkMode,
            iconColor: const Color(0xFFE91E63), // 핑크
            trailing: Switch(
              value: themeProvider.themeMode == ThemeMode.dark,
              onChanged: (value) {
                themeProvider.toggleTheme(value);
              },
              activeThumbColor: Theme.of(context).colorScheme.secondary,
              activeTrackColor: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.3),
            ),
          ),
          const SizedBox(height: 10),
          // 언어 설정 카드
          SettingCard(
            icon: Icons.language,
            title: appLocalizations.language,
            iconColor: const Color(0xFF2196F3), // 블루
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.3),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<Locale>(
                value: localeProvider.locale,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                underline: const SizedBox(),
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontSize: 14,
                ),
                onChanged: (Locale? newLocale) {
                  if (newLocale != null) {
                    localeProvider.setLocale(newLocale);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(appLocalizations.languageChanged(newLocale.languageCode == 'en' ? appLocalizations.english : appLocalizations.korean)),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
                items: const <DropdownMenuItem<Locale>>[
                  DropdownMenuItem<Locale>(
                    value: Locale('en'),
                    child: Text('English'),
                  ),
                  DropdownMenuItem<Locale>(
                    value: Locale('ko'),
                    child: Text('한국어'),
                  ),
                ],
              ),
            ),
          ),

              // 네 번째 설정 카드: 디스코드
        SettingCard(
                icon: Icons.headset, // 디스코드를 상징하는 헤드셋 아이콘
                title: appLocalizations.discord, // '디스코드' 제목
                iconColor: const Color(0xFF5865F2), // 디스코드 블러플
                trailing: const Icon(
                  Icons.arrow_forward_ios, // 오른쪽 화살표 아이콘
                  size: 30,
                  color: Colors.grey,
                ),
                onTap: () {
                  // 카드 아무 곳이나 누르면 확인 대화상자를 띄웁니다.
                  _showUrlConfirmationDialog(
                    context,
                    url: 'https://discord.gg/wMD29tUa',
                    serviceNameKo: '디스코드',
                    serviceNameEn: 'Discord',
                  );
                },
              ),

          SettingCard(
            icon: Icons.article_outlined,
            title: appLocalizations.community,
            iconColor: const Color(0xFF4CAF50), // 그린
            onTap: () {
              _showAdAndNavigate('https://arion-ayin.github.io/');
            },
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}