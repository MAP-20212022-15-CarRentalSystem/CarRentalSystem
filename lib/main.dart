import 'package:car_rental_system/firebase_options.dart';
import 'package:car_rental_system/utils/context_less.dart';
import 'package:car_rental_system/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return MaterialApp(
      supportedLocales: const [
        Locale('en'),
      ],
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
      ],
      title: 'Rental_car',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primaryColor: const Color.fromRGBO(0, 0, 0, 1),
      ),
      initialRoute: Routes.splash,
      onGenerateRoute: generatedRoutes,
      navigatorKey: ContextLess.navigatorkey,
      builder: EasyLoading.init(),
    );
  }
}

class AuthenticationWrapper extends StatefulWidget {
  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 100),
    ).then((value) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        context.nav.pushNamedAndRemoveUntil(Routes.home, (route) => false);
      } else {
        context.nav.pushNamedAndRemoveUntil(Routes.login, (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
