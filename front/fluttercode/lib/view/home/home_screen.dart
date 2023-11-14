import 'package:fluttercode/component/buttomdefault.dart';
import 'package:fluttercode/controller/map.dart';
import 'package:fluttercode/model/locals.dart';
import 'package:flutter/material.dart';
import 'package:fluttercode/component/header.dart';
import 'package:fluttercode/service/local_service/local_auth_service.dart';
import 'package:fluttercode/view/account/auth/sign_in_screen.dart';
import 'package:fluttercode/view/account/auth/sign_up_screen.dart';
import 'package:fluttercode/view/poster/posterscreen.dart';
import 'package:fluttercode/view/search/searchposter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../component/colors.dart';
import '../../component/texts.dart';
import '../account/account_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controllerMap = Get.put(MapController());
  Attributes? data;

  var email;
  var fullName;
  var id;
  var token;

  @override
  void initState() {
    getString();
  }

  void getString() async {
    var strEmail = await LocalAuthService().getEmail("email");
    var strFull = await LocalAuthService().getFull("full");
    var strId = await LocalAuthService().getId("id");
    var strToken = await LocalAuthService().getSecureToken("token");

    setState(() {
      email = strEmail.toString();
      fullName = strFull.toString();
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
            title: fullName == "null" ? "Login" : fullName,
            onClick: () => fullName == "null"
                ? (Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInScreen(),
                    ),
                  ))
                : (Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PosterScreen(),
                    ),
                  ))),
        fullName == "null"
            ? Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 75),
                child: Column(
                  children: [
                    Center(
                      child: SecundaryText(
                          text: "Bem vindo ao Bloguee ;) \n Faça Login!",
                          color: Colors.black,
                          align: TextAlign.start),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: InputTextButton(
                        title: "Login",
                        onClick: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignInScreen()));
                        },
                      ),
                    ),
                  ],
                ),
              )
            : Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PrimaryText(
                      text: "HE Net",
                      color: SecudaryColor,
                      align: TextAlign.center,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: () {
                        showSearch(context: context, delegate: SearchPosters());
                      },
                      child: Container(
                        color: PrimaryColor,
                        width: MediaQuery.of(context).size.width * .8,
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
