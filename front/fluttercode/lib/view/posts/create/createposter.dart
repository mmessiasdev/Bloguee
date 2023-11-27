import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttercode/component/buttomdefault.dart';
import 'package:fluttercode/component/colors.dart';
import 'package:fluttercode/component/header.dart';
import 'package:fluttercode/component/inputdefault.dart';
import 'package:fluttercode/component/texts.dart';
import 'package:fluttercode/controller/controllers.dart';
import 'package:fluttercode/extention/string_extention.dart';
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

  List<int>? _selectFile;
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
          _selectFile = _bytesData;
        });
      });
      reader.readAsDataUrl(file);
    });
  }

  Future upload() async {
    var dio = Dio();

    if (_bytesData != null) {
      FormData data = FormData.fromMap({
        "ref": "api::poster.poster",
        "files": http.MultipartFile.fromBytes('files', _bytesData!,
            filename: 'documento'),
        "refId": 2,
        "field": "files",
      });
      var response = dio.post("http://localhost:1337/api/upload/", data: data);
      print(response.toString());
    } else {
      print("Result is Null");
    }
  }

  //  Future uploadImage() async {
  //   var url = Uri.parse('http://localhost:1337/api/upload/');
  //   var request = http.MultipartRequest("POST", url);
  //   request.files.add(
  //     await http.MultipartFile.fromBytes('files', _selectFile!,
  //         filename: id.toString()),
  //   );
  //   request.send().then((response) => {
  //         if (response.statusCode == 200)
  //           {print("Send File")}
  //         else
  //           {print('Send Erro')}
  //       });
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
                      title: 'Add File',
                      color: PrimaryColor,
                    )),
                _bytesData != null
                    ? Image.memory(
                        _bytesData!,
                        width: 200,
                        height: 200,
                      )
                    : Container(),
                InputTextButton(
                    title: 'Postar Documento',
                    onClick: () {
                      upload();
                    }),
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
            ),
          ),
        ),
      ],
    );
  }
}
