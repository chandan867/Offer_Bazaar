import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:test/utils/listings.dart';
import 'package:url_launcher/url_launcher.dart';

import 'category_drop.dart';

final List<String> category_list = ['travel', 'food', 'cloth'];

final List<Map<String, dynamic>> data = [
  {
    "shop": "Abc",
    "category": "food",
    "url": "https://chandan867.github.io/Images/image1.png"
  },
  {
    "shop": "Abcd",
    "category": "travel",
    "url": "https://chandan867.github.io/Images/image2.png"
  },
  {
    "shop": "Abce",
    "category": "food",
    "url": "https://chandan867.github.io/Images/image3.jpg"
  },
  {
    "shop": "Abcf",
    "category": "cloth",
    "url": "https://chandan867.github.io/Images/image1.png"
  },
  {
    "shop": "Acgd",
    "category": "hotel",
    "url": "https://chandan867.github.io/Images/image2.png"
  },
  {
    "shop": "tyup",
    "category": "food",
    "url": "https://chandan867.github.io/Images/image3.png"
  },
];

class ListWidget extends StatefulWidget {
  List<Listings> listings;
  ListWidget({Key? key, required this.listings}) : super(key: key);
  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  List<Map<String, dynamic>> _selectedItems = [];
  late List<Listings> api_data = [];
  List<String> selected_category = [];
  @override
  void initState() {
    _selectedItems = data;
    // api_data = widget.listings;
  }

  void _showMultiSelect() async {
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    final List<String> items = [
      'food',
      'travel',
      'cloth',
    ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: items);
      },
    );

    // Update UI
    _selectedItems = [];

    if (results != null) {
      if (results.isEmpty) {
        _selectedItems = data;
      } else {
        data.forEach(
          (element) => {
            if (results.contains(element["category"]))
              {_selectedItems.add(element)}
          },
        );
      }
      // log(results.toString());

      selected_category = results;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // use this button to open the multi-select dialog
            ElevatedButton(
              onPressed: _showMultiSelect,
              child: const Text('Select Your Category'),
            ),
            const Divider(
              height: 10,
            ),
            // display selected items
            Wrap(
              children: selected_category
                  .map((e) => Chip(
                        label: Text(e),
                      ))
                  .toList(),
              spacing: 12,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext ctx, int index) {
                return Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      // error handle the image defualt
                      Image.network(_selectedItems[index]['url']),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(_selectedItems[index]['category']),
                      SizedBox(
                        height: 10,
                      ),
                      Text(widget.listings[index].name)
                      //   Text(api_data[index].title),
                    ],
                  ),
                );
              },
              itemCount: widget.listings.length,
            ),
          ],
        ),
      ),
    ));
  }
}

_launchWhatsapp(BuildContext context) async {
  var whatsapp = "+917654962025";
  var whatsappAndroid = Uri.parse("whatsapp://send?phone=$whatsapp&text=hello");
  if (await canLaunchUrl(whatsappAndroid)) {
    await launchUrl(whatsappAndroid);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("WhatsApp is not installed on the device"),
      ),
    );
  }
}

_makingPhoneCall(BuildContext context) async {
  var url = Uri.parse("tel:+919549976671");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Could not connect to call"),
      ),
    );
  }
}
