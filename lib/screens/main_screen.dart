import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:uasmobile2/screens/crud_screen.dart';
import 'package:uasmobile2/screens/dashboard_screen.dart';
import 'package:uasmobile2/screens/grid_screen.dart';
import 'package:uasmobile2/screens/list_screen.dart';
import 'package:uasmobile2/screens/profile_screen.dart';
import 'package:uasmobile2/services/database_services.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final DatabaseService _databaseService = DatabaseService();
  int _index = 0;
  final List<Widget> _screens = [
    const Dashboard(),
    const GridScreen(),
    const ListScreen(),
    const CrudScreen(),
    const Profile()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Arsenal App')),
      body: _screens[_index],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _index,
        height: 60,
        items: const [
          Icon(Icons.home, size: 30),
          Icon(Icons.grid_view, size: 30),
          Icon(Icons.search, size: 30),
          Icon(Icons.add, size: 30),
          Icon(Icons.perm_identity, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.blue,
        backgroundColor: Colors.black,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
    );
  }
}
