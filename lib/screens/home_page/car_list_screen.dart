import 'package:car_rental_system/models/trip_data_model.dart';
import 'package:car_rental_system/providers/maps_provider.dart';
import 'package:car_rental_system/providers/trip_provider.dart';
import 'package:car_rental_system/providers/vehicle_provider.dart';
import 'package:car_rental_system/utils/context_less.dart';
import 'package:car_rental_system/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarList extends ConsumerWidget {
  final int cost;
  const CarList({
    required this.cost,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carlist = ref.watch(allcarsProvider);
    final details = ref.watch(tripInfoProvider);
    ref.watch(startTripProvider).maybeWhen(
          orElse: () {},
          loading: () {
            EasyLoading.showInfo('Starting');
          },
          loaded: (_) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess('Success');
            context.nav.pop();
          },
        );

    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 242, 1),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: <Widget>[
          const CustomBackButton(
            pageHeader: 'Available Cars',
          ),
          const SizedBox(
            height: 30,
          ),
          ...carlist
              .map(
                (e) => GestureDetector(
                  onTap: () async {
                    await ref.watch(startTripProvider.notifier).startTrip(
                          TripdataModel(
                            from: ref.watch(pickupAddressProvider),
                            to: ref.watch(dropAddressProvider),
                            enCodedroute: details!.encodedPoints,
                            userID: FirebaseAuth.instance.currentUser!.uid,
                            riderID: e.userId,
                            carName: e.modelName,
                            carOwner: '',
                            cost: cost.toDouble(),
                            distance: details.distanceText,
                            status: 0,
                            isActive: true,
                            requestTime: DateTime.now().millisecondsSinceEpoch,
                          ),
                        );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Image.network(e.vehicleImg),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'BDT ${e.amount}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  e.modelName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'BDT $cost',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  'Ride amount',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward,
                              size: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
