import 'package:fluttercode/component/texts.dart';
import 'package:fluttercode/service/local/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttercode/component/header.dart';
import 'package:fluttercode/controller/controllers.dart';

import '../../component/buttomdefault.dart';
import '../../component/colors.dart';
import '../../component/infoinputlogin.dart';
import 'auth/signin.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
    return SizedBox(
      child: ListView(
        children: [
          MainHeader(title: "Voltar", onClick: () => Navigator.pop(context)),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: Column(
              children: [
                PrimaryText(
                    text: 'Perfil', color: nightColor, align: TextAlign.center),
                SizedBox(
                  height: 30,
                ),
                InfoInputLogin(
                  title: 'Nome:',
                  info: lname == null ? "" : lname,
                ),
                InfoInputLogin(
                  title: 'Email:',
                  info: email == null ? "" : email,
                ),
                InfoInputLogin(
                  title: 'id:',
                  info: id == null ? "" : id,
                ),
                SizedBox(
                  height: 30,
                ),
                InputTextButton(
                  color: FifthColor,
                  title: token == null ? "Entrar" : "Sair da conta",
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
