import 'package:car_rental_system/providers/maps_provider.dart';
import 'package:car_rental_system/utils/context_less.dart';
import 'package:car_rental_system/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class TripSearchBottomMenu extends ConsumerWidget {
  const TripSearchBottomMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: AnimatedSize(
        curve: Curves.bounceIn,
        duration: const Duration(milliseconds: 500),
        child: Container(
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hi there,',
                  style: TextStyle(fontSize: 11),
                ),
                const Text(
                  'Hoping to?',
                  style: TextStyle(fontSize: 13),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    var pos = ref.read(originLatlngProvider);
                    ref.watch(ownAddressProvider.notifier).getPredictions(pos);
                    context.nav.pushNamed(Routes.searchDropOff);
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 4,
                          spreadRadius: 0.2,
                          offset: Offset(0.7, 0.7),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const [
                          Icon(Icons.search),
                          Text(
                            '\t\tDrop off location',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    children: [
                      const Icon(Icons.home),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: const Text(
                              'Add Home',
                              style: TextStyle(fontSize: 12),
                              // overflow: TextOverflow.ellipsis,
                              // maxLines: 1,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const Text(
                            'Your home address',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  child: Row(
                    children: [
                      const Icon(Icons.work),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Add Office?',
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Your office address',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
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
