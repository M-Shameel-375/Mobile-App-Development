import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Wrapper app class (so tests work with MyApp)
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Widget Tree',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(), // Your Home widget below
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget Tree'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                // First Row with containers
                Row(
                  children: <Widget>[
                    Container(
                      color: Colors.yellow,
                      height: 40.0,
                      width: 40.0,
                    ),
                    Padding(padding: EdgeInsets.all(16.0)),
                    Expanded(
                      child: Container(
                        color: Colors.amber,
                        height: 40.0,
                        width: 40.0,
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(16.0)),
                    Container(
                      color: Colors.brown,
                      height: 40.0,
                      width: 40.0,
                    ),
                  ],
                ),

                // Space between rows
                Padding(padding: EdgeInsets.all(16.0)),

                // Second Row with Column
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          color: Colors.yellow,
                          height: 60.0,
                          width: 60.0,
                        ),
                        Padding(padding: EdgeInsets.all(16.0)),
                        Container(
                          color: Colors.amber,
                          height: 40.0,
                          width: 40.0,
                        ),
                        Padding(padding: EdgeInsets.all(16.0)),
                        Container(
                          color: Colors.brown,
                          height: 20.0,
                          width: 20.0,
                        ),
                        Divider(),

                        // Step 7: Row with CircleAvatar Stack
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.lightGreen,
                              radius: 100.0,
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    height: 100.0,
                                    width: 100.0,
                                    color: Colors.yellow,
                                  ),
                                  Container(
                                    height: 60.0,
                                    width: 60.0,
                                    color: Colors.amber,
                                  ),
                                  Container(
                                    height: 40.0,
                                    width: 40.0,
                                    color: Colors.brown,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        // Step 8: Add Divider and Text after Stack
                        Divider(),
                        Text('End of the Line'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
