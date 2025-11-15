import 'package:flutter/material.dart';

class GridViewDemo extends StatelessWidget {
  final List<IconData> icons = [
    Icons.home, Icons.work, Icons.school, Icons.shopping_cart,
    Icons.favorite, Icons.star, Icons.music_note, Icons.movie,
    Icons.sports_basketball, Icons.restaurant, Icons.beach_access,
    Icons.directions_bike, Icons.flight, Icons.hotel, Icons.camera_alt,
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: icons.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          color: Colors.blue[50],
          child: InkWell(
            onTap: () {
              print('Tapped on grid item $index');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icons[index],
                  size: 40,
                  color: Colors.blue,
                ),
                SizedBox(height: 8),
                Text(
                  'Item ${index + 1}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Grid',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}