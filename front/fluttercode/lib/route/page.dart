import 'package:Bloguee/view/account/auth/signin.dart';
import 'package:get/get.dart';
import 'package:Bloguee/route/route.dart';
import 'package:Bloguee/view/dashboard/binding.dart';
import 'package:Bloguee/view/dashboard/screen.dart';

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
