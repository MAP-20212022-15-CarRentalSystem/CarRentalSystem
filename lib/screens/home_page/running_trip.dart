import 'package:car_rental_system/constants/duration_contants.dart';
import 'package:car_rental_system/providers/maps_provider.dart';
import 'package:car_rental_system/providers/trip_provider.dart';
import 'package:car_rental_system/utils/global_functions.dart';
import 'package:car_rental_system/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RunningTrip extends ConsumerWidget {
  const RunningTrip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(activeTripProvider);
    final Size deviceSize = MediaQuery.of(context).size;
    final uid = FirebaseAuth.instance.currentUser!.uid;
    if (details!.status == 4) {
      Future.delayed(AppDurConst.rebuid).then((value) {
        AppGLF.makeReview(details.docID!, context);
        Future.delayed(const Duration(seconds: 5)).then((value) {
          ref.watch(tripInfoProvider.notifier).state = null;
          ref.watch(polyPointsProvider.notifier).state = [];
          AppGLF.endTrip(details.docID!);
        });
      });
    }

    Future.delayed(AppDurConst.rebuid).then((value) {
      final PolylinePoints polylinePoints = PolylinePoints();

      final List<PointLatLng> data =
          polylinePoints.decodePolyline(details.enCodedroute);
      final List<LatLng> latlngData =
          data.map((e) => LatLng(e.latitude, e.longitude)).toList();
      ref.watch(polyPointsProvider.notifier).state = [
        Polyline(
          polylineId: const PolylineId('Trip'),
          points: latlngData,
          width: 4,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
        )
      ];
    });

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 200,
        width: deviceSize.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 16,
              spreadRadius: 0.2,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'From : ${details.from}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'To : ${details.to}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Total Ride - \t',
                          style: TextStyle(
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          details.distance,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Cost of Ride - \t',
                          style: TextStyle(
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          'BDT ${details.cost}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                if (details.userID == uid)
                  GestureDetector(
                    //userBlock
                    onTap: () {
                      if (details.status == 4) {}
                    },
                    child: CustomButton(
                      text: AppGLF.getRidText(details.status, details.userID),
                    ),
                  )
                else
                  GestureDetector(
                    onTap: () {
                      if (details.status == 0) {
                        AppGLF.updateTripStatus(details.docID!, 1);
                      } else if (details.status == 1) {
                        AppGLF.updateTripStatus(details.docID!, 2);
                      } else if (details.status == 2) {
                        AppGLF.updateTripStatus(details.docID!, 3);
                      } else if (details.status == 3) {
                        AppGLF.updateTripStatus(details.docID!, 4);
                      }
                    }, //Rider Block
                    child: CustomButton(
                      text: AppGLF.getRidText(details.status, details.userID),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
