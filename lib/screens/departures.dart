import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:train_departures/models/train.dart';
import 'package:train_departures/providers/septa_provider.dart';
import 'package:train_departures/screens/settings.dart';

class Departures extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SeptaProvider>(context).bloc;
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<String>(
            stream: bloc.station,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Container();
              return Text(snapshot.data, style: Theme.of(context).textTheme.title);
            }),
        actions: <Widget>[
          FlatButton(
              child: Text('Change',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                  )),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Settings()));
              }),
        ],
      ),
      body: StreamBuilder<List<Train>>(
          stream: bloc.trains,
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            return ListView.builder(
                itemCount: snapshot.data.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _buildHeader(context);
                  } else {
                    return _buildDeparture(context, snapshot.data[index - 1]);
                  }
                });
          }),
    );
  }

  _buildHeader(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 15.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 25.0,
            ),
            Text('Departures', style: Theme.of(context).textTheme.title)
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Text('Time', style: Theme.of(context).textTheme.body2),
              flex: 1,
            ),
            Expanded(
                child: Text('Destination',
                    style: Theme.of(context).textTheme.body2),
                flex: 3),
            Expanded(
                child: Text('Track', style: Theme.of(context).textTheme.body2),
                flex: 1),
            Expanded(
                child: Text('Status', style: Theme.of(context).textTheme.body2),
                flex: 1),
          ],
        )
      ],
    );
  }

  _buildDeparture(BuildContext context, Train train) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Text(formatDate(train.departTime, [h, ':', nn]),
                  style: Theme.of(context).textTheme.body1),
              flex: 1,
            ),
            Expanded(
                child: Text(train.destination,
                    style: Theme.of(context).textTheme.body1),
                flex: 3),
            Expanded(
                child:
                    Text(train.track, style: Theme.of(context).textTheme.body1),
                flex: 1),
            Expanded(
                child: Text(train.status,
                    style: Theme.of(context).textTheme.body1),
                flex: 1),
          ],
        ),
        Divider(),
      ],
    );
  }
}
