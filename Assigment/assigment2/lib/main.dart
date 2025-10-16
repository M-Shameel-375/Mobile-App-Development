import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/list_screen.dart';
import 'screens/about_screen.dart';

void main() {
  runApp(const PakistanTravelGuideApp());
}

class PakistanTravelGuideApp extends StatelessWidget {
  const PakistanTravelGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pakistan Travel Guide',
      debugShowCheckedModeBanner: false, // Add this line to remove debug banner
      theme: ThemeData(
        primarySwatch: Colors.green,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
          accentColor: Colors.white,
        ),
      ),
      home: const MainScreen(),
    );
  }
}
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List of screens for navigation
  final List<Widget> _screens = [
    const HomeScreen(),
    const ListScreen(),
    const AboutScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with Pakistan-themed colors
      appBar: AppBar(
        title: const Text(
          'Pakistan Travel Guide',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
      ),

      // SafeArea to avoid system UI
      body: SafeArea(
        child: _screens[_selectedIndex],
      ),

      // Bottom Navigation Bar with Pakistan theme
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.green[700],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place),
            label: 'Destinations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.landscape),
            label: 'Landmarks',
          ),
        ],
      ),
    );
  }
}