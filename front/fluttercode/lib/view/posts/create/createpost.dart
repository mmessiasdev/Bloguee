import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttercode/component/buttomborder.dart';
import 'package:fluttercode/component/buttomdefault.dart';
import 'package:fluttercode/component/colors.dart';
import 'package:fluttercode/component/header.dart';
import 'package:fluttercode/component/inputdefault.dart';
import 'package:fluttercode/component/texts.dart';
import 'package:fluttercode/controller/controllers.dart';
import 'package:fluttercode/service/local/auth.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'package:http_parser/http_parser.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
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

  List<int>? selectFile;
  Uint8List? _bytesData;

  startPicker() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      final file = files![0];
      final reader = html.FileReader();

      reader.onLoadEnd.listen((event) {
        setState(() {
          _bytesData =
              Base64Decoder().convert(reader.result.toString().split(",").last);
          selectFile = _bytesData;
        });
      });
      reader.readAsDataUrl(file);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MainHeader(title: 'Voltar', onClick: () => Navigator.pop(context)),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 25),
          child: SizedBox(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: PrimaryText(
                      text: 'Crie seu Post',
                      color: nightColor,
                      align: TextAlign.start,
                    ),
                  ),
                ),
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
                    minLines: 1,
                    maxLines: 15,
                    title: 'Conteúdo',
                    textEditingController: content,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: SizedBox(
                      width: double.infinity,
                      child: InputOutlineButton(
                        title: 'Add PDF',
                        onClick: () {
                          startPicker();
                        },
                      ),
                    )),
                SizedBox(
                  height: 50,
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
                          print(selectFile);
                          authController.posting(
                            selectFile: selectFile,
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
            ),
          ),
        ),
      ],
    );
  }
}
