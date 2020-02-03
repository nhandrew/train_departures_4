import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:train_departures/models/train.dart';

class SeptaService {
  Future<List<Train>> loadStationData(String station) async {
    //Send Get Request
    var response =
        await http.get('http://www3.septa.org/hackathon/Arrivals/$station/10/');

    //Build a Train List
    var trains = List<Train>();

    try {
      //Replace Dynamic Key and Decode
      var json = convert.jsonDecode('{ "Departures" : ' +
          response.body.substring(response.body.indexOf('[')));

      var north = json['Departures'][0]['Northbound'];
      var south = json['Departures'][1]['Southbound'];
      north.forEach((train) => trains.add(Train.fromJson(train)));
      south.forEach((train) => trains.add(Train.fromJson(train)));
    } catch (error) {
      print(error);
    }

    //Sort
    trains.sort((a, b) => a.departTime.compareTo(b.departTime));

    return trains;
  }

  Future<List<String>> getStations() async {
    var output = List<String>();
    var request = await HttpClient().getUrl(Uri.parse('http://www3.septa.org/hackathon/Arrivals/station_id_name.csv'));
    var response = await request.close();

    await response.transform(convert.Utf8Decoder()).listen((fileContents) {
      convert.LineSplitter ls = convert.LineSplitter();
      List<String> lines = ls.convert(fileContents);
      lines.forEach((line) => output.add(line.split(',')[1]));
    }).asFuture();

    return output;
  }
}
