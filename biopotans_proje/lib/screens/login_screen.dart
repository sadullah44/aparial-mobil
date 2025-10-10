import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/auth_service.dart';
import '../widgets/app_footer.dart';
import '../widgets/custom_button.dart';
import '../utils/app_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() != true) return;

    setState(() => _loading = true);

    try {
      final success = await AuthService.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (success && mounted) {
        context.go(AppRouter.dashboard);
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
        setState(() => _loading = false);
      }
    }
  }

  // Placeholder function for social login
  void _socialLoginPressed(String provider) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$provider ile giriş özelliği yakında eklenecektir.'),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
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
                      const SizedBox(height: 24),
                      Text(
                        'Giriş Yap',
                        style: textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'E-posta',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'E-posta gerekli';
                          final emailRegex = RegExp(
                            r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
                          );
                          if (!emailRegex.hasMatch(v)) {
                            return 'Geçerli bir e-posta girin';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscure,
                        decoration: InputDecoration(
                          labelText: 'Şifre',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () =>
                                setState(() => _obscure = !_obscure),
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Şifre gerekli';
                          return null;
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => context.go(AppRouter.forgotPassword),
                          child: const Text('Şifremi Unuttum?'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      CustomButton(
                        text: 'Giriş',
                        onPressed: _login,
                        isLoading: _loading,
                      ),
                      const SizedBox(height: 24),

                      // --- YENİ EKLENEN BÖLÜM ---
                      Row(
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Text(
                              'veya',
                              style: textTheme.bodySmall?.copyWith(
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialButton(
                            'assets/google_logo.svg', // SVG için flutter_svg paketi gerekir
                            'Google',
                            () => _socialLoginPressed('Google'),
                          ),
                          const SizedBox(width: 20),
                          _buildSocialButton(
                            'assets/apple_logo.svg',
                            'Apple',
                            () => _socialLoginPressed('Apple'),
                          ),
                        ],
                      ),

                      // --- YENİ BÖLÜM SONU ---
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Hesabınız yok mu?'),
                          TextButton(
                            onPressed: () => context.go(AppRouter.register),
                            child: const Text('Kayıt Ol'),
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

  // Sosyal medya butonu için yardımcı widget
  Widget _buildSocialButton(
    String assetPath,
    String provider,
    VoidCallback onPressed,
  ) {
    // Not: Bu kısım SVG assetleri için flutter_svg paketine ihtiyaç duyar.
    // Şimdilik placeholder olarak bir ikon kullanıyoruz.
    return IconButton(
      icon: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.grey.shade200,
        child: provider == 'Google'
            ? const Icon(
                Icons.g_mobiledata,
                size: 36,
                color: Colors.red,
              ) // Placeholder Google ikonu
            : const Icon(
                Icons.apple,
                size: 28,
                color: Colors.black,
              ), // Placeholder Apple ikonu
      ),
      onPressed: onPressed,
      iconSize: 48,
    );
  }
}
