import 'package:flutter/material.dart';

class CardDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // Default Card
        Card(
          elevation: 4.0,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Default Card',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text('This is a basic card with default styling'),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),

        // Stadium Border Card
        Card(
          elevation: 8.0,
          shape: StadiumBorder(),
          color: Colors.blue[50],
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Stadium Border',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text('Card with stadium border shape'),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),

        // Underline Border Card
        Card(
          elevation: 6.0,
          shape: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepOrange, width: 2),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Underline Border',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text('Card with single bottom border'),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),

        // Outline Border Card
        Card(
          elevation: 10.0,
          shape: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Outline Border',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text('Card with complete border outline'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}