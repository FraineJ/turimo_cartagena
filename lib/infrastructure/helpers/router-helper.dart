import 'package:get/get.dart';
import 'package:turismo_cartagena/presentation/modules/auth/login/login.dart';
import 'package:turismo_cartagena/presentation/modules/layuot.dart';

class RouteHelper {
  static const String splashScreen = '/splash';
  static const String loginScreen = '/login';
  static const String homeScreen = '/home';

  static String getSplashScreen() => splashScreen;
  static String getLoginScreen() => loginScreen;
  static String getHomeScreen() => homeScreen;

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => Login()),
    GetPage(name: loginScreen, page: () => Login()),
    GetPage(name: homeScreen, page: () => Layout()),
  ];
}
