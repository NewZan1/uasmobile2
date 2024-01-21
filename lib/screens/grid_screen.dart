import 'package:flutter/material.dart';

class GridScreen extends StatelessWidget {
  const GridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      'images/1.jpeg',
      'images/2.jpg',
      'images/3.jpg',
    ];
    return Scaffold(
      body: Container(
        child: GridView.builder(
            itemCount: 3,
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
