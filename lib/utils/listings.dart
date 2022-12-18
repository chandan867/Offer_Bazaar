import 'dart:convert';

import 'package:test/utils/webService.dart';

class Listings {
  final String name;
  final String category;
  final String offer;
  final String imageURL;
  final String calling_number;
  final String whatsapp_number;

  const Listings(
      {required this.name,
      required this.category,
      required this.offer,
      required this.imageURL,
      required this.calling_number,
      required this.whatsapp_number});

  factory Listings.fromJson(Map<String, dynamic> json) {
    return Listings(
        name: json['name'],
        category: json['category'],
        offer: json['offer'],
        imageURL: json['imageURL'],
        whatsapp_number: json['whatsapp_number'],
        calling_number: json['calling_number']);
  }
  // static Resource<List<Listings>> get all {
  //   return Resource(
  //       url: 'abc',
  //       parse: (response) {
  //         final result = json.decode(response.body);
  //         Iterable list = result;
  //         return list.map((model) => Listings.fromJson(model)).toList();
  //       });
  // }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['category'] = category;
    data['offer'] = offer;
    data['imageURL'] = imageURL;
    data['whatsapp_number'] = whatsapp_number;
    data['calling_number'] = calling_number;
    return data;
  }
}
