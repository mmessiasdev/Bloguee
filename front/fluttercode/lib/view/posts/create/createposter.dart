import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttercode/component/buttomdefault.dart';
import 'package:fluttercode/component/colors.dart';
import 'package:fluttercode/component/header.dart';
import 'package:fluttercode/component/inputdefault.dart';
import 'package:fluttercode/component/texts.dart';
import 'package:fluttercode/controller/controllers.dart';
import 'package:fluttercode/service/local_service/local_auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'package:http_parser/http_parser.dart';

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

  List<int>? selectFile;
  Uint8List? bytesData;

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
          bytesData =
              Base64Decoder().convert(reader.result.toString().split(",").last);
          selectFile = bytesData;
        });
      });
      reader.readAsDataUrl(file);
    });
  }

  // Future upload() async {
  //   var url = Uri.parse("http://localhost:1337/api/upload/");
  //   var request = http.MultipartRequest("POST", url);
  //   request.files.add(await http.MultipartFile.fromBytes(
  //     'files',
  //     selectFile!,
  //     contentType: MediaType('application', 'pdf'),
  //     filename: "FileTest",
  //   ));
  //   request.files
  //       .add(await http.MultipartFile.fromString("ref", "api::poster.poster"));
  //   request.files.add(await http.MultipartFile.fromString("refId", "2"));
  //   request.files.add(await http.MultipartFile.fromString("field", "files"));

  //   // request.headers.addAll({"Authorization": "Bearer $token"});
  //   request.send().then((response) {
  //     if (response.statusCode == 200) {
  //       print("FileUpload Successfuly");
  //     } else {
  //       print("FileUpload Error");
  //     }
  //   });
  // }

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
                    padding: const EdgeInsets.only(top: 20),
                    child: InputTextButton(
                      onClick: () {
                        startPicker();
                      },
                      title: 'Add PDF',
                      color: PrimaryColor,
                    )),
                bytesData != null ? Text(bytesData.toString()) : Container(),
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
