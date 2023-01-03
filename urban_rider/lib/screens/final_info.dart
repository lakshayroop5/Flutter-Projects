import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:urban_rider/functions/functions.dart';
import 'package:urban_rider/models/ride.dart';

class FinalInfo extends StatelessWidget {
  static const routeName = '/final-info';

  const FinalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final ride = ModalRoute.of(context)!.settings.arguments as Ride;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen 6'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            const Text(
              'Final Info',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text(
                      'Start Time',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      DateFormat('d MMM yy, hh:mm a').format(ride.startTime),
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'End Time',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      DateFormat('d MMM yy, hh:mm a').format(ride.startTime),
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text(
                      'Time',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      ride.time,
                      style: const TextStyle(
                        fontSize: 19,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'Distance',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text('${ride.distance.toStringAsFixed(2)} km',
                        style: const TextStyle(
                          fontSize: 19,
                        )),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'Avg Speed',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text('${ride.avgSpeed.toStringAsFixed(2)} kmph',
                        style: const TextStyle(
                          fontSize: 19,
                        )),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Functions.addRideInfo(ride);
                  Navigator.of(context).pop(0);
                },
                child: const Text('Save Info',
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
