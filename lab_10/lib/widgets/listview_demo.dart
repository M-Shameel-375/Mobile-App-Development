import 'package:flutter/material.dart';

class ListViewDemo extends StatelessWidget {
  final List<String> items = List.generate(20, (index) => 'Item ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Card(
            elevation: 8.0,
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'LISTVIEW HEADER',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('This is a header card for the list'),
                ],
              ),
            ),
          );
        } else if (index >= 1 && index <= 3) {
          // Cards with ListTiles
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: ListTile(
              leading: Icon(
                Icons.flight,
                color: Colors.blue,
                size: 36,
              ),
              title: Text('Airplane ${index + 1}'),
              subtitle: Text('Travel destination'),
              trailing: Text('${index * 15}%'),
              onTap: () {
                print('Tapped on Airplane ${index + 1}');
              },
            ),
          );
        } else {
          // Regular ListTiles
          return ListTile(
            leading: Icon(
              Icons.directions_car,
              color: Colors.green,
              size: 36,
            ),
            title: Text('Car ${index + 1}'),
            subtitle: Text('Vehicle type'),
            trailing: (index % 2 == 0)
                ? Icon(Icons.bookmark_border)
                : Icon(Icons.bookmark, color: Colors.red),
            onTap: () {
              print('Tapped on Car ${index + 1}');
            },
          );
        }
      },
    );
  }
}