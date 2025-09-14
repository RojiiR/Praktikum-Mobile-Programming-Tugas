import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pemutar Musik',
      theme: ThemeData.dark(), // gunakan tema gelap
      home: Scaffold(
        appBar: AppBar(title: Text('Pemutar Musik')),
        body: Center(
          child: Text('Pemutar Musik', style: TextStyle(fontSize: 20)),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          color: Colors.black54,
          child: Row(
            children: [
              // Tombol Shuffle
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.shuffle, color: Colors.white),
                  onPressed: () {},
                ),
              ),
              // Tombol Previous
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.skip_previous, color: Colors.white),
                  onPressed: () {},
                ),
              ),
              // Tombol Play (lebih besar, pakai Flexible flex: 2)
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: IconButton(
                  icon: Icon(
                    Icons.play_circle_fill,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () {},
                ),
              ),
              // Tombol Next
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.skip_next, color: Colors.white),
                  onPressed: () {},
                ),
              ),
              // Tombol Repeat
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.repeat, color: Colors.white),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
