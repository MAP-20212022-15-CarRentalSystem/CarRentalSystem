import 'package:car_rental_system/constants/regular_string_constants.dart';
import 'package:car_rental_system/utils/context_less.dart';
import 'package:car_rental_system/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class EditProfile extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get(),
        builder: (context, snapShot) {
          if (snapShot.hasData && snapShot.data != null) {
            return FormBuilder(
              key: _formKey,
              initialValue:
                  snapShot.data!.data()  ?? {},
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CustomBackButton(
                        pageHeader: 'Edit your profile',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputFormField(
                        fieldName: 'Name',
                        validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()],
                        ),
                        name: AppRSC.uprcName,
                      ),
                      SizedBox(
                        height: 0.03 * deviceSize.height,
                      ),
                      InputFormField(
                        fieldName: 'Age',
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.numeric()
                          ],
                        ),
                        name: AppRSC.uprcAge,
                      ),
                      SizedBox(
                        height: 0.03 * deviceSize.height,
                      ),
                      InputFormField(
                        fieldName: 'Blood Group',
                        validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()],
                        ),
                        name: AppRSC.uprcBloodGroup,
                      ),
                      SizedBox(
                        height: 0.03 * deviceSize.height,
                      ),
                      InputFormField(
                        fieldName: 'Contact Number',
                        validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()],
                        ),
                        name: AppRSC.uprcContact,
                      ),
                      SizedBox(
                        height: 0.03 * deviceSize.height,
                      ),
                      InputFormField(
                        fieldName: 'License Number',
                        validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()],
                        ),
                        name: AppRSC.uprcLicenseNumber,
                      ),
                      SizedBox(
                        height: 0.05 * deviceSize.height,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.saveAndValidate()) {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .update(_formKey.currentState!.value)
                                .then((value) {
                              context.nav.pop();
                            });
                          }
                        },
                        child: const CustomButton(
                          text: 'Save',
                        ),
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
