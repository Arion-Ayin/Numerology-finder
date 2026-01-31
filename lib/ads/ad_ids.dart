
import 'package:flutter/foundation.dart';

/// 광고 ID를 중앙에서 관리하는 파일입니다.
/// 테스트 모드와 실제 모드를 구분하여 광고 ID를 제공합니다.

class AdIds {
  static bool get isTestMode => kDebugMode; // 디버그 모드일 때 테스트 광고 사용

  static String get bannerAdUnitId {
    return isTestMode
        ? 'ca-app-pub-3940256099942544/6300978111' // 테스트 배너 광고 ID
        : 'ca-app-pub-7332476431820224/7832850720'; // 실제 배너 광고 ID
  }

  static String get interstitialAdUnitId {
    return isTestMode
        ? 'ca-app-pub-3940256099942544/1033173712' // 테스트 전면 광고 ID
        : 'ca-app-pub-7332476431820224/9337504089'; // 실제 전면 광고 ID
  }

  static String get nativeAdUnitId {
    return isTestMode
        ? 'ca-app-pub-3940256099942544/2247696110' // 테스트 네이티브 광고 ID
        : 'ca-app-pub-7332476431820224/5792684086'; // 실제 네이티브 광고 ID
  }
}