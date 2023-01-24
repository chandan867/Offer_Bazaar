import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopDetails extends StatefulWidget {
  final String shopname;
  final String calling;
  final String whatsapp;
  final String img;
  const ShopDetails(
      {super.key,
      required this.shopname,
      required this.calling,
      required this.whatsapp,
      required this.img});

  @override
  State<ShopDetails> createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      const Text("welcome to ",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
      Text(widget.shopname,
          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),
      Image.network(widget.img),
      Container(
        margin: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            const Expanded(
              child: Text(
                  'This shop is offering some great products at an unmatched price. Get the best deals'),
            ),
            Column(
              children: [
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () => _launchWhatsapp(context, widget.whatsapp),
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
                    onPressed: () => _makingPhoneCall(context, widget.calling),
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
      ),
      const Text("Ratings",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w400,
            color: Colors.blue,
          )),
      RatingBar.builder(
        initialRating: 4,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
          print(rating);
        },
      )
    ])));
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
