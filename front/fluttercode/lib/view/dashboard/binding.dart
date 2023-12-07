import 'package:get/get.dart';
import 'package:Bloguee/controller/auth.dart';
import 'package:Bloguee/controller/dashboard.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(AuthController());
  }
}