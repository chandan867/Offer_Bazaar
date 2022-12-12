// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'utils/listView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            title: Text("K Coupon"),
            // bottom: const TabBar(tabs: [
            //   Tab(icon: Icon(Icons.)),
            //   // Tab(
            //   //   icon: Icon(Icons.access_alarm),
            //   // )
            // ]),
          ),
          body: TabBarView(children: [
            ListWidget(const Icon(Icons.directions_bike)),
            // ListWidget(const Icon(Icons.directions_walk_rounded))
          ]),
        ),
      ),
    );
  }
}
