import 'package:rxdart/rxdart.dart';
import 'package:worldtime/data/repository.dart';
import 'package:worldtime/data/time/world_time_model.dart';

class WorldTimeBloc {
  final repository = Repository();
  final timezone = PublishSubject<String>();
  final worldTime = BehaviorSubject<Future<WorldTimeModel>>();

  Function(String) get fetchWorldTime => timezone.sink.add;
  Stream<Future<WorldTimeModel>> get getWorldTime => worldTime.stream;

  WorldTimeBloc() {
    timezone.stream.transform(itemTransformer()).pipe(worldTime);
  }

  dispose() async {
    timezone.close();
    await worldTime.drain();
    worldTime.close();
  }

  itemTransformer() {
    return ScanStreamTransformer(
        (Future<WorldTimeModel> worldTime, String timezone, int index) {
          worldTime = repository.fetchWorldTime(timezone);
          return worldTime;
        }
    );
  }
}

final worldTimeBloc = WorldTimeBloc();