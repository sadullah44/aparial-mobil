import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class NotDefteri extends StatefulWidget {
  const NotDefteri({super.key});

  @override
  State<NotDefteri> createState() => _NotDefteriState();
}

class _NotDefteriState extends State<NotDefteri> {
  final TextEditingController _controller = TextEditingController();
  String? kayitliMetin;

  @override
  void initState() {
    super.initState();
    verileriOku(); // Başlangıçta kaydı oku
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Not Defteri"),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Metin girin:"),
            TextField(controller: _controller),
            const SizedBox(height: 10),
            Row(
              children: [
                TextButton.icon(
                  onPressed: verileriKaydet,
                  icon: const Icon(Icons.save),
                  label: const Text("Kaydet"),
                ),
                const SizedBox(width: 10),
                TextButton.icon(
                  onPressed: verileriSil,
                  icon: const Icon(Icons.delete),
                  label: const Text("Sil"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              kayitliMetin ?? "Henüz kayıt yok",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  void verileriKaydet() async {
    var shPreferencesornegi = await SharedPreferences.getInstance();
    var girilenText = _controller.text;
    await shPreferencesornegi.setString("metin", girilenText);

    setState(() {
      kayitliMetin = girilenText; // ekrana yansıt
    });
  }

  void verileriOku() async {
    var shPreferencesornegi = await SharedPreferences.getInstance();
    var okunanText = shPreferencesornegi.getString("metin");
    setState(() {
      kayitliMetin = okunanText;
    });
  }

  void verileriSil() async {
    var shPreferencesornegi = await SharedPreferences.getInstance();
    await shPreferencesornegi.remove("metin");
    setState(() {
      kayitliMetin = null;
      _controller.clear();
    });
  }
}
