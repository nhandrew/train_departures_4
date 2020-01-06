import 'package:flutter/material.dart';
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
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Departures(),
      ),
    );
  }
}

