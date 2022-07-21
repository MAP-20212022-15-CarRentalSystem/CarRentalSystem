import 'package:car_rental_system/constants/duration_contants.dart';
import 'package:car_rental_system/constants/firebase_contants.dart';
import 'package:car_rental_system/constants/regular_string_constants.dart';

import 'package:car_rental_system/providers/vehicle_provider.dart';
import 'package:car_rental_system/utils/context_less.dart';
import 'package:car_rental_system/widgets/state_widgets.dart';
import 'package:car_rental_system/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class EditCar extends ConsumerWidget {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size deviceSize = MediaQuery.of(context).size;
    ref.watch(vehicleUpdateProvider);

    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: AppFBC.userVehicleCollection.get(),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return FormBuilder(
              key: _formKey,
              initialValue: snapShot.data!.data() ?? {},
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CustomBackButton(pageHeader: 'Update your car'),
                      const SizedBox(
                        height: 20,
                      ),
                      InputFormField(
                        fieldName: 'Model Name',
                        validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()],
                        ),
                        name: AppRSC.vrfcModelName,
                      ),
                      SizedBox(
                        height: 0.03 * deviceSize.height,
                      ),
                      InputFormField(
                        fieldName: 'Vehicle Number',
                        validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()],
                        ),
                        name: AppRSC.vrfcVehicleNumber,
                      ),
                      SizedBox(
                        height: 0.03 * deviceSize.height,
                      ),
                      InputFormField(
                        fieldName: 'Owner Name',
                        validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()],
                        ),
                        name: AppRSC.vrfcOwnerName,
                      ),
                      SizedBox(
                        height: 0.03 * deviceSize.height,
                      ),
                      InputFormField(
                        fieldName: 'Color',
                        validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()],
                        ),
                        name: AppRSC.vrfcColor,
                      ),
                      SizedBox(
                        height: 0.03 * deviceSize.height,
                      ),
                      InputFormField(
                        fieldName: 'IC/Passport Number',
                        validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()],
                        ),
                        name: AppRSC.vrfcNidNumber,
                      ),
                      SizedBox(
                        height: 0.03 * deviceSize.height,
                      ),
                      InputFormField(
                        fieldName: 'Rent amount',
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.numeric()
                          ],
                        ),
                        name: AppRSC.vrfcAmount,
                      ),
                      SizedBox(
                        height: 0.05 * deviceSize.height,
                      ),
                      ref.watch(vehicleUpdateProvider).map(
                            initial: (_) => GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState!.saveAndValidate()) {
                                  final data = _formKey.currentState!.value;

                                  ref
                                      .watch(vehicleUpdateProvider.notifier)
                                      .update(data);
                                }
                              },
                              child: const CustomButton(
                                text: 'Update',
                              ),
                            ),
                            loading: (_) => const LoadingWidget(),
                            loaded: (_) {
                              Future.delayed(AppDurConst.rebuid).then(
                                (value) {
                                  ref.refresh(vehicleUpdateProvider);
                                  Future.delayed(AppDurConst.rebuid)
                                      .then((value) {
                                    context.nav.pop();
                                  });
                                },
                              );
                              return const MessageWidget(
                                msg: 'Success',
                              );
                            },
                            error: (_) => ErrorHandleWidget(
                              error: _.error,
                            ),
                          ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
