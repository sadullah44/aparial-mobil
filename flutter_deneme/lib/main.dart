import 'package:flutter/material.dart';
import 'notDefteri.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hakkımda',
      theme: ThemeData(
  
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        scaffoldBackgroundColor: Colors.yellow
      ),
    
      home: const NotDefteri(),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key, required this.title});

  

  final String title;

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
      
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        
        title: Text(widget.title),
      ),
      body: Center(
       
        child: Column(
         
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text("Sadullah Özden"),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.amber,
                  radius: 100,
                  backgroundImage: AssetImage("assets/profil.jpg"),
                ),
                Text("Sadullah Özden")
              ]
              
            ),
            SizedBox(height: 20,),
            Text("Bilgisayar Mühendisliği 4. sınıf öğrencisiyim ve yazılım geliştirme alanında kariyer hedefliyorum. Üniversite hayatım boyunca edindiğim teorik bilgileri pratiğe dökmek istiyorum. C#, .NET, Python, Java,SQL gibi yazılım dilleriyle projeler geliştirdim. Staj ile gerçek hayat projelerinde yer almak istiyorum."),
            Row(
              children: [
                 CircleAvatar(
                    backgroundImage: AssetImage("assets/adres.png"),
                    backgroundColor: Colors.yellowAccent,
                ),
                Text("Zafer Mahallesi Cevher Sokak No:14 Daire:5 Bahçelievler/İstanbul")
              ],
            ),
            Row(
              children: [
                 CircleAvatar(
                    backgroundImage: AssetImage("assets/telefonIcon.png"),
                    backgroundColor: Colors.yellowAccent,
                ),
                Text("05316606803")
              ],
            ),
            Row(
              children: [
                 CircleAvatar(
                    backgroundImage: AssetImage("assets/emailIcon.jpg"),
                    backgroundColor: Colors.yellowAccent,
                ),
                Text("sdllhozden@gmail.com")
              ],
            )
           
          ],
          
        ),
        

      
      ),
      
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _incrementCounter,
        tooltip: 'Artır',
        label: Text("Sayaç artır"),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.redAccent,
      ), 
    );
  }
}
