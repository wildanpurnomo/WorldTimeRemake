import 'dart:convert';

import 'package:http/http.dart';

class LocationAPIProvider {
  Client client = Client();
  final baseUrl = "http://worldtimeapi.org/api";

  Future<List<dynamic>> fetchLocation() async {
    final response = await client.get("$baseUrl/timezone");

    if (response.statusCode == 200) {
      String editedResponseBody = '{ "location" : ${response.body}}';
      return jsonDecode(editedResponseBody)['location'];
    } else {
      throw Exception('Failed to load location');
    }
  }
}