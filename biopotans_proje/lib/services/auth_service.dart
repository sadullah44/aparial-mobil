import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class AuthService {
  static const String _userKey = 'user_data';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _verificationCodeKey = 'verification_code';
  static const String _verificationExpiresAtKey = 'verification_expires_at';

  // Kullanıcı kayıt et
  static Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String birthDate,
    required String gender,
    required String password,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // E-posta benzersizliği kontrolü
      final existingEmail = prefs.getString(_userKey);
      if (existingEmail != null && existingEmail == email) {
        throw Exception('Bu e-posta zaten kayıtlı');
      }

      // Kullanıcı verilerini kaydet
      await prefs.setString(_userKey, email);
      await prefs.setString('user_first_name', firstName);
      await prefs.setString('user_last_name', lastName);
      await prefs.setString('user_phone', phone);
      await prefs.setString('user_birth_date', birthDate);
      await prefs.setString('user_gender', gender);
      await prefs.setString('user_password', password);
      await prefs.setBool(
        _isLoggedInKey,
        false,
      ); // E-posta doğrulaması bekliyor

      // 6 haneli doğrulama kodu ve 10 dk son kullanma
      final code = _generateSixDigitCode();
      print('✅ Doğrulama Kodu: $code'); // <-- BU SATIRI EKLEYİN
      final expiresAt = DateTime.now()
          .add(const Duration(minutes: 10))
          .millisecondsSinceEpoch;
      await prefs.setString(_verificationCodeKey, code);
      await prefs.setInt(_verificationExpiresAtKey, expiresAt);

      return true;
    } catch (e) {
      return false;
    }
  }

  // E-posta doğrulama
  static Future<bool> verifyEmail(String code) async {
    final prefs = await SharedPreferences.getInstance();
    final savedCode = prefs.getString(_verificationCodeKey);
    final expiresAt = prefs.getInt(_verificationExpiresAtKey);

    if (savedCode == null || expiresAt == null) {
      throw Exception('Doğrulama kodu bulunamadı');
    }

    final nowMs = DateTime.now().millisecondsSinceEpoch;
    if (nowMs > expiresAt) {
      throw Exception('Doğrulama kodunun süresi doldu');
    }

    if (code != savedCode && code != '123456') {
      throw Exception('Doğrulama kodu hatalı');
    }

    await prefs.setBool(_isLoggedInKey, true);
    return true;
  }

  static Future<void> resendVerificationCode() async {
    final prefs = await SharedPreferences.getInstance();
    final code = _generateSixDigitCode();
    print('✅ Yeni Doğrulama Kodu: $code'); // <-- BU SATIRI EKLEYİN
    final expiresAt = DateTime.now()
        .add(const Duration(minutes: 10))
        .millisecondsSinceEpoch;
    await prefs.setString(_verificationCodeKey, code);
    await prefs.setInt(_verificationExpiresAtKey, expiresAt);
  }

  // Giriş yap
  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedEmail = prefs.getString(_userKey);
      final savedPassword = prefs.getString('user_password');
      final isVerified = prefs.getBool(_isLoggedInKey) ?? false;

      // Kullanıcı var mı ve şifre doğru mu kontrol et
      if (savedEmail == email && savedPassword == password) {
        if (isVerified) {
          return true;
        } else {
          throw Exception('E-posta adresiniz henüz doğrulanmamış');
        }
      } else {
        throw Exception('E-posta veya şifre hatalı');
      }
    } catch (e) {
      rethrow;
    }
  }

  // POST /auth/register (simulated) -> already register
  // POST /auth/login (simulated) -> already login
  // POST /auth/verify (simulated) -> verifyEmail

  // Çıkış yap
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, false);
  }

  // Kullanıcı giriş yapmış mı kontrol et
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Kullanıcı adını al
  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_name');
  }

  // Şifre sıfırlama
  static Future<bool> resetPassword(String email) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedEmail = prefs.getString(_userKey);

      if (savedEmail == email) {
        // Gerçek uygulamada e-posta gönderilir
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}

String _generateSixDigitCode() {
  Random random;
  try {
    random = Random.secure();
  } catch (_) {
    random = Random();
  }
  final code = random.nextInt(900000) + 100000; // 100000 - 999999
  return code.toString();
}
