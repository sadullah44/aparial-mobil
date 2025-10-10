import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/app_footer.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetEmail() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simüle edilmiş e-posta gönderme işlemi
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
        _emailSent = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1F2937)),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: _emailSent ? _buildEmailSentView() : _buildResetForm(),
              ),
            ),
          ),
          // Footer
          const AppFooter(),
        ],
      ),
    );
  }

  Widget _buildResetForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 40),

          // İkon
          Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1).withOpacity(0.1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(
                Icons.lock_reset,
                size: 50,
                color: Color(0xFF6366F1),
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Başlık
          const Text(
            'Şifremi Unuttum',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          // Açıklama
          const Text(
            'E-posta adresinizi girin, size şifre sıfırlama bağlantısı gönderelim',
            style: TextStyle(fontSize: 16, color: Color(0xFF6B7280)),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 48),

          // E-posta alanı
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'E-posta',
              prefixIcon: const Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF6366F1)),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'E-posta adresinizi girin';
              }
              if (!value.contains('@')) {
                return 'Geçerli bir e-posta adresi girin';
              }
              return null;
            },
          ),

          const SizedBox(height: 32),

          // Gönder butonu
          ElevatedButton(
            onPressed: _isLoading ? null : _sendResetEmail,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text(
                    'Şifre Sıfırlama Bağlantısı Gönder',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
          ),

          const Spacer(),

          // Giriş yap linki
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Şifrenizi hatırladınız mı? ',
                style: TextStyle(color: Color(0xFF6B7280)),
              ),
              TextButton(
                onPressed: () {
                  context.go('/login');
                },
                child: const Text(
                  'Giriş Yap',
                  style: TextStyle(
                    color: Color(0xFF6366F1),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmailSentView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 40),

        // Başarı ikonu
        Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
              Icons.check_circle,
              size: 50,
              color: Colors.green,
            ),
          ),
        ),

        const SizedBox(height: 32),

        // Başarı mesajı
        const Text(
          'E-posta Gönderildi!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 16),

        // Açıklama
        Text(
          '${_emailController.text} adresine şifre sıfırlama bağlantısı gönderildi. E-postanızı kontrol edin.',
          style: const TextStyle(fontSize: 16, color: Color(0xFF6B7280)),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 48),

        // Giriş yap butonu
        ElevatedButton(
          onPressed: () {
            context.go('/login');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6366F1),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Giriş Sayfasına Dön',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),

        const SizedBox(height: 16),

        // Yeniden gönder butonu
        OutlinedButton(
          onPressed: () {
            setState(() {
              _emailSent = false;
            });
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Yeniden Gönder',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),

        const Spacer(),

        // Yardım metni
        const Text(
          'E-postanızı bulamıyorsanız spam klasörünü kontrol edin.',
          style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
