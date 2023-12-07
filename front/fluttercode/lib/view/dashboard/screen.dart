import 'package:Bloguee/service/local/auth.dart';
import 'package:Bloguee/view/account/welcome.dart';
import 'package:Bloguee/view/chunk/chunk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:Bloguee/view/posts/posts.dart';
import 'package:get/get.dart';
import 'package:Bloguee/component/colors.dart';
import 'package:Bloguee/controller/dashboard.dart';
import 'package:Bloguee/view/home/home.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var token;
  var chunkId;

  @override
  void initState() {
    super.initState();
    getString();
  }

  void getString() async {
    var strToken = await LocalAuthService().getSecureToken("token");
    var strChunkId = await LocalAuthService().getChunkId("chunk");

    setState(() {
      token = strToken.toString();
      chunkId = strChunkId.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: token == "null"
          ? WelcomeScreen()
          : SizedBox(
              child: chunkId == "null"
                  ? SizedBox()
                  : GetBuilder<DashboardController>(
                      builder: (controller) => Scaffold(
                        backgroundColor: lightColor,
                        body: SafeArea(
                          child: IndexedStack(
                            index: controller.tabIndex,
                            children: [
                              HomeScreen(),
                              PostsScreen(),
                              ChunkScreen(),
                            ],
                          ),
                        ),
                        bottomNavigationBar: Container(
                          height: 70,
                          decoration: BoxDecoration(
                            color: SecudaryColor,
                          ),
                          child: SnakeNavigationBar.color(
                            snakeShape: SnakeShape.rectangle,
                            backgroundColor: SecudaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            unselectedItemColor: OffColor,
                            showUnselectedLabels: true,
                            snakeViewColor: SecudaryColor,
                            currentIndex: controller.tabIndex,
                            onTap: (val) {
                              controller.updateIndex(val);
                            },
                            items: const [
                              BottomNavigationBarItem(
                                  icon: Icon(Icons.home_rounded),
                                  label: 'Home'),
                              BottomNavigationBarItem(
                                  icon: Icon(Icons.text_format_rounded),
                                  label: 'Posts'),
                              BottomNavigationBarItem(
                                  icon: Icon(Icons.corporate_fare),
                                  label: 'Informações')
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
    );
  }
}
