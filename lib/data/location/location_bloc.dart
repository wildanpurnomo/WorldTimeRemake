import 'package:rxdart/rxdart.dart';
import 'package:worldtime/data/repository.dart';

class LocationBloc {
  final repository = Repository();
  final locationFetcher = PublishSubject<List<dynamic>>();

  Stream<List<dynamic>> get getAllLocations => locationFetcher.stream;

  fetchAllLocations() async {
    locationFetcher.sink.add(await repository.fetchLocations());
  }

  dispose() {
    locationFetcher.close();
  }
}