import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WeatherPage(),
    );
  }
}

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Malang",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "25°",
              style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),

            // Bagian bawah: Minggu, Senin, Selasa
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                WeatherItem(day: "Minggu", temp: "20°C", icon: Icons.wb_sunny),
                WeatherItem(
                  day: "Senin",
                  temp: "23°C",
                  icon: Icons.cloudy_snowing,
                ),
                WeatherItem(day: "Selasa", temp: "22°C", icon: Icons.cloud),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherItem extends StatelessWidget {
  final String day;
  final String temp;
  final IconData icon;

  const WeatherItem({
    super.key,
    required this.day,
    required this.temp,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 30),
        const SizedBox(height: 4),
        Text(day),
        Text(temp),
      ],
    );
  }
}
