import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_app/view/home.dart';
import 'package:game_app/view/detail.dart'; // Import halaman Detail [cite: 526]

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengatur status bar (opsional) [cite: 66]
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Game Store',
      initialRoute: '/', // Halaman pertama yang ditampilkan [cite: 528]
      routes: {
        // Peta yang menghubungkan route name dengan halaman [cite: 529]
        '/': (context) => const Home(),
        '/detail': (context) {
          // Menerima argumen ID game yang dikirim dari Home [cite: 530]
          final gameId = ModalRoute.of(context)!.settings.arguments as int;
          return Detail(gameTerpilih: gameId);
        },
      },
    );
  }
}
