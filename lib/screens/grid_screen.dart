import 'package:flutter/material.dart';

class GridScreen extends StatelessWidget {
  const GridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      'images/1.jpeg',
      'images/2.jpg',
      'images/3.jpg',
      'images/4.webp',
      'images/5.webp',
      'images/6.webp',
      'images/7.jpeg',
      'images/8.webp',
      'images/9.jpg',
      'images/10.jpg',
      'images/11.webp',
      'images/12.jpeg',
      'images/13.jpg',
      'images/15.jpg',
    ];
    return Scaffold(
      body: Container(
        child: GridView.builder(
            itemCount: 14,
            itemBuilder: (context, index) {
              return Card(
                elevation: 10,
                child: Center(
                  child: Image.asset(images[index]),
                ),
              );
            },
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2)),
      ),
    );
  }
}
