import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List of Pakistani travel destinations
    final List<Map<String, String>> destinations = [
      {
        'name': 'Hunza Valley, Gilgit-Baltistan',
        'description': 'Heaven on Earth with stunning mountains and friendly people.'
      },
      {
        'name': 'Swat Valley, KPK',
        'description': 'The Switzerland of East with beautiful valleys and rivers.'
      },
      {
        'name': 'Lahore, Punjab',
        'description': 'The heart of Pakistan with rich Mughal heritage and food.'
      },
      {
        'name': 'Karachi, Sindh',
        'description': 'City of Lights with beaches, food, and vibrant culture.'
      },
      {
        'name': 'Skardu, Gilgit-Baltistan',
        'description': 'Gateway to the world\'s highest peaks including K2.'
      },
      {
        'name': 'Islamabad',
        'description': 'Capital city with modern infrastructure and Margalla Hills.'
      },
      {
        'name': 'Fairy Meadows, GB',
        'description': 'Breathtaking view of Nanga Parbat, the killer mountain.'
      },
      {
        'name': 'Murree, Punjab',
        'description': 'Popular hill station with scenic views and pleasant weather.'
      },
      {
        'name': 'Quetta, Balochistan',
        'description': 'City of fruits with beautiful mountains and unique culture.'
      },
      {
        'name': 'Neelum Valley, AJK',
        'description': 'Paradise on Earth with crystal clear rivers and lush forests.'
      },
    ];

    return ListView.builder(
      itemCount: destinations.length,
      itemBuilder: (context, index) {
        final destination = destinations[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          color: Colors.green[50],
          child: ListTile(
            leading: Icon(Icons.place, color: Colors.green[700]),
            title: Text(
              destination['name']!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.green[900],
              ),
            ),
            subtitle: Text(
              destination['description']!,
              style: const TextStyle(color: Colors.black87),
            ),
            trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.green[700]),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Exploring: ${destination['name']}'),
                  duration: const Duration(seconds: 1),
                  backgroundColor: Colors.green[700],
                ),
              );
            },
          ),
        );
      },
    );
  }
}