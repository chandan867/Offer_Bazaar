// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:test/utils/listings.dart';
import 'package:test/utils/webService.dart';
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
  late List<Listings> listings;
  //late Future<Listings> listings;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      abc();
    });
  }

  Future<void> abc() async {
    // await Webservice().load(Listings.all).then((all_listings) {
    //   listings = all_listings;
    //   setState(() {});
    // });
    await Webservice().load(Listings.all);
  }

  Widget build(BuildContext context) {
    // abc();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
          length: 1,
          child: Scaffold(
            appBar: AppBar(
              title: Text("K Coupon"),
            ),
            body: ListWidget(),
//             body: FutureBuilder<Listings>(
//   future: listings,
//   builder: (context, snapshot) {
//     if (snapshot.hasData) {
//       return Text(snapshot.data!.title);
//     } else if (snapshot.hasError) {
//       return Text('${snapshot.error}');
//     }

//     // By default, show a loading spinner.
//     return const CircularProgressIndicator();
//   },
// ),
          )
          //  body: ListWidget(listings: listings)),
          ),
    );
  }
}
