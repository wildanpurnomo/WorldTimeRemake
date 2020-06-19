import 'package:flutter/cupertino.dart';
import 'package:worldtime/data/location/location_bloc.dart';

class LocationBlocProvider extends InheritedWidget {
  final LocationBloc bloc;

  LocationBlocProvider({Key key, Widget child})
      : bloc = LocationBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static LocationBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<LocationBlocProvider>()
        .bloc;
  }
}
