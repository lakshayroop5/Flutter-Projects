class Ride {
  final String id;
  String startImage;
  String endImage;
  double distance;
  String time;
  DateTime startTime;
  DateTime endTime;
  double avgSpeed;
  UserLocation startLocation;
  UserLocation endLocation;

  Ride({
    required this.id,
    required this.startImage,
    required this.endImage,
    required this.distance,
    required this.time,
    required this.startTime,
    required this.endTime,
    required this.avgSpeed,
    required this.startLocation,
    required this.endLocation,
  });
}

class UserLocation {
  double latitude;
  double longitude;

  UserLocation(this.latitude, this.longitude);
}
