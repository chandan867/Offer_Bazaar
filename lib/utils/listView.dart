import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ListWidget extends StatelessWidget {
  Icon ic = const Icon(Icons.abc);
  ListWidget(this.ic, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> list = [
      "https://chandan867.github.io/Images/image1.png",
      "https://chandan867.github.io/Images/image2.png",
      "https://chandan867.github.io/Images/image3.jpg",
      "https://chandan867.github.io/Images/image1.png",
      "https://chandan867.github.io/Images/image2.png",
      "https://chandan867.github.io/Images/image3.jpg",
      "https://chandan867.github.io/Images/image1.png",
      "https://chandan867.github.io/Images/image2.png",
      "https://chandan867.github.io/Images/image3.jpg",
    ];
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Image.network(list[index]),
              Container(
                padding: const EdgeInsets.all(6),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceEvenly, // use whichever suits your need
                children: <Widget>[
                  InkWell(
                      child: const Icon(
                        Icons.whatsapp,
                        color: Color.fromRGBO(7, 94, 84, 15),
                        //color: Color.fromARGB(255, 252, 87, 76),
                        size: 40,
                      ),
                      onTap: () async {
                        _launchWhatsapp(context);
                      }),
                  InkWell(
                      child: const Icon(
                        Icons.call,
                        color: Color.fromRGBO(0, 0, 255, 0.5),
                        size: 40,
                      ),
                      onTap: () async {
                        _makingPhoneCall(context);
                      })
                ],
              ),
            ],
          ),
        );
      },
    );
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
