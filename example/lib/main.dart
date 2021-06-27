import 'package:color_animating_list_view/color_animating_list_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '18 Bytes',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColorAnimatingListView(
        children: [
          Column(
            children: [
              SizedBox(height: 50),
              Image.asset('images/anime.gif'),
              SizedBox(height: 500),
              Image.asset('images/anime.gif'),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 500),
              Image.asset('images/anime.gif'),
              SizedBox(height: 500),
              Image.asset('images/anime.gif'),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 500),
              Image.asset('images/anime.gif'),
              SizedBox(height: 50),
            ],
          )
        ],
        colors: [Colors.yellowAccent, Colors.lightBlue, Colors.pinkAccent],
      ),
    );
  }
}
