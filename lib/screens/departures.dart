import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:train_departures/providers/septa_provider.dart';

class Departures extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SeptaProvider>(context).bloc;
    return Scaffold(appBar: AppBar(title: Text('Station'),),
    body: Center(child: Text('The Body'),),);
  }
}