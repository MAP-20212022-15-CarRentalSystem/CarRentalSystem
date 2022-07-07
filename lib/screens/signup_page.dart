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

class SignUpPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Rental Car',
                  style: TextStyle(
                    fontSize: 50,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'MuseoModerno',
                    // color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                InputFormField(
                  fieldName: 'Email-Id',
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                  name: AppRSC.acEmail,
                ),
                InputFormField(
                  fieldName: 'Password',
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                  obscure: true,
                  name: AppRSC.acPassword,
                ),
                InputFormField(
                  fieldName: 'Re Type Password',
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                  obscure: true,
                  name: AppRSC.acRePassword,
                ),
                const SizedBox(
                  height: 20,
                ),
                ref.watch(signUpProvider).map(
                      initial: (_) => GestureDetector(
                        onTap: () async {
                          // network connectivity
                          final connectivityResult =
                              await Connectivity().checkConnectivity();
                          if (connectivityResult != ConnectivityResult.mobile &&
                              connectivityResult != ConnectivityResult.wifi) {
                            EasyLoading.showError('No Internet');
                            return;
                          }
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.saveAndValidate()) {
                            final fields = _formKey.currentState!.fields;
                            if (fields[AppRSC.acRePassword]!.value ==
                                fields[AppRSC.acRePassword]!.value) {
                              ref.watch(signUpProvider.notifier).signUp(
                                    fields[AppRSC.acEmail]!.value as String,
                                    fields[AppRSC.acPassword]!.value as String,
                                  );
                            } else {
                              EasyLoading.showError("Passwords Don't Match");
                            }
                          }
                        },
                        child: const CustomButton(
                          text: 'Sign Up',
                        ),
                      ),
                      loading: (_) => const LoadingWidget(),
                      loaded: (_) => const MessageWidget(
                        msg: 'Success',
                      ),
                      error: (_) => ErrorHandleWidget(
                        error: _.error,
                      ),
                    ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    context.nav.pushNamed(Routes.login);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Already a registered user?\t',
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        'Login here',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
