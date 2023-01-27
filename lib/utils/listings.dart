import 'dart:convert';

import 'package:test/utils/webService.dart';

class Listings {
  final String name;
  final String category;
  final String offer;
  final List<String> imageURL;
  final String calling_number;
  final String whatsapp_number;
  final String offer_id;
  final num rating;
  final num num_rating;
  // final String description;

  const Listings(
      {required this.name,
      required this.category,
      required this.offer,
      required this.imageURL,
      required this.calling_number,
      required this.whatsapp_number,
      required this.offer_id,
      required this.rating,
      //   required this.description;
      required this.num_rating});

  factory Listings.fromJson(Map<String, dynamic> json) {
    return Listings(
        name: json['name'],
        category: json['category'],
        offer: json['offer'],
        imageURL: json['imageURL'].cast<String>(),
        whatsapp_number: json['whatsapp_number'],
        calling_number: json['calling_number'],
        offer_id: json['_id'],
        rating: json['rating'],
        num_rating: json['num_rating']);
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
    data['offer_id'] = offer_id;
    data['rating'] = rating;
    data['num_rating'] = num_rating;
    return data;
  }
}
