import 'package:car_rental_system/constants/duration_contants.dart';
import 'package:car_rental_system/models/prediction_model.dart';
import 'package:car_rental_system/providers/maps_provider.dart';
import 'package:car_rental_system/utils/context_less.dart';
import 'package:car_rental_system/utils/global_functions.dart';
import 'package:car_rental_system/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchDropOffLocation extends ConsumerWidget {
  TextEditingController pickUpTextEditingController = TextEditingController();
  TextEditingController dropOffTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ownAddress = ref.watch(ownAddressProvider);
    final prediction = ref.watch(predictionProvider);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 242, 1),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const CustomBackButton(pageHeader: 'Seach dropOff location'),
                  const SizedBox(height: 30),

                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: ownAddress.maybeMap(
                      orElse: () => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: pickUpTextEditingController,
                          decoration: const InputDecoration(
                            labelText: 'Pick up location',
                          ),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      loaded: (_) {
                        pickUpTextEditingController.text =
                            AppGLF.getAddress(_.data.results!.first);
                        ref.watch(pickupAddressProvider.notifier).state =
                            AppGLF.getAddress(_.data.results!.first);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            readOnly: true,
                            controller: pickUpTextEditingController,
                            decoration: const InputDecoration(
                              labelText: 'Pick up location',
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (val) {
                          ref.watch(searchQueryProvider.notifier).state = val;
                        },
                        controller: dropOffTextEditingController,
                        decoration: const InputDecoration(
                          labelText: '\tWhere to?',
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),

                  //CALENDAR
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //tile for place prediction
            prediction.maybeMap(
              orElse: () => const SizedBox(),
              loaded: (_) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      return PredictionTile(
                        placePrediction: _.data.predictions[index],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Divider(),
                      );
                    },
                    itemCount: _.data.predictions.length,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                  ),
                );
              },
            ),

            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class PredictionTile extends ConsumerWidget {
  final PredictionModel placePrediction;

  const PredictionTile({required this.placePrediction});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(tripProvider).when(
          initial: () {},
          loading: () {
            EasyLoading.showInfo('Loading Trip Details');
          },
          loaded: (_) async {
            await EasyLoading.dismiss();
            EasyLoading.showSuccess('Success');
            final PolylinePoints polylinePoints = PolylinePoints();

            final List<PointLatLng> data =
                polylinePoints.decodePolyline(_.encodedPoints);
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

            ref.watch(tripInfoProvider.notifier).state = _;
            Future.delayed(AppDurConst.rebuid).then((value) async {
              await EasyLoading.dismiss();
              context.nav.pop();
            });
          },
          error: (_) async {
            await EasyLoading.dismiss();
            EasyLoading.showError(_);
          },
        );

    return GestureDetector(
      onTap: () async {
        EasyLoading.showInfo('Loading Trip Details');
        await ref
            .watch(destinationAddressProvider.notifier)
            .getPredictions(placePrediction.place_id);
        await EasyLoading.dismiss();
        ref.watch(destinationAddressProvider).maybeWhen(
              orElse: () {},
              loaded: (_) {
                ref.watch(dropAddressProvider.notifier).state =
                    AppGLF.getDestinationAddress(_.result!.addressComponents!);
                Future.delayed(AppDurConst.rebuid).then((value) {
                  ref.watch(tripProvider.notifier).getPredictions(
                        ref.watch(originLatlngProvider),
                        LatLng(
                          _.result!.geometry!.location!.lat!,
                          _.result!.geometry!.location!.lng!,
                        ),
                      );
                });
              },
            );
      },
      child: Column(
        children: [
          const SizedBox(
            width: 14,
          ),
          Row(
            children: [
              const Icon(Icons.add_location),
              const SizedBox(
                width: 14,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    placePrediction.description.trim(),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 14,
          ),
        ],
      ),
    );
  }
}
