import 'package:fluttercode/component/texts.dart';
import 'package:fluttercode/service/local_service/local_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttercode/component/header.dart';
import 'package:fluttercode/controller/controllers.dart';

import '../../component/buttomdefault.dart';
import '../../component/colors.dart';
import '../../component/infoinputlogin.dart';
import 'auth/sign_in_screen.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
    return SizedBox(
      child: ListView(
        children: [
          const MainHeader(),
          Container(
            color: BackgroundOffColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundColor: Color.fromRGBO(112, 53, 64, 1),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        children: [
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
                      ),
                    ],
                  ),
                  GestureDetector(
                    child: Icon(Icons.arrow_back_ios),
                    onTap: () {
                      Navigator.pop(
                        context,
                        // MaterialPageRoute(
                        //   builder: (context) => const SignInScreen(),
                        // ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 50),
          // buildAccountCard(title: "Sobre Nós", onClick: () {}),
          // buildAccountCard(title: "Termos e serviços", onClick: () {}),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                InfoInputLogin(
                  title: 'Nome:',
                  info: fullName == "null" ? "" : fullName,
                  // 'Nome: ${authController.user.value == null ? "" : authController.user.value?.fullName}',
                ),
                InfoInputLogin(
                  title: 'Email:',
                  info: email == "null" ? "" : email,
                  // 'Email: ${authController.user.value == null ? "" : authController.user.value?.email}',
                ),
                InfoInputLogin(
                  title: 'id:',
                  info: id == "null" ? "" : id,
                  // 'Id: ${authController.user.value == null ? "" : authController.user.value?.id}',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InputTextButton(
              title: token == "null" ? "Entrar" : "Sair da conta",
              onClick: () {
                if (token != "null") {
                  authController.signOut();
                  Navigator.pop(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAccountCard(
      {required String title, required Function() onClick}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: GestureDetector(
        onTap: () {
          onClick();
        },
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SubText(text: title, color: TerciaryColor, align: TextAlign.start)
            ],
          ),
        ),
      ),
    );
  }
}
