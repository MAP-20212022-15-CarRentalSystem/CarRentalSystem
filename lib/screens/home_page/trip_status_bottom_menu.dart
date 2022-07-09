import 'package:car_rental_system/providers/maps_provider.dart';
import 'package:car_rental_system/utils/context_less.dart';
import 'package:car_rental_system/utils/global_functions.dart';
import 'package:car_rental_system/utils/routes.dart';
import 'package:car_rental_system/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TripStatusWidget extends ConsumerWidget {
  const TripStatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(tripInfoProvider);
    final Size deviceSize = MediaQuery.of(context).size;
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
                Text(
                  'From : ${ref.watch(pickupAddressProvider)}',
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
                  'To : ${ref.watch(dropAddressProvider)}',
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
                          details!.distanceText,
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
                          'RM ${AppGLF.calculateFares(details)}',
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
                GestureDetector(
                  onTap: () {
                    context.nav.pushNamed(Routes.carList,
                        arguments: AppGLF.calculateFares(details));
                  },
                  child: const CustomButton(
                    text: 'Next',
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
