import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controller for TextField
  final TextEditingController _destinationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pakistan Travel Image
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: AssetImage('assets/images/pic.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),


          const SizedBox(height: 20),

          // Welcome Message Container with Pakistan theme
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to Pakistan Travel Guide!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Discover the breathtaking beauty of Pakistan - from majestic mountains to historical landmarks. Plan your journey through the land of pure.',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // RichText for Pakistan travel slogan
          Center(
            child: RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 18, color: Colors.black87),
                children: [
                  TextSpan(text: 'Explore '),
                  TextSpan(
                    text: 'Pakistan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 22,
                    ),
                  ),
                  TextSpan(text: ' - Land of '),
                  TextSpan(
                    text: 'Pure Beauty!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00401A),
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // TextField for destination input in Pakistan
          TextField(
            controller: _destinationController,
            decoration: InputDecoration(
              labelText: 'Enter Pakistani Destination',
              hintText: 'e.g., Hunza, Swat, Lahore, Karachi',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon: const Icon(Icons.search, color: Colors.green),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green.shade700),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Buttons Row with Pakistan theme
          Row(
            children: [
              // ElevatedButton - Search
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          _destinationController.text.isEmpty
                              ? 'Exploring beautiful Pakistan!'
                              : 'Searching for ${_destinationController.text} in Pakistan',
                        ),
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.green[700],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Search Pakistan',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // TextButton - Get Tips
              Expanded(
                child: TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Getting travel tips for Pakistan!'),
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.green[700],
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.green[700],
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Travel Tips'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Additional Pakistan Info
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.shade300),
            ),
            child: const Row(
              children: [
                Icon(Icons.info, color: Colors.green),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Pakistan offers diverse landscapes: mountains, beaches, deserts, and historical sites.',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _destinationController.dispose();
    super.dispose();
  }
}