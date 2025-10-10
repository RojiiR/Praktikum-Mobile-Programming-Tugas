import 'dart:convert'; // Untuk json.decode [cite: 358]
import 'package:game_app/model/game.dart'; // Import model Game
import 'package:http/http.dart' as http; // Import paket http [cite: 358]

// Fungsi untuk mengambil daftar game dari API
Future<List<Game>> fetchGames() async {
  // Panggil API freetogame.com [cite: 358]
  final response = await http.get(
    Uri.parse('https://www.freetogame.com/api/games'),
  );

  if (response.statusCode == 200) {
    // Ubah JSON string menjadi List dinamis [cite: 359]
    final List<dynamic> jsonData = json.decode(response.body);
    // Konversi setiap elemen JSON menjadi objek Game [cite: 360]
    return jsonData.map((item) => Game.fromJson(item)).toList();
  } else {
    // Lempar exception jika gagal mengambil data
    throw Exception('Gagal mengambil data game');
  }
}

// Fungsi untuk mengambil data detail game berdasarkan ID (akan digunakan nanti)
Future<Map<String, dynamic>> fetchDataFromAPI(int idGame) async {
  final response = await http.get(
    Uri.parse('https://www.freetogame.com/api/game?id=$idGame'),
  );

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    if (jsonData != null && jsonData is Map<String, dynamic>) {
      return jsonData; // Kembalikan data Map JSON
    } else {
      throw Exception('Data dari API tidak sesuai dengan yang diharapkan');
    }
  } else {
    throw Exception('Gagal mengambil data dari API');
  }
}
