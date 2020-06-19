

import 'package:worldtime/data/location/location_api_provider.dart';
import 'package:worldtime/data/time/world_time_api_provider.dart';
import 'package:worldtime/data/time/world_time_model.dart';

class Repository {
  final worldTimeAPIProvider = WorldTimeApiProvider();
  final locationAPIProvider = LocationAPIProvider();

  Future<WorldTimeModel> fetchWorldTime(String timezone) =>
      worldTimeAPIProvider.fetchWorldTime(timezone);

  Future<List<dynamic>> fetchLocations() => locationAPIProvider.fetchLocation();
}
