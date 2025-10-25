import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ✅ Changed to white
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // ✅ Black icon for contrast
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black), // ✅ Black title
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 220,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF1DB954), Colors.white], // ✅ Green to white gradient
              ),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/pic.png'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Muhammad Shameel',
                    style: TextStyle(
                      color: Colors.black, // ✅ Changed to black
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'mshameel946@gmail.com',
                    style: TextStyle(
                      color: Colors.black54, // ✅ Softer text color
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'FAVORITE SONGS',
                  style: TextStyle(
                    color: Colors.black54, // ✅ Adjusted
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _songItem('Pasoori', 'Ali Sethi & Shae Gill', '3:20'),
                _songItem('Tum Hi Ho', 'Arijit Singh', '3:35'),
                _songItem('Afreen Afreen', 'Rahat Fateh Ali Khan', '4:10'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🎵 Song Item Widget
  Widget _songItem(String title, String artist, String duration) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200, // ✅ Light background for white theme
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF1DB954),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(Icons.music_note, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black, // ✅ Text color black
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  artist,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Text(
            duration,
            style: const TextStyle(
              color: Colors.black54,
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite, color: Color(0xFF1DB954)),
          ),
        ],
      ),
    );
  }
}
