import 'dart:convert';

import 'package:test/utils/webService.dart';

class Listings {
  final String title;
  final String url;

  const Listings({
    required this.title,
    required this.url,
  });

  factory Listings.fromJson(Map<String, dynamic> json) {
    return Listings(
      url: json['url'],
      title: json['title'],
    );
  }
  static Resource<List<Listings>> get all {
    return Resource(
        url: 'abc',
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result;
          return list.map((model) => Listings.fromJson(model)).toList();
        });
  }
}
