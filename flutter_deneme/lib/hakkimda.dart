//material.dart import et
import 'package:flutter/material.dart';
// class aç ve StatelesWidget'tan kalıtım al
class Hakkimda extends StatelessWidget{
  const Hakkimda({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hakkımda"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Profil Avatarı
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/profil.jpg"),
            ),
            const SizedBox(height: 20), // avatar ile ad arasında boşluk
            // Ad Soyad
            const Text(
              "Sadullah Özden",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}