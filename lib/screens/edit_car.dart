import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_sharing_app/models/user.dart';
import 'package:vehicle_sharing_app/screens/owner_homePage.dart';
import 'package:vehicle_sharing_app/services/firebase_services.dart';
import 'package:vehicle_sharing_app/services/validation_services.dart';
import 'package:vehicle_sharing_app/widgets/widgets.dart';

class EditVehicleDetails extends StatefulWidget {
  @override
  _EditVehicleDetailsState createState() => _EditVehicleDetailsState();
}

class _EditVehicleDetailsState extends State<EditVehicleDetails> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _modelNameController = TextEditingController();
  TextEditingController _vehicleNumberController = TextEditingController();
  TextEditingController _ownerNameController = TextEditingController();
  TextEditingController _colorController = TextEditingController();
  TextEditingController _aadharcardController = TextEditingController();
  TextEditingController _rentAmount = TextEditingController();

  VehicleUser owner = VehicleUser();
  File imageFile;

  FirebaseFunctions firebaseFunctions = FirebaseFunctions();

  void initVehicleUser() {
    owner.modelName = _modelNameController.text;
    owner.vehicleNumber = _vehicleNumberController.text;
    owner.ownerName = _ownerNameController.text;
    owner.color = _colorController.text;
    owner.aadharNumber = _aadharcardController.text;
    owner.hasCompletedRegistration = true;
    owner.amount = _rentAmount.text;
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .collection('vehicle_details')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .get(),
        builder: (context, snap) {
          if (snap.hasData && snap.data.exists && snap.data.data() != null) {
            owner = VehicleUser.fromMap(snap.data.data());
            _modelNameController.text = owner.modelName;
            _vehicleNumberController.text = owner.vehicleNumber;
            _ownerNameController.text = owner.ownerName;
            _colorController.text = owner.color;
            _aadharcardController.text = owner.aadharNumber;
            _rentAmount.text = owner.amount;
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomBackButton(pageHeader: 'Edit your car'),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 0.0,
                      ),
                      InputFormField(
                        fieldName: 'Model Name',
                        obscure: false,
                        validator: ValidationService().modelNameValidator,
                        controller: _modelNameController,
                      ),
                      SizedBox(
                        height: 0.03 * deviceSize.height,
                      ),
                      InputFormField(
                        fieldName: 'Vehicle Number',
                        obscure: false,
                        validator: ValidationService().vehicleNumberValidator,
                        controller: _vehicleNumberController,
                      ),
                      SizedBox(
                        height: 0.03 * deviceSize.height,
                      ),
                      InputFormField(
                        fieldName: 'Owner Name',
                        obscure: false,
                        validator: ValidationService().ownerNameValidator,
                        controller: _ownerNameController,
                      ),
                      SizedBox(
                        height: 0.03 * deviceSize.height,
                      ),
                      InputFormField(
                        fieldName: 'Color',
                        obscure: false,
                        validator: ValidationService().colorValidator,
                        controller: _colorController,
                      ),
                      SizedBox(
                        height: 0.03 * deviceSize.height,
                      ),
                      InputFormField(
                        fieldName: 'IC/Passport Number',
                        obscure: false,
                        validator: ValidationService().aadharNumberValidator,
                        controller: _aadharcardController,
                      ),
                      SizedBox(
                        height: 0.03 * deviceSize.height,
                      ),
                      InputFormField(
                        fieldName: 'Rent amount',
                        obscure: false,
                        validator: ValidationService().aadharNumberValidator,
                        controller: _rentAmount,
                      ),
                      SizedBox(
                        height: 0.05 * deviceSize.height,
                      ),
                      GestureDetector(
                        onTap: () async {
                          initVehicleUser();
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Processing')));

                          await firebaseFunctions
                              .updateVehicleInfo(owner.toMap());

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return DisplayMap();
                              },
                            ),
                          );
                        },
                        child: CustomButton(
                          text: 'Register',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
