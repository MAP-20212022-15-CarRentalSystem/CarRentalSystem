import 'dart:io';

import 'package:car_rental_system/constants/duration_contants.dart';
import 'package:car_rental_system/constants/regular_string_constants.dart';
import 'package:car_rental_system/providers/misc_provider.dart';
import 'package:car_rental_system/providers/vehicle_provider.dart';
import 'package:car_rental_system/utils/context_less.dart';
import 'package:car_rental_system/widgets/state_widgets.dart';
import 'package:car_rental_system/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';

class VehicleRegistration extends ConsumerWidget {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size deviceSize = MediaQuery.of(context).size;
    final imageFile = ref.watch(imageFileProvider);

    return Scaffold(
      body: Builder(
        builder: (context) {
          return FormBuilder(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CustomBackButton(pageHeader: 'Register your car'),
                    const SizedBox(
                      height: 20,
                    ),
                    if (imageFile != null)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 20,
                              child: Image.file(
                                imageFile,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ElevatedButton(
                                child: const Icon(Icons.refresh),
                                onPressed: () {
                                  ref.watch(imageFileProvider.notifier).state =
                                      null;
                                },
                              ),
                            ],
                          ),
                        ],
                      )
                    else
                      GestureDetector(
                        onTap: () async {
                          final file = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (file != null) {
                            ref.watch(imageFileProvider.notifier).state =
                                File(file.path);
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 200,
                          child: Column(
                            children: const [
                              Icon(
                                Icons.directions_car,
                                size: 80,
                              ),
                              Text(
                                'Choose your car image',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 0.0,
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
                    ref.watch(vehicleUploadProvider).map(
                          initial: (_) => GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.saveAndValidate()) {
                                final data = _formKey.currentState!.value;
                                if (imageFile != null) {
                                  EasyLoading.showInfo('Registering Your Car');
                                  ref
                                      .watch(vehicleUploadProvider.notifier)
                                      .upload(data, imageFile);
                                } else {
                                  EasyLoading.showError('No Image Selected');
                                }
                              }
                            },
                            child: const CustomButton(
                              text: 'Register',
                            ),
                          ),
                          loading: (_) => const LoadingWidget(),
                          loaded: (_) {
                            Future.delayed(AppDurConst.rebuid).then(
                              (value) {
                                context.nav.pop();
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
        },
      ),
    );
  }
}
