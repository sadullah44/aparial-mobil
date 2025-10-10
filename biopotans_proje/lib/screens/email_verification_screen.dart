// lib/screens/email_verification_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../services/auth_service.dart';
import '../utils/app_router.dart';
import '../widgets/app_footer.dart';
import '../widgets/custom_button.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  bool _isLoading = false;

  // "Tekrar Gönder" butonu için zamanlayıcı durumu
  Timer? _timer;
  int _countdown = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _codeController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _countdown = 60;
    _canResend = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        if (mounted) {
          setState(() {
            _countdown--;
          });
        }
      } else {
        timer.cancel();
        if (mounted) {
          setState(() {
            _canResend = true;
          });
        }
      }
    });
  }

  Future<void> _verifyCode() async {
    if (_formKey.currentState?.validate() != true) return;

    setState(() => _isLoading = true);

    try {
      final success = await AuthService.verifyEmail(
        _codeController.text.trim(),
      );
      if (success && mounted) {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('Başarılı!'),
            content: const Text('Kullanıcı kayıt edildi ✅'),
            actions: [
              TextButton(
                onPressed: () {
                  context.pop(); // Dialog'u kapat
                  context.go(AppRouter.login); // Giriş ekranına git
                },
                child: const Text('Giriş Yap'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceFirst('Exception: ', '')),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _resendCode() async {
    if (!_canResend) return;

    // UI'da hemen zamanlayıcıyı başlat
    setState(() {
      _startTimer();
    });

    try {
      await AuthService.resendVerificationCode();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Yeni doğrulama kodu e-postanıza gönderildi.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceFirst('Exception: ', '')),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('E-posta Doğrulama')),
      body: Column(
        children: [
          Expanded(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      const Icon(
                        Icons.mark_email_read_outlined,
                        size: 80,
                        color: Color(0xFF571a46),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Doğrulama Kodunu Girin',
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'E-posta adresinize gönderilen 6 haneli kodu aşağıdaki alana girin.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF6B7280),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),

                      // 6 haneli kod girişi alanı
                      TextFormField(
                        controller: _codeController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 6,
                        style: const TextStyle(
                          fontSize: 24,
                          letterSpacing: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          counterText: '', // Karakter sayacını gizle
                          hintText: '------',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen kodu girin';
                          }
                          if (value.length != 6) {
                            return 'Kod 6 haneli olmalıdır';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),

                      // Doğrula Butonu
                      CustomButton(
                        text: 'Hesabı Doğrula',
                        isLoading: _isLoading,
                        onPressed: _verifyCode,
                      ),
                      const SizedBox(height: 24),

                      // Tekrar Gönder Butonu
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Kodu almadınız mı?"),
                          TextButton(
                            onPressed: _canResend ? _resendCode : null,
                            child: Text(
                              _canResend
                                  ? 'Tekrar Gönder'
                                  : 'Tekrar Gönder (${_countdown}s)',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const AppFooter(),
        ],
      ),
    );
  }
}
