import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:worldtime/data/location/location_bloc_provider.dart';
import 'package:worldtime/data/time/world_time_bloc.dart';
import 'package:worldtime/data/time/world_time_model.dart';
import 'package:worldtime/ui/choose_location.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
    worldTimeBloc.fetchWorldTime("Asia/Jakarta");
  }

  @override
  void dispose() {
    super.dispose();
    worldTimeBloc.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
          stream: worldTimeBloc.getWorldTime,
          builder: (context, AsyncSnapshot<Future<WorldTimeModel>> snapshot) {
            if (snapshot.hasData) {
              return FutureBuilder(
                future: snapshot.data,
                builder: (context, AsyncSnapshot<WorldTimeModel> dataSnapshot) {
                  if (dataSnapshot.hasData) {
                    return buildHome(dataSnapshot);
                  } else {
                    return Container(
                      color: Colors.blue[900],
                      child: Center(
                        child: SpinKitFadingCube(
                          color: Colors.white,
                          size: 50.0,
                        ),
                      ),
                    );
                  }
                },
              );
            } else if (snapshot.hasError){
              return Text(snapshot.error.toString());
            } else {
              return Container(
                color: Colors.blue[900],
                child: Center(
                  child: SpinKitFadingCube(
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
              );
            }

          },
        ),
    );
  }

  Widget buildHome(AsyncSnapshot<WorldTimeModel> dataSnapshot) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage((dataSnapshot.data.isDayTime == true)
                ? 'assets/day.png'
                : 'assets/night.png'),
            fit: BoxFit.cover,
          )),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 120.0, 0.0, 0.0),
        child: SafeArea(
            child: Column(
              children: <Widget>[
                FlatButton.icon(
                  onPressed: () {
                    navigateAndDisplayLocation();
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        (dataSnapshot.data.timezone == null)
                            ? 'Error'
                            : dataSnapshot.data.timezone,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  (dataSnapshot.data.time == null) ? 'Error' : dataSnapshot.data.time,
                  style: TextStyle(
                      color: Colors.white, fontSize: 66.0, letterSpacing: 2.0),
                )
              ],
            )),
      ),
    );
  }

  navigateAndDisplayLocation() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return LocationBlocProvider(
          child: ChooseLocation(),
        );
      })
    );
  }
}
