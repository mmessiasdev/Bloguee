import 'package:flutter/material.dart';
import 'package:fluttercode/component/colors.dart';
import 'package:fluttercode/component/header.dart';
import 'package:fluttercode/component/texts.dart';
import 'package:fluttercode/controller/controllers.dart';
import 'package:fluttercode/extention/string_extention.dart';

import '../../../component/buttomborder.dart';
import '../../../component/buttomdefault.dart';
import '../../../component/inputdefault.dart';
import 'sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: ListView(
          children: [
            MainHeader(
                title: "Voltar", onClick: () => (Navigator.pop(context))),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, top: 75),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: PrimaryText(
                            text: 'Criar Conta',
                            color: nightColor,
                            align: TextAlign.start),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: InputTextField(
                            title: 'Nome Completo',
                            // icon: Icon(Icons.person),
                            textEditingController: fullNameController,
                            validation: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Esse campo não pode ficar vazio.";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: InputTextField(
                          title: 'Email',
                          // icon: Icon(Icons.email_rounded),
                          textEditingController: emailController,
                          validation: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Esse campo não pode ficar vazio.";
                            } else if (!value.isValidEmail) {
                              return "Esse email não é válido";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: InputTextField(
                          title: 'Senha',
                          // icon: Icon(Icons.lock),
                          obsecureText: true,
                          textEditingController: passwordController,
                          validation: (String? value) {
                            List<String> _validation = [];
                            if (value == null || value.isEmpty) {
                              return "Esse campo não pode ficar vazio.";
                            } else {
                              if (!value.isValidPasswordHasNumber) {
                                _validation
                                    .add("Sua senha precisa conter numeros");
                              }
                              if (!value.isValidPasswordHasCapitalLetter) {
                                _validation.add(
                                    "Sua senha precisa conter letras maiuscular");
                              }
                              if (!value.isValidPasswordHasLowerCaseLetter) {
                                _validation
                                    .add("Sua senha precisa conter letras");
                              }
                            }
                            String msg = '';
                            if (_validation.isNotEmpty) {
                              for (var i = 0; i < _validation.length; i++) {
                                msg = msg + _validation[i];
                                if ((i + 1) != _validation.length) {
                                  msg = msg + "\n";
                                }
                              }
                            }
                            return msg.isNotEmpty ? msg : null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: InputTextField(
                          // icon: Icon(Icons.lock),
                          title: 'Confirme sua Senha',
                          obsecureText: true,
                          textEditingController: confirmController,
                          validation: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Esse campo não pode ficar vazio.";
                            } else if (passwordController.text != value) {
                              return "Confirm password not match";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: InputTextButton(
                          title: "Criar Conta",
                          onClick: () {
                            if (_formKey.currentState!.validate()) {
                              authController.signUp(
                                fullName: fullNameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Eu já tenho uma conta, "),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignInScreen()));
                              },
                              child: const Text(
                                "Fazer Login",
                                style: TextStyle(color: Colors.blue),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
