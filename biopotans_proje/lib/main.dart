import 'package:flutter/material.dart';
import 'utils/app_router.dart';
import 'utils/app_theme.dart'; // Ekle

void main() {
  runApp(const BiopotansApp());
}

class BiopotansApp extends StatelessWidget {
  const BiopotansApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'BİOPOTANS - Bireysel Gelişim Platformu',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
