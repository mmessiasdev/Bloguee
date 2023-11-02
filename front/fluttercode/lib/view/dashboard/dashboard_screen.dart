import 'package:fluttercode/view/blog/blog_screen.dart';
import 'package:fluttercode/view/complaint/complaint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttercode/component/colors.dart';
import 'package:fluttercode/controller/dashboard_controller.dart';
import 'package:fluttercode/view/home/home_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) => Scaffold(
        backgroundColor: lightColor,
        body: SafeArea(
          child: IndexedStack(
            index: controller.tabIndex,
            children: [
              HomeScreen(),
              BlogPage(),
              ComplaintScreen(),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 70,
          decoration: BoxDecoration(
            color: SecudaryColor,
          ),
          child: SnakeNavigationBar.color(
            backgroundColor: SecudaryColor,
            padding: const EdgeInsets.symmetric(vertical: 5),
            unselectedLabelStyle: GoogleFonts.asap(fontSize: 12),
            unselectedItemColor: OffColor,
            showUnselectedLabels: true,
            snakeViewColor: SecudaryColor,
            currentIndex: controller.tabIndex,
            onTap: (val) {
              controller.updateIndex(val);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.text_format_rounded), label: 'Blog'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.priority_high_rounded), label: 'Denúncias')
            ],
          ),
        ),
      ),
    );
  }
}
