import 'package:flutter/material.dart';
import 'package:game_app/viewmodel/fetchgame.dart';
import 'package:game_app/model/detailgame.dart';
import 'package:readmore/readmore.dart'; // Untuk deskripsi yang dapat di-expand

// Widget untuk menampilkan setiap item screenshot secara horizontal [cite: 501]
SizedBox _itemList(String url) {
  return SizedBox(
    width: 250,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(url, fit: BoxFit.cover),
    ),
  );
}

// Widget untuk menampilkan satu baris requirement (OS, Processor, dll) [cite: 511, 513]
Row _requirementRow(String title, String value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        flex: 3,
        child: Text(
          title,
          style: TextStyle(color: Colors.black54.withOpacity(0.8)),
        ),
      ),
      Expanded(
        flex: 1,
        child: Text(
          ':',
          style: TextStyle(color: Colors.black54.withOpacity(0.8)),
        ),
      ),
      Expanded(
        flex: 8,
        child: Text(
          value,
          style: TextStyle(color: Colors.black54.withOpacity(0.8)),
        ),
      ),
    ],
  );
}

class Detail extends StatelessWidget {
  final int gameTerpilih; // Menerima ID game dari halaman Home [cite: 392, 396]
  const Detail({super.key, required this.gameTerpilih});

  // Method untuk mengambil data detail game dari API [cite: 481]
  Future<DetailGame> fetchData() async {
    final jsonData = await fetchDataFromAPI(gameTerpilih); // Ambil Map JSON
    // Konversi Map JSON ke objek Dart DetailGame [cite: 488]
    return DetailGame.fromJson(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent.shade400,
      // FutureBuilder untuk menangani data asinkron [cite: 493]
      body: FutureBuilder<DetailGame>(
        future: fetchData(),
        builder: (context, snapshot) {
          // State: Loading [cite: 494]
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // State: Error [cite: 495]
          else if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          }
          // State: Data tidak tersedia
          else if (!snapshot.hasData) {
            return const Center(child: Text('Data tidak tersedia'));
          }
          // State: Data Tersedia
          else {
            final game = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  // 1. Header (Thumbnail dan Back Button) [cite: 497]
                  SizedBox(
                    width: double.infinity,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                          child: Image.network(
                            game.thumbnail,
                            fit: BoxFit.cover,
                            height: 300,
                          ),
                        ),
                        // Back Button [cite: 498]
                        Positioned(
                          top: 25,
                          left: 10,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context); // Kembali ke halaman Home
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.8),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 2. Minimum System Requirements [cite: 508]
                  if (game.minimumSystemRequirements != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Minimum System Requirements',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54.withOpacity(0.8),
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Memanggil _requirementRow() untuk setiap baris
                            _requirementRow(
                              'OS',
                              game.minimumSystemRequirements!.os,
                            ),
                            _requirementRow(
                              'Processor',
                              game.minimumSystemRequirements!.processor,
                            ),
                            _requirementRow(
                              'Memory',
                              game.minimumSystemRequirements!.memory,
                            ),
                            _requirementRow(
                              'Graphics',
                              game.minimumSystemRequirements!.graphics,
                            ),
                            _requirementRow(
                              'Storage',
                              game.minimumSystemRequirements!.storage,
                            ),
                          ],
                        ),
                      ),
                    ),

                  // 3. Screenshots (ListView Horizontal) [cite: 518]
                  if (game.screenshots.isNotEmpty)
                    Container(
                      height: 200,
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10,
                      ),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: game.screenshots.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 15),
                        itemBuilder: (context, index) {
                          return _itemList(game.screenshots[index].image);
                        },
                      ),
                    ),

                  // 4. Deskripsi (ReadMoreText) [cite: 520, 521]
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    child: ReadMoreText(
                      game.description,
                      trimLines: 4, // Tampilkan 4 baris awal
                      colorClickableText: Colors.amberAccent.shade400,
                      trimMode: TrimMode.Line,
                      style: TextStyle(
                        color: Colors.black54.withOpacity(0.8),
                        height: 1.5,
                      ),
                      trimCollapsedText: '...more',
                      trimExpandedText: ' less',
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
