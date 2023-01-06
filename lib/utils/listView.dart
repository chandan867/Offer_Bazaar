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
  // List<Map<String, dynamic>> _selectedItems = [];
  List<Listings> _selectedItems = [];
  // late List<Listings> api_data = [];
  List<String> selected_category = [];
  @override
  void initState() {
    _selectedItems = widget.listings;
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
        _selectedItems = widget.listings;
      } else {
        widget.listings.forEach(
          (element) => {
            if (results.contains(element.category))
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
                return Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular((10.0))),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 8.0,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        // child: Image.network(_selectedItems[index].imageURL),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/loader.gif',
                          image: _selectedItems[index].imageURL,
                        ),
                      ),
                      // Image.network(_selectedItems[index].imageURL,),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          _selectedItems[index].name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          "${_selectedItems[index].offer}  off",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 150,
                            child: ElevatedButton(
                              onPressed: () => _launchWhatsapp(context,
                                  _selectedItems[index].whatsapp_number),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.green)),
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.whatsapp,
                                      color: Color.fromRGBO(7, 94, 84, 15),
                                      size: 30,
                                    ),
                                    Text('WhatsApp')
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            child: ElevatedButton(
                              onPressed: () => _makingPhoneCall(context,
                                  _selectedItems[index].calling_number),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.blue)),
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.call,
                                      color: Color.fromRGBO(0, 0, 255, 0.5),
                                      size: 30,
                                    ),
                                    Text('Call')
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                    ],
                  ),
                );
              },
              itemCount: _selectedItems.length,
            ),
          ],
        ),
      ),
    ));
  }
}

_launchWhatsapp(BuildContext context, String number) async {
  // var whatsapp = "+91" + number;
  var whatsappUrl = "whatsapp://send?phone=${"+91$number"}";
  // var whatsappAndroid = Uri.parse("whatsapp://send?phone=$whatsapp&text=hello");
  await launchUrl(Uri.parse(whatsappUrl));
  // if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
  //   await launchUrl(Uri.parse(whatsappUrl));
  // } else {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(
  //       content: Text("WhatsApp is not installed on the device"),
  //     ),
  //   );
  // }
}

_makingPhoneCall(BuildContext context, String number) async {
  var url = Uri.parse("tel:+91$number");
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
 // // return Padding(
                //   padding: EdgeInsets.all(20),
                //   child: Column(
                //     children: <Widget>[
                //       // error handle the image defualt
                //       Image.network(_selectedItems[index].imageURL),
                //       // Image.network(widget.listings[index].imageURL),
                //       const SizedBox(
                //         height: 10,
                //       ),
                //       // Text(widget.listings[index].category),

                      // Text(_selectedItems[index].name),
                //       const SizedBox(
                //         height: 10,
                //       ),
                //       Text(_selectedItems[index].offer),
                //       const SizedBox(
                //         height: 10,
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment
                //             .spaceEvenly, // use whichever suits your need
                //         children: <Widget>[
                //           InkWell(
                //               child: const Icon(
                //                 Icons.whatsapp,
                //                 color: Color.fromRGBO(7, 94, 84, 15),
                //                 //color: Color.fromARGB(255, 252, 87, 76),
                //                 size: 40,
                //               ),
                //               onTap: () async {
                //                 _launchWhatsapp(context,
                //                     _selectedItems[index].whatsapp_number);
                //               }),
                //           InkWell(
                //               child: const Icon(
                                // Icons.call,
                                // color: Color.fromRGBO(0, 0, 255, 0.5),
                                // size: 40,
                //               ),
                //               onTap: () async {
                //                 _makingPhoneCall(context,
                //                     _selectedItems[index].calling_number);
                //               })
                //         ],
                //       ),
                //       //   Text(api_data[index].title),
                //       const SizedBox(
                //         height: 10,
                //       ),
                //       const Divider(
                //         height: 5,
                //       ),
                //     ],
                //   ),
                // );
                       

                     