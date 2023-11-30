import 'package:fluttercode/controller/map.dart';
import 'package:fluttercode/model/locals.dart';
import 'package:flutter/material.dart';
import 'package:fluttercode/component/header.dart';
import 'package:fluttercode/service/local_service/local_auth_service.dart';
import 'package:fluttercode/view/account/account_screen.dart';
import 'package:fluttercode/view/account/auth/sign_in_screen.dart';
import 'package:fluttercode/view/posts/post/postscreen.dart';
import 'package:fluttercode/view/home/search/searchpost.dart';
import 'package:get/get.dart';

import '../../component/colors.dart';
import '../../component/texts.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controllerMap = Get.put(MapController());
  Attributes? data;

  var email;
  var lname;
  var id;
  var token;

  @override
  void initState() {
    super.initState();
    getString();
  }

  void getString() async {
    var strEmail = await LocalAuthService().getEmail("email");
    var strFull = await LocalAuthService().getLname("lname");
    var strId = await LocalAuthService().getId("id");
    var strToken = await LocalAuthService().getSecureToken("token");

    setState(() {
      email = strEmail.toString();
      lname = strFull.toString();
      id = strId.toString();
      token = strToken.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    controllerMap.getPosition();

    return SafeArea(
        child: Column(
      children: [
        MainHeader(
            title: lname == null ? "Login" : lname,
            onClick: () => lname == "null"
                ? (Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInScreen(),
                    ),
                  ))
                : (Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccountScreen(),
                    ),
                  ))),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  showSearch(context: context, delegate: SearchPosts());
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: PrimaryColor,
                  ),
                  height: 50,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: SizedBox(
                        width: double.infinity,
                        child: SubText(
                            text: "Qual sua dúvida?",
                            color: SecudaryColor,
                            align: TextAlign.start),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ));
  }
}
