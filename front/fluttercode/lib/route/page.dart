import 'package:fluttercode/view/account/auth/signin.dart';
import 'package:get/get.dart';
import 'package:fluttercode/route/route.dart';
import 'package:fluttercode/view/dashboard/binding.dart';
import 'package:fluttercode/view/dashboard/screen.dart';

class AppPage {
  static var list = [
    GetPage(
      name: AppRoute.loginIn,
      page: () => const SignInScreen(),
    ),
    GetPage(
        name: AppRoute.dashboard,
        page: () => const DashboardScreen(),
        binding: DashboardBinding()),
  ];
}
