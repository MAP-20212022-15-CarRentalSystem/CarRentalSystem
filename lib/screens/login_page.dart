import 'package:car_rental_system/constants/duration_contants.dart';
import 'package:car_rental_system/constants/regular_string_constants.dart';
import 'package:car_rental_system/providers/auth_provider.dart';
import 'package:car_rental_system/utils/context_less.dart';
import 'package:car_rental_system/utils/routes.dart';
import 'package:car_rental_system/widgets/state_widgets.dart';
import 'package:car_rental_system/widgets/widgets.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginPage extends ConsumerWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 130),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Rental Car',
                  style: TextStyle(
                    fontSize: 60,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'MuseoModerno',
                    // color: Colors.white,
                  ),
                ),
                const SizedBox(height: 80),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: [
                        InputFormField(
                          fieldName: 'Email-Id',
                          validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required()],
                          ),
                          name: AppRSC.acEmail,
                        ),
                        InputFormField(
                          validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required()],
                          ),
                          name: AppRSC.acPassword,
                          fieldName: 'Password',
                          obscure: true,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ref.watch(signInProvider).map(
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
                                  if (_formKey.currentState != null &&
                                      _formKey.currentState!
                                          .saveAndValidate()) {
                                    final fields =
                                        _formKey.currentState!.fields;
                                    ref.watch(signInProvider.notifier).signIn(
                                          fields[AppRSC.acEmail]!.value
                                              as String,
                                          fields[AppRSC.acPassword]!.value
                                              as String,
                                        );
                                  }
                                },
                                child: const CustomButton(
                                  text: 'Login',
                                ),
                              ),
                              loading: (_) => const LoadingWidget(),
                              loaded: (_) {
                                Future.delayed(AppDurConst.transissionDuration,
                                    () {
                                  context.nav.pushNamedAndRemoveUntil(
                                    Routes.home,
                                    (route) => false,
                                  );
                                });
                                return const MessageWidget(
                                  msg: 'Success',
                                );
                              },
                              error: (_) {
                                Future.delayed(Duration(seconds: 3)).then((val) {
                                  ref.refresh(signInProvider);
                                });
                                return ErrorHandleWidget(
                                  error: _.error,
                                );
                              },
                            ),
                        const SizedBox(height: 7),
                        GestureDetector(
                          onTap: () {
                            context.nav.pushNamed(Routes.forgetPass);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text(
                                'Forgot Password',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            context.nav.pushNamed(Routes.signUp);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Don't have any account?\t",
                                style: TextStyle(fontSize: 10),
                              ),
                              Text(
                                'SignUp here',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
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
