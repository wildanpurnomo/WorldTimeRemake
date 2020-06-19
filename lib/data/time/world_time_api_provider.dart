import 'dart:convert';

import 'package:http/http.dart';
import 'package:worldtime/data/time/world_time_model.dart';

class WorldTimeApiProvider {
  Client client = Client();
  final baseUrl = "http://worldtimeapi.org/api";

  Future<WorldTimeModel> fetchWorldTime(String timezone) async {
    final response = await client.get("$baseUrl/timezone/$timezone");

    if (response.statusCode == 200) {
      return WorldTimeModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load WorldTime');
    }
  }
}