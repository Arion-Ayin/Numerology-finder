import 'package:shared_preferences/shared_preferences.dart';

/// 싱글톤으로 SharedPreferences 인스턴스를 관리하는 서비스입니다.
/// 앱 전체에서 단 한 번만 SharedPreferences.getInstance()를 호출하도록 최적화합니다.
class PreferencesService {
  static final PreferencesService _instance = PreferencesService._internal();
  static late SharedPreferences _prefs;

  /// 싱글톤 인스턴스를 반환합니다.
  factory PreferencesService() {
    return _instance;
  }

  PreferencesService._internal();

  /// 서비스를 초기화합니다. 앱 시작 시 한 번 호출해야 합니다.
  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// 캐시된 SharedPreferences 인스턴스를 반환합니다.
  static SharedPreferences get instance {
    return _prefs;
  }

  /// 편의 메서드: 문자열 가져오기
  static String? getString(String key) {
    return _prefs.getString(key);
  }

  /// 편의 메서드: 문자열 저장
  static Future<bool> setString(String key, String value) {
    return _prefs.setString(key, value);
  }

  /// 편의 메서드: 불린 가져오기
  static bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  /// 편의 메서드: 불린 저장
  static Future<bool> setBool(String key, bool value) {
    return _prefs.setBool(key, value);
  }

  /// 편의 메서드: 정수 가져오기
  static int? getInt(String key) {
    return _prefs.getInt(key);
  }

  /// 편의 메서드: 정수 저장
  static Future<bool> setInt(String key, int value) {
    return _prefs.setInt(key, value);
  }

  /// 편의 메서드: 문자열 리스트 가져오기
  static List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }

  /// 편의 메서드: 문자열 리스트 저장
  static Future<bool> setStringList(String key, List<String> value) {
    return _prefs.setStringList(key, value);
  }
}
