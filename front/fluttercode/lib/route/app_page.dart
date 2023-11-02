import 'package:fluttercode/view/account/auth/sign_in_screen.dart';
import 'package:get/get.dart';
import 'package:fluttercode/route/app_route.dart';
import 'package:fluttercode/view/dashboard/dashboard_binding.dart';
import 'package:fluttercode/view/dashboard/dashboard_screen.dart';

class AppPage {
  static var list = [
    GetPage(
        name: AppRoute.dashboard,
        page: () => const DashboardScreen(),
        binding: DashboardBinding()),
    GetPage(
      name: AppRoute.loginIn,
      page: () => const SignInScreen(),
    ),
  ];
}
