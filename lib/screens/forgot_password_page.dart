import 'package:car_rental_system/constants/duration_contants.dart';
import 'package:car_rental_system/providers/auth_provider.dart';
import 'package:car_rental_system/utils/context_less.dart';
import 'package:car_rental_system/utils/routes.dart';
import 'package:car_rental_system/widgets/custom_text_field.dart';
import 'package:car_rental_system/widgets/state_widgets.dart';
import 'package:car_rental_system/widgets/widgets.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgetPassword extends ConsumerWidget {
  final txtEmail = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final header = width * 0.45;
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    final isMobileLayout = shortestSide < 600;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: height,
          color: Theme.of(context).primaryColorLight,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: height * 0.04),
                height: header,
                child: ClipOval(
                  child: Image(
                    height: isMobileLayout ? header * 0.65 : header * 0.65,
                    width: isMobileLayout ? header * 0.65 : header * 0.65,
                    image: const AssetImage(
                      'images/ToyFaces_Colored_BG_47.jpg',
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(width * 0.06),
                      topRight: Radius.circular(width * 0.06),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: width * 0.05),
                          height: width * 0.1,
                          width: width * 0.9,
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Theme.of(context).primaryColor,
                              size: width * 0.08,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: width * 0.06),
                          width: width * 0.82,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Reset Password",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: width * 0.09,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: width * 0.06),
                          width: width * 0.8,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Enter your email to reset your password and authenticate. We will send you an email after confirmation that you will be able to change your password",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: width * 0.036,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: width * 0.025),
                          child: CustomTextField(
                            hint: "Email",
                            textEditingController: txtEmail,
                            textInputType: TextInputType.emailAddress,
                            fieldTitle: 'Email',
                            onChanged: (String text) {},
                            prefixIcon: const Icon(Icons.email),
                          ),
                        ),
                        ref.watch(forgotPassworProvider).map(
                              initial: (_) => GestureDetector(
                                onTap: () async {
                                  // network connectivity
                                  final connectivityResult =
                                      await Connectivity().checkConnectivity();
                                  if (connectivityResult !=
                                          ConnectivityResult.mobile &&
                                      connectivityResult !=
                                          ConnectivityResult.wifi) {
                                    EasyLoading.showError('No Internet');
                                    return;
                                  }

                                  ref
                                      .watch(forgotPassworProvider.notifier)
                                      .resetPass(
                                        txtEmail.text,
                                      );
                                },
                                child: const CustomButton(
                                  text: 'SEND',
                                ),
                              ),
                              loading: (_) => const LoadingWidget(),
                              loaded: (_) {
                                Future.delayed(
                                  AppDurConst.rebuid,
                                ).then((value) {
                                  context.nav.pushNamedAndRemoveUntil(
                                    Routes.login,
                                    (route) => false,
                                  );
                                });
                                return const MessageWidget(
                                  msg: 'Success',
                                );
                              },
                              error: (_) => ErrorHandleWidget(
                                error: _.error,
                              ),
                            ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
