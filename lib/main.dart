import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:train_departures/providers/septa_provider.dart';
import 'package:train_departures/screens/departures.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => SeptaProvider(),
      child: MaterialApp(
        title: 'Train Departures',
        theme: ThemeData(
          accentColor: Colors.deepOrangeAccent,
          brightness: Brightness.dark,
          textTheme: TextTheme(
              body1: GoogleFonts.orbitron(
                  textStyle: TextStyle(color: Colors.cyan, fontSize: 18.0)),
              body2: GoogleFonts.openSans(
                  textStyle: TextStyle(
                      color: Colors.deepOrangeAccent, fontSize: 12.0)),
              title: GoogleFonts.orbitron(
                  textStyle: TextStyle(color: Colors.cyan, fontSize: 25.0))),
        ),
        home: Departures(),
      ),
    );
  }
}
