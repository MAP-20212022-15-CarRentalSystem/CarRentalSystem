import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_sharing_app/models/user.dart';
import 'package:vehicle_sharing_app/screens/home_page.dart';
import 'package:vehicle_sharing_app/services/firebase_services.dart';
import 'package:vehicle_sharing_app/services/validation_services.dart';
import 'package:vehicle_sharing_app/widgets/widgets.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _licenseController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _bloodController = TextEditingController();
  TextEditingController _contactController = TextEditingController();

  //  String _imageUrl;

  AppUser user = AppUser();

  FirebaseFunctions firebaseFunctions = FirebaseFunctions();

  void initAppUser() {
    user.name = _nameController.text;
    user.age = _ageController.text;
    user.licenseNumber = _licenseController.text;
    user.bloodGroup = _bloodController.text;
    user.contact = _contactController.text;
    // user.dpURL = _imageUrl;
    user.emailID = FirebaseAuth.instance.currentUser.email;
    user.hasCompleteProfile = true;
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .get(),
        builder: (context, snapShot) {
          if (snapShot.hasData &&
              snapShot.data.exists &&
              snapShot.data.data() != null) {
            user = AppUser.fromMap(snapShot.data.data());
            _nameController.text = user.name;
            _licenseController.text = user.licenseNumber;
            _ageController.text = user.age;
            _bloodController.text = user.bloodGroup;
            _contactController.text = user.contact;
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomBackButton(
                        pageHeader: 'Edit your profile',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InputFormField(
                        fieldName: 'Name',
                        obscure: false,
                        validator: ValidationService().nameValidator,
                        controller: _nameController,
                      ),
                      SizedBox(
                        height: 0.03 * deviceSize.height,
                      ),
                      InputFormField(
                        fieldName: 'Age',
                        obscure: false,
                        validator: ValidationService().ageValidator,
                        controller: _ageController,
                      ),
                      SizedBox(
                        height: 0.03 * deviceSize.height,
                      ),
                      InputFormField(
                        fieldName: 'Blood Group',
                        obscure: false,
                        validator: ValidationService().bloodValidator,
                        controller: _bloodController,
                      ),
                      SizedBox(
                        height: 0.03 * deviceSize.height,
                      ),
                      InputFormField(
                        fieldName: 'Contact Number',
                        obscure: false,
                        validator: ValidationService().contactValidator,
                        controller: _contactController,
                      ),
                      SizedBox(
                        height: 0.03 * deviceSize.height,
                      ),
                      InputFormField(
                        fieldName: 'License Number',
                        obscure: false,
                        validator: ValidationService().licenseValidator,
                        controller: _licenseController,
                      ),
                      SizedBox(
                        height: 0.05 * deviceSize.height,
                      ),
                      GestureDetector(
                        onTap: () async {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Processing')));
                          initAppUser();
                          await firebaseFunctions.updateUser(user.toMap());

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return HomePage();
                              },
                            ),
                          );
                        },
                        child: CustomButton(
                          text: 'Save',
                        ),
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
