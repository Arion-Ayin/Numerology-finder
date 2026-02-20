import 'dart:async';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:numerology/services/preferences_service.dart';
import 'package:numerology/ads/ad_ids.dart';

/// 전면 광고 및 광고 정책을 관리하는 서비스 클래스입니다.
class AdService {
  // 싱글톤 패턴: 앱 전체에서 하나의 인스턴스만 사용합니다.
  static final AdService _instance = AdService._internal();
  factory AdService() => _instance;
  AdService._internal();

  InterstitialAd? _interstitialAd;
  InterstitialAd? _splashAd; // 스플래시용 미리 로드된 광고
  Future<void>? _splashAdFuture; // 현재 진행 중인 스플래시 광고 로딩 Future
  int _calculateClickCount = 0;
  final int _adFrequency = 7; // 광고 표시 빈도 (7번 클릭마다)

  static const _clickCountKey = 'calculateClickCount';
  static const _lastSplashAdShowTimeKey = 'lastSplashAdShowTime';

  /// 서비스 초기화 시 광고와 클릭 횟수를 로드합니다.
  Future<void> initialize() async {

    await _loadCalculateClickCount();
    _loadInterstitialAd();
    preloadSplashAd(); // 비동기로 시작 (스플래시 화면에서 대기)
  }

  /// 스플래시 광고를 미리 로드합니다. (앱 시작 시 호출)
  /// Future를 반환하여 광고 로드 완료를 기다릴 수 있습니다.
  /// 이미 로딩 중이면 같은 Future를 반환합니다.
  Future<void> preloadSplashAd() {
    // 이미 로드 완료
    if (_splashAd != null) return Future.value();
    // 이미 로딩 중이면 같은 Future 반환
    if (_splashAdFuture != null) return _splashAdFuture!;

    final completer = Completer<void>();
    _splashAdFuture = completer.future;

    InterstitialAd.load(
      adUnitId: AdIds.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _splashAd = ad;
          _splashAdFuture = null;
          completer.complete();
        },
        onAdFailedToLoad: (error) {
          _splashAd = null;
          _splashAdFuture = null;
          completer.complete(); // 실패해도 완료 처리
        },
      ),
    );

    return completer.future;
  }

  /// 스플래시 광고가 로드되었는지 확인합니다.
  bool get isSplashAdReady => _splashAd != null;

  /// 전면 광고를 로드합니다.
  void _loadInterstitialAd() {
    InterstitialAd.load( // 이전에 설정된 일반 전면 광고 로드
      adUnitId: AdIds.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (error) {
          _interstitialAd?.dispose();
          _interstitialAd = null;
        },
      ),
    );
  }

  /// 광고를 표시할지 결정하고, 필요 시 광고를 보여줍니다.
  /// 광고가 표시되면 true, 아니면 false를 반환합니다.
  Future<bool> showAdIfNeeded(Function onAdDismissed) async {
    _calculateClickCount++;
    await _saveCalculateClickCount();

    if (_calculateClickCount % _adFrequency == 0 && _interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          onAdDismissed();
          ad.dispose();
          _loadInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          onAdDismissed();
          ad.dispose();
          _loadInterstitialAd();
        },
      );
      _interstitialAd!.show();
      return true; // 광고가 표시됨
    }
    return false; // 광고가 표시되지 않음
  }

  /// 미리 로드된 스플래시 광고를 즉시 표시합니다.
  /// 광고가 표시되면 true, 표시되지 않으면 false를 반환합니다.
  Future<bool> showSplashAd({
    required Function onAdDismissed,
  }) async {
    final lastAdShowTimeMillis = PreferencesService.getInt(_lastSplashAdShowTimeKey) ?? 0;
    final currentTimeMillis = DateTime.now().millisecondsSinceEpoch;

    // 30분 (밀리초 단위)
    const thirtyMinutesInMillis = 30 * 60 * 1000;

    // 30분 쿨다운 체크
    if (currentTimeMillis - lastAdShowTimeMillis < thirtyMinutesInMillis) {
      return false;
    }

    // 광고가 로드되어 있지 않으면 false 반환 (대기 없이 즉시 진행)
    if (_splashAd == null) {
      return false;
    }

    // 광고 표시 시간 저장
    await PreferencesService.setInt(_lastSplashAdShowTimeKey, currentTimeMillis);

    _splashAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        onAdDismissed();
        ad.dispose();
        _splashAd = null;
        preloadSplashAd(); // 다음 세션을 위해 미리 로드
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        onAdDismissed();
        ad.dispose();
        _splashAd = null;
        preloadSplashAd();
      },
    );

    _splashAd!.show();
    return true;
  }

  Future<void> _loadCalculateClickCount() async {
    _calculateClickCount = PreferencesService.getInt(_clickCountKey) ?? 0;
  }

  Future<void> _saveCalculateClickCount() async {
    await PreferencesService.setInt(_clickCountKey, _calculateClickCount);
  }

  void dispose() {
    _interstitialAd?.dispose();
    _splashAd?.dispose();
  }
}