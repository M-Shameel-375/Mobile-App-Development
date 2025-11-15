import 'package:flutter/material.dart';

class CustomScrollViewDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // App Bar with parallax effect
        SliverAppBar(
          expandedHeight: 200.0,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Custom Scroll View'),
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.purple, Colors.blue],
                ),
              ),
            ),
          ),
        ),

        // Header section
        SliverToBoxAdapter(
          child: Container(
            color: Colors.grey[100],
            padding: EdgeInsets.all(16),
            child: Text(
              'Featured Content',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        // Grid section
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.2,
          ),
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              return Card(
                elevation: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, size: 40, color: Colors.amber),
                    SizedBox(height: 8),
                    Text('Feature ${index + 1}'),
                  ],
                ),
              );
            },
            childCount: 4,
          ),
        ),

        // List section header
        SliverToBoxAdapter(
          child: Container(
            color: Colors.grey[100],
            padding: EdgeInsets.all(16),
            child: Text(
              'Items List',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        // List section
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  title: Text('List Item ${index + 1}'),
                  subtitle: Text('Description for item ${index + 1}'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              );
            },
            childCount: 10,
          ),
        ),

        // Another grid section
        SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 120,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              return Card(
                color: Colors.green[50],
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle, color: Colors.green),
                      Text('Done'),
                    ],
                  ),
                ),
              );
            },
            childCount: 6,
          ),
        ),
      ],
    );
  }
}