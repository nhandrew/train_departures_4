import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:train_departures/providers/septa_provider.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SeptaProvider>(context).bloc;
    return Scaffold(
      appBar: AppBar(
          title: Text('Departure Settings',
              style: Theme.of(context).textTheme.title)),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 25.0,
          ),
          StreamBuilder<String>(
            stream: bloc.station,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Container();
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Station'),
                    DropdownButton<String>(
                      value: snapshot.data,
                      onChanged: (String value) {
                        bloc.changeStation(value);
                      },
                      items: <String>[
                        'Media',
                        'Suburban Station',
                        'Bala',
                        '30th Street Station',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            }
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: StreamBuilder<int>(
              stream: bloc.count,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Container();
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Departures'),
                    DropdownButton<int>(
                      value: snapshot.data,
                      onChanged: (int value) {
                        bloc.changeCount(value);
                      },
                      items: <int>[4, 8, 10, 14, 18]
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                    )
                  ],
                );
              }
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              children: <Widget>[Text('Choose Direction')],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: StreamBuilder<List<String>>(
              stream: bloc.directions,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Container();
                var directions = snapshot.data;
                return Container(
                  child: Wrap(
                    spacing: 5.0,
                    runSpacing: 3.0,
                    children: <Widget>[
                      FilterChip(
                        label: Text('Northbound',
                            style: Theme.of(context).textTheme.body2),
                        selected: (directions.contains('N')) ? true : false,
                        onSelected: (bool value) {
                          if (value == true){
                            directions.add('N');
                            bloc.changeDirections(directions);
                          } else {
                            directions.remove(directions.firstWhere((x) => x == 'N'));
                            bloc.changeDirections(directions);
                          }
                        },
                      ),
                      FilterChip(
                        label: Text('Southbound',
                            style: Theme.of(context).textTheme.body2),
                        selected: (directions.contains('S')) ? true : false,
                        onSelected: (bool value) {
                         if (value == true){
                            directions.add('S');
                            bloc.changeDirections(directions);
                          } else {
                            directions.remove(directions.firstWhere((x) => x == 'S'));
                            bloc.changeDirections(directions);
                          }
                        },
                      )
                    ],
                  ),
                );
              }
            ),
          )
        ],
      ),
    );
  }
}
