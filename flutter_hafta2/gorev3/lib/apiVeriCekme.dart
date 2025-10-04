import 'dart:convert'; // jsonDecode için gerekli
import 'package:gorev3/usersModel.dart';
import 'package:http/http.dart' as http;

const String url = "https://jsonplaceholder.typicode.com/users";

class Apivericekme {
  Future<List<Usersmodel>> getUsers() async {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)",
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    );

    print("uygulama başladı");
    print(response.statusCode);

    if (response.statusCode == 200) {
      // JSON'u decode et
      List<dynamic> jsonData = jsonDecode(response.body);
      // Her bir json objesini Usersmodel'e çevir
      List<Usersmodel> users = jsonData
          .map((json) => Usersmodel.fromJson(json))
          .toList();
      return users;
    } else {
      print("Hata: ${response.statusCode}");
      return []; // Boş liste döndür
    }
  }
}
