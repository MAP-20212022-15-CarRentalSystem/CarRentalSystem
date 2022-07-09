import 'package:car_rental_system/providers/trip_provider.dart';
import 'package:car_rental_system/widgets/state_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RideReviews extends ConsumerWidget {
  const RideReviews(this.uid, {Key? key}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(allReviewProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
      ),
      body: ref.watch(allReviewProvider).map(
            initial: (_) => const NoRecordWidget(),
            loading: (_) => const LoadingWidget(),
            loaded: (_) {
              return ListView.builder(
                itemCount: _.data.length,
                itemBuilder: (context, index) {
                  final review = _.data[index];
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
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
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'By : ${FirebaseAuth.instance.currentUser!.uid == review.by ? "You" : "Rider"}',
                            ),
                            Text('Review : ${review.msg}'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            error: (_) => ErrorHandleWidget(
              error: _.error,
            ),
          ),
    );
  }
}
