import 'package:get/get.dart';
import 'package:fluttercode/controller/auth.dart';
import 'package:fluttercode/controller/dashboard.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(AuthController());
  }
}