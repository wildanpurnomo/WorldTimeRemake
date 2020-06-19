import 'package:flutter/material.dart';
import 'package:worldtime/ui/choose_location.dart';
import 'package:worldtime/ui/home.dart';

void main() =>
    runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/location': (context) => ChooseLocation(),
      },
    ));
