import 'package:flutter/material.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  // Pages for bottom navigation
  final List<Widget> _pages = [
    const HomeContent(), // Your existing home content
    const SearchPage(),
    const LibraryPage(),
    const ProfilePage(),
  ];

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF1DB954),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Your existing home content as a separate widget
class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _homeAppBar(),
          _homeTopCard(),
          _tabs(),
          SizedBox(
            height: 260,
            child: TabBarView(
              controller: _tabController,
              children: [
                _newsSongs(),
                _videosTab(),
                _artistsTab(),
                _podcastsTab(),
              ],
            ),
          ),
          _playList()
        ],
      ),
    );
  }

  Widget _homeAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: const Icon(Icons.menu, color: Colors.black),
      title: Image.asset(
        'assets/images/logo light.png',
        width: 180,
        fit: BoxFit.contain,
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen())
            );
          },
          icon: const Icon(Icons.person, color: Colors.black),
        ),
      ],
    );
  }

  Widget _homeTopCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 140,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1DB954), Color(0xFFE5E5E5)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 16,
            bottom: 10,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/home_artist.png',
                width: 100,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Continue listening to your favorites',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        indicatorColor: const Color(0xFF1DB954),
        tabs: const [
          Tab(text: 'News'),
          Tab(text: 'Videos'),
          Tab(text: 'Artists'),
          Tab(text: 'Podcasts'),
        ],
      ),
    );
  }

  Widget _newsSongs() {
    return ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(16),
      children: [
        _songCard(
          'Pasoori',
          'Ali Sethi & Shae Gill',
          'https://c.files.bbci.co.uk/2DE6/production/_124905711_11.jpg',
        ),
        _songCard(
          'Tum Hi Ho',
          'Arijit Singh',
          'https://c.saavncdn.com/674/Arijit-Singh-Tum-Hi-Ho-2014-500x500.jpg',
        ),
        _songCard(
          'Afreen Afreen',
          'Rahat Fateh Ali Khan',
          'https://m.media-amazon.com/images/M/MV5BM2RjOGFjMTktMDhmOS00ODA5LWEwMjctMzZhNWE0ODJlZjliXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
        ),
      ],
    );
  }

  Widget _songCard(String title, String artist, String imageUrl) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            artist,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _videosTab() {
    return ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(16),
      children: [
        _songCard(
          'Bekhayali (Live)',
          'Arijit Singh',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVsgVzsipAgd5N-mFIwHDKytr4I2aRDM5dsg&s',
        ),
        _songCard(
          'Tera Woh Pyar (Coke Studio)',
          'Momina Mustehsan & Asim Azhar',
          'https://images.genius.com/65bda6897dc52dd57f0d4f0d160bb08e.500x500x1.jpg',
        ),
        _songCard(
          'Apna Bana Le (Studio)',
          'Arijit Singh',
          'https://i.scdn.co/image/ab67616d00001e0247442fa26ba11681ac98f2f4',
        ),
      ],
    );
  }

  Widget _artistsTab() {
    return ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(16),
      children: [
        _songCard(
          'Atif Aslam',
          'Pakistani Pop Singer',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9g09KO3DRQCoXBF9DhgNMI-7pMCvtlxhtiA&s',
        ),
        _songCard(
          'Arijit Singh',
          'Indian Playback Singer',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQEaO9oNwP0hT6rCxrP1_xtB2Q_ORBTsB3cmw&s',
        ),
        _songCard(
          'Rahat Fateh Ali Khan',
          'Qawwali & Playback Singer',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSheQYOiCtfBhKxF-BD4yANahPxJ3-qq24i_g&s',
        ),
      ],
    );
  }

  Widget _podcastsTab() {
    return ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(16),
      children: [
        _songCard(
          'Coke Studio Stories',
          'Behind Pakistani Music',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4_GUnTprXWx5g5snWp_JMkeKrhRcOsb0dYw&s',
        ),
        _songCard(
          'Bollywood Beats',
          'Hindi Music Discussions',
          'https://c.saavncdn.com/editorial/logo/FreestyleBollywoodBeats_20200821064521.jpg',
        ),
        _songCard(
          'Punjabi Vibes',
          'Folk & Modern Punjabi Songs',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7soOp6RJ_vKWbh_urFoXhsh2c0DhzU0o8Qg&s',
        ),
      ],
    );
  }

  Widget _playList() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Made For You',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              _playlistItem('Discover Weekly', 'Your weekly mixtape'),
              _playlistItem('Release Radar', 'Catch the latest releases'),
              _playlistItem('Daily Mix 1', 'Post Malone, Drake and more'),
              _playlistItem('Chill Lo-Fi', 'Relaxing beats to study to'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _playlistItem(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
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
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.play_arrow, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

// Other pages for bottom navigation
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Search',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: const Center(
        child: Text(
          'Search Page - Coming Soon',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Your Library',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: const Center(
        child: Text(
          'Library Page - Coming Soon',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileScreen();
  }
}