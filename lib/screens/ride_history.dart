import 'package:car_rental_system/providers/trip_provider.dart';
import 'package:car_rental_system/utils/context_less.dart';
import 'package:car_rental_system/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class RideHistory extends ConsumerWidget {
  const RideHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trips = ref.watch(allTripProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Ride History'),
        centerTitle: true,
      ),
      body: trips.isEmpty
          ? const Center(
              child: Text('No Trip Found'),
            )
          : ListView.builder(
              itemCount: trips.length,
              itemBuilder: (context, index) {
                final _trip = trips[index];

                return GestureDetector(
                  onTap: () {
                    ref
                        .watch(allReviewProvider.notifier)
                        .getReviews(_trip.docID!);
                    context.nav.pushNamed(
                      Routes.tripReview,
                      arguments: _trip.docID,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(4, 4),
                            blurRadius: 5,
                            color: Colors.black.withOpacity(0.2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('From : ${_trip.from}'),
                          const SizedBox(
                            height: 5,
                          ),
                          Text('TO : ${_trip.from}'),
                          const SizedBox(
                            height: 5,
                          ),
                          Text('Distance : ${_trip.distance}'),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Cost : ${_trip.cost} RM',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text('Distance : ${_trip.distance}'),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Date : ${DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(_trip.requestTime))}',
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
