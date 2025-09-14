import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Row and Column',
      home: Scaffold(
        appBar: AppBar(title: Text('Row and Column')),
        body: Center(
          // Grid 2x2 menggunakan kombinasi Row & Column
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KotakBiruJempol(color: Colors.blue, label: "Kotak 1 ini bro"),
                  SizedBox(width: 20),
                  KotakBiruJempol(
                    color: Colors.green,
                    label: "Kotak 2 ini cuy",
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KotakBiruJempol(
                    color: Colors.orange,
                    label: "Kotak 3 ini ges",
                  ),
                  SizedBox(width: 20),
                  KotakBiruJempol(
                    color: Colors.purple,
                    label: "Kotak 4 ini bolo",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class KotakBiruJempol extends StatelessWidget {
  final Color color;
  final String label;

  KotakBiruJempol({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.favorite, // ganti jadi ikon hati
            color: Colors.red, // warna merah
            size: 40,
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
