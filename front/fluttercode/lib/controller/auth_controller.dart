import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:fluttercode/service/local_service/local_auth_service.dart';
import 'package:fluttercode/service/remote_service/remote_auth_service.dart';
import '../model/user.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  Rxn<User> user = Rxn<User>();
  final LocalAuthService _localAuthService = LocalAuthService();

  @override
  void onInit() async {
    super.onInit();
  }

  void signUp(
      {required String lname,
      required String email,
      required String password}) async {
    try {
      EasyLoading.show(
        status: 'Loading...',
        dismissOnTap: false,
      );
      var result = await RemoteAuthService().signUp(
        email: email,
        password: password,
      );
      if (result.statusCode == 200) {
        String token = json.decode(result.body)['jwt'];
        var userResult = await RemoteAuthService()
            .createProfile(lname: lname, token: token);
        if (userResult.statusCode == 200) {
          user.value = userFromJson(userResult.body);
          EasyLoading.showSuccess("Conta criada. Confirme suas informações.");
          Navigator.of(Get.overlayContext!).pushReplacementNamed('/login');
        } else {
          EasyLoading.showError('Alguma coisa deu errado. Tente novamente!');
        }
      } else {
        EasyLoading.showError('Alguma coisa deu errado. Tente novamente!');
      }
    } catch (e) {
      EasyLoading.showError('Alguma coisa deu errado. Tente novamente!');
    } finally {
      EasyLoading.dismiss();
    }
  }

  void signIn({required String email, required String password}) async {
    try {
      EasyLoading.show(
        status: 'Loading...',
        dismissOnTap: false,
      );
      var result = await RemoteAuthService().signIn(
        email: email,
        password: password,
      );

      if (result.statusCode == 200) {
        String token = json.decode(result.body)['jwt'];
        var userResult = await RemoteAuthService().getProfile(token: token);
        if (userResult.statusCode == 200) {
          var email = jsonDecode(userResult.body)['email'];
          var lname = jsonDecode(userResult.body)['lname'];
          var id = jsonDecode(userResult.body)['id'].toString();
          user.value = userFromJson(userResult.body);
          await LocalAuthService().storeToken(token);
          await LocalAuthService()
              .storeEmail(email: email, lname: lname, id: id);
          var stringEmail = await LocalAuthService().getEmail("email");
          EasyLoading.showSuccess("Bem vindo ao Bloguee");
          Navigator.of(Get.overlayContext!).pushReplacementNamed('/');
        } else {
          EasyLoading.showError(
              'Alguma coisa deu errado. Tente novamente mais tarde...');
        }
      } else {
        EasyLoading.showError('Email ou senha incorreto.');
      }
    } catch (e) {
      debugPrint(e.toString());
      EasyLoading.showError('Alguma coisa deu errado. Tente novamente!');
    } finally {
      EasyLoading.dismiss();
    }
  }

  void posting({required String content}) async {
    try {
      EasyLoading.show(
        status: 'Loading...',
        dismissOnTap: false,
      );
      var token = await LocalAuthService().getSecureToken("token");
      var userResult = await RemoteAuthService()
          .addPost(token: token.toString(), content: content);
      if (userResult.statusCode == 200) {
        EasyLoading.showSuccess("Seu relato foi enviado.");
        Navigator.of(Get.overlayContext!).pushReplacementNamed('/');
      } else {
        EasyLoading.showError('Faça login para realizar um post!');
      }
    } catch (e) {
      print(e);
      EasyLoading.showError('Alguma coisa deu errado.');
    } finally {
      EasyLoading.dismiss();
    }
  }

  void complaining(
      {required String type,
      required String nivel,
      required String desc}) async {
    try {
      EasyLoading.show(
        status: 'Loading...',
        dismissOnTap: false,
      );
      var token = await LocalAuthService().getSecureToken("token");
      var userResult = await RemoteAuthService().addComplaint(
          token: token.toString(), type: type, nivel: nivel, desc: desc);
      if (userResult.statusCode == 200) {
        EasyLoading.showSuccess("Denuncia enviada.");
        Navigator.of(Get.overlayContext!).pushReplacementNamed('/');
      } else {
        EasyLoading.showError('Faça login para realizar uma denúncia.');
      }
    } catch (e) {
      print(e);
      EasyLoading.showError('Alguma coisa deu errado.');
    } finally {
      EasyLoading.dismiss();
    }
  }

  void signOut() async {
    user.value = null;
    await LocalAuthService().clear();
    Navigator.of(Get.overlayContext!).pushReplacementNamed('/login');
  }
}