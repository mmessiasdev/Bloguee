import 'package:fluttercode/controller/map.dart';
import 'package:fluttercode/model/locals.dart';
import 'package:flutter/material.dart';
import 'package:fluttercode/component/header.dart';
import 'package:fluttercode/service/local_service/local_auth_service.dart';
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
        SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 60,
                  child: GestureDetector(
                    child: Container(
                      width: 100,
                      height: 25,
                      color: Color.fromARGB(255, 119, 119, 119),
                      child: Center(
                        child: Text(
                          fullName == "null" ? "Login" : fullName,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                        ),
                      ),
                    ),
                    // child: CircleAvatar(
                    //   backgroundColor: TerciaryColor,
                    //   child: Icon(
                    //     Icons.person,
                    //     color: Colors.white,
                    //     size: 30,
                    //   ),
                    // ),
                    // onTap: () {
                    //   getLocalList();
                    //   print(getLocalList());
                    // },
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AccountScreen(),
                      ),
                    ),
                  ),
                ),
              ),
            )),
        Text(
          fullName == "null" ? "Faça Login" : fullName,
          // authController.user.value == null
          //     ? "Faça Login"
          //     : authController.user.value!.fullName!,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(146, 146, 146, 1),
          ),
        ),
      ],
    ));
  }
}
