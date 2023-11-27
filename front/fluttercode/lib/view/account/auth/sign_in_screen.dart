import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttercode/component/colors.dart';
import 'package:fluttercode/component/header.dart';
import 'package:fluttercode/component/texts.dart';
import 'package:fluttercode/controller/controllers.dart';
import 'package:fluttercode/extention/string_extention.dart';
import 'package:fluttercode/component/buttomdefault.dart';
import 'package:fluttercode/component/buttomborder.dart';
import 'package:fluttercode/component/inputdefault.dart';
import 'package:fluttercode/view/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';

import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool checked = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  late Box infoBox;

  @override
  void initState() {
    super.initState();
    createBox;
  }

  void createBox() async {
    var infoBox = await Hive.openBox('logindata');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          MainHeader(
              title: "Voltar",
              onClick: () => (Navigator.pop(context))),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 75),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: _formKey,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView(
                    children: [
                      // Padding(
                      //   padding: EdgeInsets.all(25),
                      //   child: SizedBox(
                      //     height: 274,
                      //     child: Image(
                      //       image:
                      //           AssetImage('assets/images/ilustration/login.png'),
                      //       fit: BoxFit.contain,
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: PrimaryText(
                            text: 'Login',
                            color: nightColor,
                            align: TextAlign.start),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: InputTextField(
                          title: 'Email',
                          // icon: Icon(Icons.email_rounded),
                          textEditingController: emailController,
                          validation: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Esse campo não pode ficar vazio.";
                            } else if (!value.isValidEmail) {
                              return "Insira um email válido.";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: InputTextField(
                          title: 'Password',
                          obsecureText: true,
                          maxLines: 1,
                          // icon: Icon(Icons.lock),
                          textEditingController: passwordController,
                          validation: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Esse campo não pode ficar vazio.";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: InputTextButton(
                          title: "Login",
                          onClick: () {
                            if (_formKey.currentState!.validate()) {
                              authController.signIn(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                        ),
                      ),
                      // const SizedBox(height: 10),
                      // InputOutlineButton(
                      //   title: "Voltar",
                      //   onClick: () {
                      //     Navigator.of(Get.overlayContext!)
                      //         .pushReplacementNamed('/');
                      //   },
                      // ),
                      const SizedBox(height: 10),
                      // InkWell(
                      //   onTap: () {},
                      //   child: SubText(
                      //     align: TextAlign.end,
                      //     color: Color.fromRGBO(19, 68, 90, 1),
                      //     text: 'Esqueceu a senha?',
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("É um novo usário? "),
                            InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpScreen()));
                                },
                                child: const Text(
                                  "Crie uma conta.",
                                  style: TextStyle(
                                    color: Color.fromRGBO(19, 68, 90, 1),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(height: 10)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
