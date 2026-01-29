import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:numerology/services/history_service.dart';
import 'package:numerology/services/ad_service.dart';
import 'package:numerology/main.dart'; // InputScreen을 가져오기 위함

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isInitialized = false;

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
    // 스플래시 화면 시작 시간 기록
    final startTime = DateTime.now();

    // 1. HistoryService에서 기록 데이터를 백그라운드에서 로드합니다.
    // 타임아웃 설정: 최대 3초
    try {
      await Provider.of<HistoryService>(context, listen: false)
          .loadHistory()
          .timeout(
            const Duration(seconds: 3),
            onTimeout: () {
              // 타임아웃 시 경고 출력 (릴리즈에서는 무시됨)
              if (kDebugMode) {
                print('히스토리 로딩 타임아웃 (3초 초과)');
              }
            },
          );
    } catch (e) {
      if (kDebugMode) {
        print('히스토리 로딩 실패: $e');
      }
    }

    // 2. 디버그 모드에서도 스플래시 화면을 최소 2초 보여줍니다.
    final adService = AdService();

    if (kDebugMode) {
      // 디버그 모드: 테스트 광고 ID 사용 + 2초 최소 대기
      final elapsed = DateTime.now().difference(startTime);
      final remainingTime = const Duration(seconds: 2) - elapsed;

      if (remainingTime.inMilliseconds > 0) {
        await Future.delayed(remainingTime);
      }

      // 테스트 광고 표시 (타임아웃 5초)
      await adService.loadAndShowSplashAd(
        adUnitId: 'ca-app-pub-3940256099942544/1033173712', // 테스트 광고 ID
        onAdDismissed: _navigateToMainScreen,
        onAdFailed: _navigateToMainScreen,
        timeout: const Duration(seconds: 5), // 광고 로딩 타임아웃
      );
    } else {
      // 출시 모드: 실제 광고 ID 사용 (타임아웃 5초)
      await adService.loadAndShowSplashAd(
        adUnitId: 'ca-app-pub-7332476431820224/9337504089',
        onAdDismissed: _navigateToMainScreen,
        onAdFailed: _navigateToMainScreen,
        timeout: const Duration(seconds: 5), // 광고 로딩 타임아웃
      );
    }

    // 전체 스플래시 화면 최대 시간 제한 (6초)
    final totalElapsed = DateTime.now().difference(startTime);
    if (totalElapsed.inSeconds > 6) {
      if (kDebugMode) {
        print('스플래시 화면 최대 시간 초과 (10초), 강제 이동');
      }
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