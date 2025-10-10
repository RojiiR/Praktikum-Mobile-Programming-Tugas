import 'package:flutter/material.dart';
import 'package:game_app/model/game.dart';
import 'package:game_app/viewmodel/fetchgame.dart';

// Widget Card untuk menampilkan setiap item game [cite: 212]
Card _listItem(String urlCover, String judul, String genre) {
  return Card(
    clipBehavior: Clip.antiAlias,
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: ListTile(
      tileColor: Colors.blue.shade50,
      leading: SizedBox(
        width: 75,
        height: 75,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(urlCover, scale: 3, fit: BoxFit.cover),
        ),
      ),
      title: Text(judul),
      subtitle: Text(genre),
      trailing: const Icon(Icons.more_vert),
      titleAlignment: ListTileTitleAlignment.center,
    ),
  );
}

// Widget TextField untuk Search Bar [cite: 138]
TextField _searchBar() {
  return TextField(
    cursorColor: Colors.blue,
    decoration: InputDecoration(
      fillColor: Colors.blue.shade50,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      prefixIcon: const Icon(
        Icons.search_outlined,
        color: Colors.blue,
        size: 30,
      ),
      hintText: 'Cari game',
      hintStyle: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.7)),
    ),
  );
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  // Variabel untuk menyimpan future object data Game [cite: 98, 99]
  late Future<List<Game>> gameList;

  @override
  void initState() {
    super.initState();
    // Panggil loadGames() agar data dimuat saat pertama kali widget dibuat [cite: 101, 103]
    loadGames();
  }

  // Method untuk menjalankan fetchGames()
  Future<List<Game>> loadGames() async {
    gameList = fetchGames();
    return gameList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent.shade400,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            children: [
              _searchBar(), // Search Bar di bagian atas [cite: 195, 208]
              const SizedBox(
                height:
                    10, // Jarak antara Search Bar dan ListView [cite: 197, 199, 209]
              ),
              // FutureBuilder untuk menampilkan data dari API [cite: 271, 341]
              FutureBuilder<List<Game>>(
                future:
                    gameList, // Menggunakan future yang sudah disimpan di initState
                builder: (context, snapshot) {
                  // State: Loading [cite: 344]
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  // State: Error [cite: 346, 347]
                  else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  // State: Data Tersedia dan Tidak Kosong [cite: 295]
                  else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    final games = snapshot.data!
                        .take(25)
                        .toList(); // Ambil 25 data pertama
                    return Expanded(
                      child: ListView.builder(
                        // Membuat daftar widget [cite: 350]
                        itemCount: games.length,
                        itemBuilder: (context, index) {
                          final game = games[index];
                          return GestureDetector(
                            // Menangkap interaksi klik [cite: 352]
                            onTap: () {
                              // Navigasi ke halaman detail dengan named route '/detail' [cite: 353, 354]
                              Navigator.pushNamed(
                                context,
                                '/detail',
                                arguments:
                                    game.id, // Mengirim id game sebagai argumen
                              );
                            },
                            child: _listItem(
                              // Menampilkan item game
                              game.thumbnail,
                              game.title,
                              game.genre,
                            ),
                          );
                        },
                      ),
                    );
                  }
                  // State: Data Kosong [cite: 348, 349]
                  else {
                    return const Text('Tidak ada data game.');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
