import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class ShopDetails extends StatefulWidget {
  final String shopname;
  final String calling;
  final String whatsapp;
  final List<String> img;
  final num rating;
  final num numRatings;
  final String offerId;
  // final String description;
  const ShopDetails({
    super.key,
    required this.shopname,
    required this.calling,
    required this.whatsapp,
    required this.offerId,
    required this.img,
    this.rating = 0,
    this.numRatings = 0,
    //  this.description = "get great deals"
  });

  @override
  State<ShopDetails> createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      Container(
        height: 50,
        child: Center(
          child: Text(widget.shopname,
              style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueAccent)),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(10.0),
        child: CarouselSlider.builder(
          itemCount: widget.img.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) =>
                  ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            // child: Image.network(_selectedItems[index].imageURL),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/loader.gif',
              image: widget.img[itemIndex],
            ),
          ),
          options: CarouselOptions(
              enableInfiniteScroll: false,
              animateToClosest: false,
              viewportFraction: 1),
        ),
      ),
      Container(
        margin: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            const Expanded(
              child: Text("get amazing deals"),
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
                            Icons.chat,
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
      ElevatedButton(
        child: const Text('Give feedback'),
        // onPressed: _showRatingDialog(context),
        onPressed: () {
          final _ratingDialog = Center(
              child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: RatingDialog(
              starSize: 20,
              title: const Text("Feedback"),
              message: const Text('Tell others what you think.'),
              submitButtonText: 'Submit',
              onCancelled: () => print('cancelled'),
              onSubmitted: (response) async {
                var res = await http
                    .post(Uri.parse('http://15.206.139.62:8000/rate'), body: {
                  "id": widget.offerId,
                  "rating": response.rating.toString()
                });
                print(res);
              },
            ),
          ));
          showDialog(context: context, builder: (context) => _ratingDialog);
        },
      ),
      Text(
        'Average rating: ${widget.rating}',
        style: const TextStyle(
            color: Colors.green, fontWeight: FontWeight.w300, fontSize: 30),
      ),
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
