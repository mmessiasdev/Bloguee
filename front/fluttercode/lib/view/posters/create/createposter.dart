import 'package:flutter/material.dart';
import 'package:fluttercode/component/buttomdefault.dart';
import 'package:fluttercode/component/colors.dart';
import 'package:fluttercode/component/inputdefault.dart';
import 'package:fluttercode/controller/controllers.dart';
import 'package:fluttercode/extention/string_extention.dart';
import 'package:fluttercode/service/local_service/local_auth_service.dart';
import 'package:http/http.dart' as http;

class CreatePoster extends StatefulWidget {
  const CreatePoster({super.key});

  @override
  State<CreatePoster> createState() => _CreatePosterState();
}

class _CreatePosterState extends State<CreatePoster> {
  var client = http.Client();

  var token;
  var id;
  var chunk;

  @override
  void initState() {
    super.initState();
    getString();
  }

  void getString() async {
    var strId = await LocalAuthService().getId("id");
    var strChunk = await LocalAuthService().getId("chunk");
    var strToken = await LocalAuthService().getSecureToken("token");

    setState(() {
      id = strId;
      chunk = strChunk;
      token = strToken.toString();
    });
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController content = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();

  @override
  void dispose() {
    content.dispose();
    title.dispose();
    desc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(chunk);
    print(title.text);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: InputTextField(
            title: 'Titulo',
            textEditingController: title,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: InputTextField(
            title: 'Descrição',
            textEditingController: desc,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: InputTextField(
            title: 'Conteúdo',
            textEditingController: content,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 20),
          child: InputTextButton(
              title: "Enviar",
              color: FourtyColor,
              onClick: () {
                setState(() {
                  print(title.text);
                  print(desc.text);
                  print(content.text);
                  print(chunk);
                  print(id);
                  authController.postering(
                    title: title.text,
                    desc: desc.text,
                    content: content.text,
                    chunkId: int.parse(chunk),
                    profileId: int.parse(id),
                  );
                });
              }),
        ),
      ],
    );
  }
}
