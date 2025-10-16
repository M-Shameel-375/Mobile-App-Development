import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List of famous Pakistani landmarks with images
    final List<Map<String, String>> landmarks = [
      {
        'name': 'Badshahi Mosque',
        'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c8/Badshahi_Mosque_front_picture.jpg/500px-Badshahi_Mosque_front_picture.jpg',
        'location': 'Lahore'
      },
      {
        'name': 'Faisal Mosque',
        'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/69/Faisal_Mosque_by_M_Ali_Mir.jpg/2560px-Faisal_Mosque_by_M_Ali_Mir.jpg',
        'location': 'Islamabad'
      },
      {
        'name': 'Lahore Fort',
        'image': 'https://upload.wikimedia.org/wikipedia/commons/9/92/Lahore_Fort.jpg',
        'location': 'Lahore'
      },
      {
        'name': 'Attabad Lake',
        'image': 'https://ychef.files.bbci.co.uk/624x351/p0lkwzv4.jpg',
        'location': 'Hunza'
      },
      {
        'name': 'Mazar-e-Quaid',
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiMDcESX8aR1TXrxu4QbYkU-HR3VUSI7b1BQ&s',
        'location': 'Karachi'
      },
      {
        'name': 'K2 Base Camp',
        'image': 'https://lp-cms-production.imgix.net/2025-03/shutterstock1630159363.jpg?auto=format,compress&q=72&fit=crop',
        'location': 'Skardu'
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 items per row
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75, // Width/Height ratio
        ),
        itemCount: landmarks.length,
        itemBuilder: (context, index) {
          final landmark = landmarks[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                // Landmark Image
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: Image.network(
                      landmark['image']!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.green[100],
                          child: Icon(Icons.photo, color: Colors.green[300], size: 50),
                        );
                      },
                    ),
                  ),
                ),

                // Landmark Information
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          landmark['name']!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.green[900],
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          landmark['location']!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green[700],
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}