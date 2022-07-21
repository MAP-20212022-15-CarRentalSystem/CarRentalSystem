import 'package:car_rental_system/constants/duration_contants.dart';
import 'package:car_rental_system/main.dart';
import 'package:car_rental_system/screens/car_registration.dart';
import 'package:car_rental_system/screens/edit_car_screen.dart';
import 'package:car_rental_system/screens/edit_profile_screen.dart';
import 'package:car_rental_system/screens/forgot_password_page.dart';
import 'package:car_rental_system/screens/home_page.dart';
import 'package:car_rental_system/screens/home_page/car_list_screen.dart';
import 'package:car_rental_system/screens/login_page.dart';
import 'package:car_rental_system/screens/report.dart';
import 'package:car_rental_system/screens/reviews.dart';
import 'package:car_rental_system/screens/ride_history.dart';
import 'package:car_rental_system/screens/search_drop_off.dart';
import 'package:car_rental_system/screens/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  Routes._();
  //core
  static const splash = '/';
  static const home = '/homePage';
  //user
  static const login = '/loginPage';
  static const signUp = '/signUpPage';
  static const forgetPass = '/forgetPass';
  static const editProfile = '/editProfile';

  //Trip
  static const searchDropOff = '/searchDropOff';
  static const tripHistory = '/tripHistory';
  static const tripReview = '/tripReview';
  static const tripReport = '/Report';
  //Vehicle
  static const registerCar = '/registerCar';
  static const editCar = '/editCar';
  static const carList = '/carList';
}

Route generatedRoutes(RouteSettings settings) {
  Widget child;
  switch (settings.name) {
    case Routes.splash:
      child = AuthenticationWrapper();
      break;
    case Routes.home:
      child = HomePage();
      break;
    //user routes
    case Routes.login:
      child = LoginPage();
      break;
    case Routes.signUp:
      child = SignUpPage();
      break;
    case Routes.forgetPass:
      child = ForgetPassword();
      break;
    case Routes.editProfile:
      child = EditProfile();
      break;
    //Trip
    case Routes.searchDropOff:
      child = SearchDropOffLocation();
      break;
    case Routes.tripHistory:
      child = const RideHistory();
      break;

    case Routes.tripReview:
      child = RideReviews(settings.arguments! as String);
      break;
    case Routes.tripReport:
      child = const Report();
      break;
    //Vehicle
    case Routes.registerCar:
      child = VehicleRegistration();
      break;
    case Routes.editCar:
      child = EditCar();
      break;
    //
    case Routes.carList:
      child = CarList(
        cost: settings.arguments! as int,
      );
      break;

    default:
      throw Exception('Invalid route: ${settings.name}');
  }
  return PageTransition(
    child: child,
    type: PageTransitionType.fade,
    settings: settings,
    duration: AppDurConst.transissionDuration,
    reverseDuration: AppDurConst.transissionDuration,
  );
}
