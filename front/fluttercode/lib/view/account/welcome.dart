import 'package:flutter/material.dart';
import 'package:Bloguee/component/buttomdefault.dart';
import 'package:Bloguee/component/texts.dart';
import 'package:Bloguee/view/account/auth/signin.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 75),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: PrimaryText(
                text: "Bem vindo ao Bloguee! \nFaça Login ; )",
                color: Colors.black,
                align: TextAlign.start),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: InputTextButton(
              title: "Login",
              onClick: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
