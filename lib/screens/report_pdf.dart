import 'package:car_rental_system/providers/trip_provider.dart';
import 'package:car_rental_system/utils/trip_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Report extends ConsumerWidget {
  const Report({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size deviceSize = MediaQuery.of(context).size;
    final trips = ref.watch(allTripProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rides',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  child: ReportCard(
                    data: Trp.getRidesAsRider(trips).toString(),
                    title: 'As Rider',
                  ),
                ),
                Expanded(
                  child: ReportCard(
                    data: Trp.getRidesAsPassenger(trips).toString(),
                    title: 'As User',
                  ),
                ),
                Expanded(
                  child: ReportCard(
                    data: (Trp.getRidesAsPassenger(trips) +
                            Trp.getRidesAsRider(trips))
                        .toString(),
                    title: 'Total',
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Transaction',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  child: ReportCard(
                    data: '${Trp.getEarningAsRider(trips)} RM',
                    title: 'Earned',
                  ),
                ),
                Expanded(
                  child: ReportCard(
                    data: '${Trp.getEarningAsPassenger(trips)} RM',
                    title: 'Spent',
                  ),
                ),
                Expanded(
                  child: ReportCard(
                    data:
                        '${Trp.getEarningAsRider(trips) - Trp.getEarningAsPassenger(trips)} RM',
                    title: 'Total',
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  const ReportCard({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);
  final String title;
  final String data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(10),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(data),
          ],
        ),
      ),
    );
  }
}
