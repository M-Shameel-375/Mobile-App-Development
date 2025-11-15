import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../widgets/card_demo.dart';
import '../widgets/listview_demo.dart';
import '../widgets/gridview_demo.dart';
import '../widgets/stack_demo.dart';
import '../widgets/custom_scrollview_demo.dart';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Scrolling Lists & Effects'),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Card'),
              Tab(text: 'ListView'),
              Tab(text: 'GridView'),
              Tab(text: 'Stack'),
              Tab(text: 'CustomScrollView'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CardDemo(),
            ListViewDemo(),
            GridViewDemo(),
            StackDemo(),
            CustomScrollViewDemo(),
          ],
        ),
      ),
    );
  }
}