import 'package:get/get.dart';
import 'package:yamzi/Modules/screens/common_screen.dart';
import 'package:yamzi/Modules/screens/splash_screen.dart';
import '../Modules/screens/home_Screen.dart';
import '../Modules/screens/login_screen.dart';
import '../Modules/screens/order_screen.dart';
import '../Modules/screens/sign_up_Screen.dart';

class RoutesClass {

  static String splash = '/splash';
  static String login = '/login';
  static String otp = "/otp";
  static String home = "/home";
  static String signup = "/signup";
  static String commonScreen = "/commonScreen";
  static String orderScreen = "/orderScreen";


  static String gotoSplash() => splash;
  static String gotoLogin() => login;
  static String gotohomeScreen() => home;
  static String gotoSignUpScreen() => signup;
  static String gotoCommonScreen() => commonScreen;
  static String gotoOrderScreen() => orderScreen;

  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: login,
      page: () => LoginScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: signup,
      page: () => SignUpScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: home,
      page: () => HomeScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: commonScreen,
      page: () => CommonScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: orderScreen,
      page: () => OrderScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),

  ];
}