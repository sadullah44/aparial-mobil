import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Görev1',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Ana Sayfa'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color appBarRenk = Colors.white;
  Color scaffoldRenk = Colors.white;
  @override
  Widget build(BuildContext context) {
    void arkaPlanRengiDegistir() {
      setState(() {
        appBarRenk = Colors.blue;
        scaffoldRenk = Colors.deepPurple;
      });
    }

    void mesajGoster() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "SnackBar ile Merhaba Flutter!",
            style: TextStyle(
              fontSize: 30,
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.blue,
        ),
      );
    }

    return Scaffold(
      backgroundColor: scaffoldRenk,
      appBar: AppBar(
        backgroundColor: appBarRenk,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("resimler/profil.jpg", width: 200, height: 200),
            const Text(
              "Flutter Widget Antrenmanı",
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: arkaPlanRengiDegistir,
                  child: Text("Renk Değiştir"),
                ),
                ElevatedButton(
                  onPressed: mesajGoster,
                  child: Text("Mesaj Göster"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
