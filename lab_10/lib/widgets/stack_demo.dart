import 'package:flutter/material.dart';

class StackDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _buildStackExample1(),
        SizedBox(height: 20),
        _buildStackExample2(),
        SizedBox(height: 20),
        _buildStackExample3(),
      ],
    );
  }

  Widget _buildStackExample1() {
    return Container(
      height: 200,
      child: Stack(
        children: [
          // Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue, Colors.purple],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          // Content
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Basic Stack',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'With positioned widgets',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          // Top right badge
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'NEW',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStackExample2() {
    return Container(
      height: 180,
      child: Stack(
        children: [
          // Background image placeholder
          Container(
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          // Avatar
          Positioned(
            bottom: 16,
            left: 16,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.green,
              child: Icon(Icons.person, size: 30, color: Colors.white),
            ),
          ),
          // Text content
          Positioned(
            bottom: 80,
            left: 16,
            right: 16,
            child: Text(
              'User Profile Stack',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
          ),
          // Favorite icon with fractional translation
          Positioned(
            top: -10,
            right: -10,
            child: FractionalTranslation(
              translation: Offset(0.3, -0.3),
              child: CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(Icons.favorite, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStackExample3() {
    return Container(
      height: 150,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background circles
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.orange[100],
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.orange[200],
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.orange[400],
              shape: BoxShape.circle,
            ),
          ),
          // Center text
          Text(
            'Centered\nStack',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}