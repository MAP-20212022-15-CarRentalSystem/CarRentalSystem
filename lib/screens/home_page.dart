import 'package:car_rental_system/providers/maps_provider.dart';
import 'package:car_rental_system/providers/misc_provider.dart';
import 'package:car_rental_system/providers/trip_provider.dart';
import 'package:car_rental_system/screens/home_page/app_drawer.dart';
import 'package:car_rental_system/screens/home_page/running_trip.dart';
import 'package:car_rental_system/screens/home_page/trip_details_bottom_menu.dart';
import 'package:car_rental_system/screens/home_page/trip_search_bottom_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //State variables
    ref.read(originLatlngProvider);
    final bool isOpen = ref.watch(drawerStateProvider);

    //Screen Size
    final Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          GoogleMap(
            padding: const EdgeInsets.only(bottom: 320),
            initialCameraPosition: CameraPosition(
              target: ref.watch(deafaultLocationProvider),
              zoom: 16,
            ),
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              ref.watch(googleMapsProvider.notifier).state = controller;
              //Animate Camera to To Certain Position
              Future.delayed(const Duration(seconds: 3)).then((value) async {
                await controller.animateCamera(
                  CameraUpdate.newLatLng(ref.read(originLatlngProvider)),
                );
              });
            },
            polylines: Set.from(ref.watch(polyPointsProvider)),
          ),
          //Hamburger button for Drawer
          Positioned(
            top: 45,
            left: 15,
            child: GestureDetector(
              onTap: () {
                ref.watch(drawerStateProvider.notifier).state = true;
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 6,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          if (ref.watch(tripInfoProvider.notifier).state == null &&
              ref.watch(activeTripProvider) == null)
            const TripSearchBottomMenu(),
          if (ref.watch(tripInfoProvider.notifier).state != null &&
              ref.watch(activeTripProvider) == null)
            const TripDetailsWidget(),

          if (ref.watch(activeTripProvider) != null) const RunningTrip(),

          //Drawer Start here Should Be At the top
          if (isOpen)
            Positioned(
              top: 0,
              left: 0,
              child: GestureDetector(
                onTap: () {
                  ref
                      .watch(drawerStateProvider.notifier)
                      .update((state) => !state);
                },
                child: Container(
                  height: deviceSize.height,
                  width: deviceSize.width,
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            ),

          CustomAppDrawer()
        ],
      ),
    );
  }
}
