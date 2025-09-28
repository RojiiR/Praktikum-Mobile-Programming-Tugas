import 'package:flutter/material.dart';
import 'tujuan.dart';
import 'screen_arguments.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final game = ScreenArguments(
      'Forza Motorsport 6: Apex',
      'Genre: Racing\nPlatform: Windows\nPublisher: Microsoft\nRelease: 2015-09-15',
      'Forza Motorsport 6: Apex is a free-to-play multiplayer online racing game '
          'that comes from Microsoft. It offers over 450 cars and 26 tracks, '
          'featuring some of the most realistic racing experiences available on PC.',
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Halaman Home')),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, Tujuan.routeName, arguments: game);
          },
          child: Card(
            elevation: 8,
            margin: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Gambar thumbnail game
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.network(
                    'https://www.freetogame.com/g/10/thumbnail.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Text(
                        game.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        game.subtitle,
                        style: const TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
