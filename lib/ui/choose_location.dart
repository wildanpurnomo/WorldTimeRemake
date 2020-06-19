import 'package:flutter/material.dart';
import 'package:worldtime/data/location/location_bloc.dart';
import 'package:worldtime/data/location/location_bloc_provider.dart';
import 'package:worldtime/data/time/world_time_bloc.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  LocationBloc locationBloc;

  @override
  void didChangeDependencies() {
    locationBloc = LocationBlocProvider.of(context);
    locationBloc.fetchAllLocations();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    locationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose Location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: locationBloc.getAllLocations,
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 1) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: Container(
                                height: 150.0,
                                width: 150.0,
                                color: Colors.blue[200],
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new CircularProgressIndicator(),
                                    SizedBox(height: 16.0),
                                    new Text(
                                      "Please wait",
                                      style: TextStyle(
                                        letterSpacing: 2.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                      );
                      worldTimeBloc.fetchWorldTime(snapshot.data[index].toString());
                      worldTimeBloc.getWorldTime.listen((event) {
                        event.then((value) {
                          if (value.timezone == snapshot.data[index].toString()) {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                        });
                      });
                    },
                    title: Text('${snapshot.data[index].toString()}'),
                  );
                },
              );
            } else {
              return Center(child: Text("No Data"));
            }
          } else if (snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
