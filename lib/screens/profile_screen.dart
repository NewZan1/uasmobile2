import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 75, backgroundImage: AssetImage("images/arsenal.jpg")),
            SizedBox(height: 25),
            Center(
              child: Text("Fauzan Azmi Fadhilah",
                  style: const TextStyle(fontSize: 20)),
            ),
            Center(
                child:
                    Text("21552011130", style: const TextStyle(fontSize: 20))),
            Center(
                child: Text("TIF RP 221 PA",
                    style: const TextStyle(fontSize: 20))),
          ],
        ),
      ),
    );
  }
}
