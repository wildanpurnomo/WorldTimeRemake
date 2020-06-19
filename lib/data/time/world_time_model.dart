import 'package:intl/intl.dart';

class WorldTimeModel {
  String timezone;
  String time;
  bool isDayTime;

  WorldTimeModel.fromJson(Map<String, dynamic> json) {
    timezone = json['timezone'];

    String datetime = json['datetime'];
    String offset = json['utc_offset'].substring(1, 3);

    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));
    time = DateFormat.jm().format(now);

    String meridian = time.substring(time.length - 2);
    isDayTime = meridian == 'AM' ? true : false;
  }
}