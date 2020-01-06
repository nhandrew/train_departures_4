class Train{
  final String direction;
  final String destination;
  final String status;
  final DateTime departTime;
  final String track;

  Train({
    this.departTime,
    this.destination,
    this.direction,
    this.status,
    this.track
  });

  Train.fromJson(Map<dynamic, dynamic> parsedJson)
    : direction = parsedJson['direction'],
    destination = parsedJson['destination'],
    status = parsedJson['status'],
    departTime = DateTime.parse(parsedJson['depart_time']),
    track = parsedJson['track'];
}