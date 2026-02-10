import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:numerology/services/history_service.dart';
import 'package:numerology/services/ad_service.dart';
import 'package:numerology/main.dart'; // InputScreen을 가져오기 위함
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_core/firebase_core.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isInitialized = false;
  late AdService _adService;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 초기화 로직이 한 번만 실행되도록 플래그로 제어합니다.
    if (!_isInitialized) {
      _isInitialized = true;
      _initializeApp();
    }
  }

  // 메인 화면으로 이동하는 함수
  void _navigateToMainScreen() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const InputScreen()),
    );
  }

  Future<void> _initializeApp() async {
    try {
      // 1. Firebase 및 MobileAds 초기화 (병렬 처리)
      await Future.wait([
        Firebase.initializeApp(),
        MobileAds.instance.initialize(),
      ]);

      if (!mounted) return;

      // 2. AdService 초기화
      _adService = AdService();
      await _adService.initialize();

      if (kDebugMode) {
        print('Firebase & Ads 초기화 완료');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Firebase/Ads 초기화 실패: $e');
      }
    }

    // 3. HistoryService에서 기록 데이터를 백그라운드에서 로드
    final historyService = Provider.of<HistoryService>(context, listen: false);
    historyService.loadHistory().timeout(
      const Duration(seconds: 3),
      onTimeout: () {
        if (kDebugMode) {
          print('히스토리 로딩 타임아웃 (3초 초과)');
        }
      },
    ).catchError((e) {
      if (kDebugMode) {
        print('백그라운드 히스토리 로딩 실패: $e');
      }
    });

    // 4. 스플래시 화면 최소 표시 시간 (1.5초)
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;

    // 5. 미리 로드된 스플래시 광고 표시
    final adShown = await _adService.showSplashAd(
      onAdDismissed: _navigateToMainScreen,
    );

    // 광고가 표시되지 않았으면 바로 메인 화면으로 이동
    if (!adShown) {
      _navigateToMainScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primary, // 앱의 기본 색상으로 배경 설정
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.white), // 로딩 인디케이터
              SizedBox(height: 20),
              Text(
                'Loading...', // 로딩 텍스트
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}