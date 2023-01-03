import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:urban_rider/models/ride.dart';

class LocationTrackingPage extends StatefulWidget {
  static const routeName = '/location-tracking';
  const LocationTrackingPage({Key? key}) : super(key: key);

  @override
  State<LocationTrackingPage> createState() => LocationTrackingPageState();
}

class LocationTrackingPageState extends State<LocationTrackingPage> {
  late Ride ride;
  bool _isInit = true;
  final Completer<GoogleMapController> _controller = Completer();
  Duration duration = const Duration();
  Timer? timer;
  double distanceTravelled = 0.0;

  // static const LatLng sourceLocation = LatLng(37.4221, -122.0841);
  // static const LatLng destination = LatLng(37.4116, -122.0713);

  List<LatLng> polylineCoordinates = [];

  late StreamSubscription<LocationData> locationSubscription;
  LatLng? sourceLocation;
  LocationData? currentLocation;
  LocationData? previousLocation;
  DateTime currentTime = DateTime.now();
  DateTime previousTime = DateTime.now();

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then((location) {
      ride.startLocation.latitude = location.latitude!;
      ride.startLocation.longitude = location.longitude!;
      currentLocation = location;
      previousLocation = location;
      sourceLocation = LatLng(location.latitude!, location.longitude!);
      polylineCoordinates.add(
        LatLng(
          location.latitude!,
          location.longitude!,
        ),
      );
    });

    GoogleMapController googleMapController = await _controller.future;

    locationSubscription = location.onLocationChanged.listen(
      (newLoc) {
        previousTime = currentTime;
        currentTime = DateTime.now();
        previousLocation = currentLocation;
        currentLocation = newLoc;
        currentTime.difference(previousTime).inSeconds;
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 14.5,
              target: LatLng(newLoc.latitude!, newLoc.longitude!),
            ),
          ),
        );
        polylineCoordinates.add(
          LatLng(
            newLoc.latitude!,
            newLoc.longitude!,
          ),
        );
        if (mounted) {
          setState(() {});
        }
      },
      onDone: () {
        previousLocation == currentLocation;
      },
    );
  }

  // void getPolyPoints() async {
  //   PolylinePoints polylinePoints = PolylinePoints();

  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     "api-key",
  //     PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
  //     PointLatLng(destination.latitude, destination.longitude),
  //   );

  //   if (result.points.isNotEmpty) {
  //     for (var point in result.points) {
  //       polylineCoordinates.add(
  //         LatLng(
  //           point.latitude,
  //           point.longitude,
  //         ),
  //       );
  //     }
  //     setState(() {});
  //   }
  // }

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/Pin_source.png")
        .then((value) {
      sourceIcon = value;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/Pin_destination.png")
        .then((value) {
      destinationIcon = value;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/Badge.png")
        .then((value) {
      currentLocationIcon = value;
    });
  }

  //Timer Functions
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    const addTime = 1;

    if (mounted) {
      setState(() {
        duration = duration + const Duration(seconds: addTime);

        if (duration.inSeconds == 60) {
          duration = const Duration(seconds: 0);
          duration = duration + const Duration(minutes: addTime);
        }

        if (duration.inMinutes == 60) {
          duration = const Duration(minutes: 0);
          duration = duration + const Duration(hours: addTime);
        }

        if (duration.inHours == 24) {
          duration = const Duration(hours: 0);
        }
      });
    }
  }

  Widget buildTimer() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.timer,
          ),
          const SizedBox(width: 5),
          Text(
            "${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}",
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  //Distance Functions
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  double totalDistance() {
    distanceTravelled = distanceTravelled +
        calculateDistance(
            previousLocation!.latitude,
            previousLocation!.longitude,
            currentLocation!.latitude,
            currentLocation!.longitude);
    return distanceTravelled;
  }

  Widget buildDistance() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.directions_car,
          ),
          const SizedBox(width: 5),
          currentLocation == null
              ? const Text("0.00 km")
              : Text(
                  "${totalDistance().toStringAsFixed(2)} km",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
        ],
      ),
    );
  }

  //Speed Functions
  double calculateSpeed() {
    double distance = 0;
    if (previousLocation != null && currentLocation != null) {
      distance = calculateDistance(
        previousLocation!.latitude!,
        previousLocation!.longitude!,
        currentLocation!.latitude!,
        currentLocation!.longitude!,
      );
    }
    double time = currentTime.difference(previousTime).inSeconds / 3600;
    return distance / time;
  }

  Widget buildSpeed() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.speed,
          ),
          const SizedBox(width: 5),
          Text(
            "${calculateSpeed().toStringAsFixed(2)} km/h",
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      ride = ModalRoute.of(context)!.settings.arguments as Ride;
      getCurrentLocation();
      setCustomMarkerIcon();
      startTimer();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Screen 3",
        ),
      ),
      body: Center(
        child: currentLocation == null
            ? const CircularProgressIndicator()
            : GoogleMap(
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                  zoom: 13.5,
                ),
                polylines: {
                  Polyline(
                    polylineId: const PolylineId("route"),
                    points: polylineCoordinates,
                    color: Colors.blue,
                    width: 6,
                  ),
                },
                markers: {
                  Marker(
                    markerId: const MarkerId("currentLocation"),
                    icon: currentLocationIcon,
                    position: LatLng(currentLocation!.latitude!,
                        currentLocation!.longitude!),
                  ),
                  Marker(
                    markerId: const MarkerId("source"),
                    icon: sourceIcon,
                    position: sourceLocation!,
                  ),
                  // Marker(
                  //   markerId: const MarkerId("destination"),
                  //   icon: destinationIcon,
                  //   position: destination,
                  // ),
                },
                onMapCreated: (mapController) =>
                    _controller.complete(mapController),
              ),
      ),
      bottomSheet: Container(
        height: 250,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Ride in Progress',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Time',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text(
                        'HH:MM:SS',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      buildTimer(),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Distance',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text(
                        'KMS',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      buildDistance(),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Avg Speed',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text(
                        'kmph',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      buildSpeed(),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    locationSubscription.cancel();
                    print('what is happening');
                    ride.endTime = DateTime.now();
                    ride.distance = distanceTravelled;
                    ride.time =
                        "${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
                    ride.avgSpeed = calculateSpeed();
                    ride.endLocation = UserLocation(currentLocation!.latitude!,
                        currentLocation!.longitude!);
                    Navigator.of(context).pop(ride);
                  },
                  child: const Text(
                    'End Ride',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Dismissible(
              //   key: UniqueKey(),
              //   direction: DismissDirection.startToEnd,
              //   onDismissed: (direction) {
              //     print('what is happening');
              //     ride.endTime = DateTime.now();
              //     ride.distance = distanceTravelled;
              //     ride.avgSpeed = calculateSpeed();
              //     ride.time =
              //         "${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
              //     Navigator.of(context).pop(ride);
              //   },
              //   confirmDismiss: (direction) => showDialog(
              //     context: context,
              //     builder: (context) => AlertDialog(
              //       title: const Text('End Ride'),
              //       content:
              //           const Text('Are you sure you want to end the ride?'),
              //       actions: [
              //         TextButton(
              //           onPressed: () => Navigator.of(context).pop(false),
              //           child: const Text('No'),
              //         ),
              //         TextButton(
              //           onPressed: () {
              //             Navigator.of(context).pop(true);
              //           },
              //           child: const Text('Yes'),
              //         ),
              //       ],
              //     ),
              //   ),
              //   background: Container(
              //     color: Colors.red,
              //     child: const Align(
              //       alignment: Alignment.centerLeft,
              //       child: Padding(
              //         padding: EdgeInsets.only(left: 20),
              //         child: Icon(
              //           Icons.cancel,
              //           color: Colors.white,
              //         ),
              //       ),
              //     ),
              //   ),
              //   child: Container(
              //     height: 50,
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       color: Colors.purple,
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: const Center(
              //       child: Text(
              //         'End Ride',
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 20,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ),
              //   ),
              // onDismissed: (direction) {
              //   print('what is happening');
              //   ride.endTime = DateTime.now();
              //   ride.distance = distanceTravelled;
              //   ride.time =
              //       "${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
              //   ride.avgSpeed = calculateSpeed();
              //   ride.endLocation = UserLocation(
              //       currentLocation!.latitude!, currentLocation!.longitude!);
              //   Navigator.of(context).pop(ride);
              // },
              // confirmDismiss: (direction) => showDialog(
              //   context: context,
              //   builder: ((context) => AlertDialog(
              //         title: const Text('Are you sure?'),
              //         content: const Text('Do you want to end this ride?'),
              //         actions: [
              //           TextButton(
              //               onPressed: () {
              //                 Navigator.of(context).pop(false);
              //               },
              //               child: const Text('No')),
              //           TextButton(
              //               onPressed: () {
              //                 Navigator.of(context).pop(true);
              //               },
              //               child: const Text('Yes')),
              //         ],
              //       )),
              // ),
              // child: Container(
              //   height: 50,
              //   padding: const EdgeInsets.all(10),
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     color: Colors.purple,
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: const [
              //       Text(
              //         'Slide to Finish',
              //         style: TextStyle(
              //           fontSize: 20,
              //           fontWeight: FontWeight.bold,
              //           color: Colors.white,
              //         ),
              //       ),
              //       SizedBox(
              //         width: 10,
              //       ),
              //       Icon(
              //         Icons.arrow_forward,
              //         color: Colors.white,
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
