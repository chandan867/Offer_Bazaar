import 'dart:convert';
import 'package:http/http.dart';
import 'package:test/utils/listings.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

// class Resource<T> {
//   final String url;
//   T Function(Response response) parse;

//   Resource({required this.url, required this.parse});
// }

// class Webservice {
//   Future<T> load<T>(Resource<T> resource) async {
//     final response = await http
//         .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
//     log(jsonDecode(response.body).toString());
//     if (response.statusCode == 200) {
//       return resource.parse(response);
//     } else {
//       throw Exception('Failed to load data!');
//     }
//   }
// }

Future<List<Listings>> fetchListings() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

  if (response.statusCode == 200) {
    final List result = json.decode(response.body);
    return result.map((e) => Listings.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}
