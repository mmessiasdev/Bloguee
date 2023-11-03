import 'package:fluttercode/component/colors.dart';
import 'package:fluttercode/component/header.dart';
import 'package:fluttercode/component/inputlight.dart';
import 'package:fluttercode/component/texts.dart';
import 'package:fluttercode/controller/controllers.dart';
import 'package:flutter/material.dart';

import '../../component/buttomdefault.dart';
import '../account/account_screen.dart';
import 'complaintlist.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({Key? key}) : super(key: key);

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

enum Type {
  agres,
  humilh,
  chant,
  perseg,
  viold,
  assedv,
  assedp,
  assedps,
  assedf,
  out
}

enum Nivel { low, normal, high }

class _ComplaintScreenState extends State<ComplaintScreen> {
  Type? selectType;
  Nivel? selectNivel;
  String type = "";
  String nivel = "";
  TextEditingController descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          MainHeader(          onClick: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AccountScreen(),
              ),
            ),
          },),
          Expanded(
            child: Container(
              color: TerciaryColorOff,
              child: Container(
                color: TerciaryColorOff,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Column(
                            children: [
                              PrimaryText(
                                text: 'Precisa de ajuda?',
                                color: lightColor,
                                align: TextAlign.center,
                              ),
                              SubText(
                                text:
                                    'Escolha as opções que mais se assemelham ao ocorrido',
                                color: OffColor,
                                align: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(),
                              GestureDetector(
                                child: Row(
                                  children: [
                                    Icon(Icons.list, color: SecudaryColor),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    SubText(
                                        text: 'Ver denúncias',
                                        color: SecudaryColor,
                                        align: TextAlign.end)
                                  ],
                                ),
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ComplaintList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 50),
                          child: SizedBox(
                            height: 160,
                            child: GridView(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 98,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                mainAxisExtent: 41,
                              ),
                              children: [
                                ButtomCont(
                                  text: 'Agressão',
                                  cor: selectType == Type.agres
                                      ? lightColor
                                      : TerciaryColor,
                                  onClick: () {
                                    setState(() {
                                      selectType = Type.agres;
                                      type = "Agressão";
                                      print(type);
                                    });
                                  },
                                ),
                                ButtomCont(
                                  text: 'Chantagem',
                                  cor: selectType == Type.chant
                                      ? lightColor
                                      : TerciaryColor,
                                  onClick: () {
                                    setState(() {
                                      selectType = Type.chant;
                                      type = "Chantagem";
                                      print(type);
                                    });
                                  },
                                ),
                                ButtomCont(
                                  text: 'Humilhação',
                                  cor: selectType == Type.humilh
                                      ? lightColor
                                      : TerciaryColor,
                                  onClick: () {
                                    setState(() {
                                      type = "Humilhação";
                                      print(type);
                                    });
                                  },
                                ),
                                ButtomCont(
                                  text: 'Perseguição',
                                  cor: selectType == Type.perseg
                                      ? lightColor
                                      : TerciaryColor,
                                  onClick: () {
                                    setState(() {
                                      selectType = Type.perseg;
                                      type = "Perseguição";
                                      print(type);
                                    });
                                  },
                                ),
                                ButtomCont(
                                  text: 'Violência \nPatrimonial',
                                  cor: selectType == Type.assedp
                                      ? lightColor
                                      : TerciaryColor,
                                  onClick: () {
                                    setState(() {
                                      selectType = Type.assedp;
                                      type = "Violência Patrimonial";
                                      print(type);
                                    });
                                  },
                                ),
                                ButtomCont(
                                  text: 'Assédio \nVerbal',
                                  cor: selectType == Type.assedv
                                      ? lightColor
                                      : TerciaryColor,
                                  onClick: () {
                                    setState(() {
                                      selectType = Type.assedv;
                                      type = "Assédio Verbal";
                                      print(type);
                                    });
                                  },
                                ),
                                ButtomCont(
                                  text: 'Assédio \nPsicológico',
                                  cor: selectType == Type.assedps
                                      ? lightColor
                                      : TerciaryColor,
                                  onClick: () {
                                    setState(() {
                                      selectType = Type.assedps;
                                      type = "Assédio Psicológico";
                                      print(type);
                                    });
                                  },
                                ),
                                ButtomCont(
                                  text: 'Assédio \nFísico',
                                  cor: selectType == Type.assedf
                                      ? lightColor
                                      : TerciaryColor,
                                  onClick: () {
                                    setState(() {
                                      selectType = Type.assedf;
                                      type = "Assédio Físico";
                                      print(type);
                                    });
                                  },
                                ),
                                ButtomCont(
                                  text: 'Outros',
                                  cor: selectType == Type.out
                                      ? lightColor
                                      : TerciaryColor,
                                  onClick: () {
                                    setState(() {
                                      selectType = Type.out;
                                      type = "Outros";
                                      print(type);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: PrimaryColor,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 10),
                                child: Center(
                                  child: Column(
                                    children: [
                                      SubText(
                                        text:
                                            'Qual o nível de risco do problema?',
                                        color: lightColor,
                                        align: TextAlign.center,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            NivelButtom(
                                              title: 'baixo',
                                              color: SecudaryColor,
                                              backc: selectNivel == Nivel.low
                                                  ? PrimaryColor
                                                  : TerciaryColor,
                                              onClick: () {
                                                setState(() {
                                                  selectNivel = Nivel.low;
                                                  nivel = "Baixo";
                                                  print(nivel);
                                                });
                                              },
                                            ),
                                            NivelButtom(
                                              title: 'médio',
                                              color: SecudaryColor,
                                              backc: selectNivel == Nivel.normal
                                                  ? PrimaryColor
                                                  : TerciaryColor,
                                              onClick: () {
                                                setState(() {
                                                  selectNivel = Nivel.normal;
                                                  nivel = "Médio";
                                                  print(nivel);
                                                });
                                              },
                                            ),
                                            NivelButtom(
                                              title: 'alto',
                                              backc: selectNivel == Nivel.high
                                                  ? PrimaryColor
                                                  : TerciaryColor,
                                              color: SecudaryColor,
                                              onClick: () {
                                                setState(() {
                                                  selectNivel = Nivel.high;
                                                  nivel = "Alto";
                                                  print(nivel);
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 60),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                SizedBox(
                                  child: SubText(
                                    text:
                                        'Caso queria, nos conte como se sente...',
                                    color: lightColor,
                                    align: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: InputTextFieldLight(
                                      title: 'Como se sente?',
                                      textEditingController: descController),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: InputTextButton(
                            title: 'Enviar',
                            onClick: () {
                              if (_formKey.currentState!.validate()) {
                                authController.complaining(
                                    type: type,
                                    nivel: nivel,
                                    desc: descController.text);
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ButtomCont extends StatelessWidget {
  ButtomCont(
      {Key? key, required this.text, required this.onClick, required this.cor})
      : super(key: key);
  String text;
  final Function onClick;
  final Color cor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        decoration: BoxDecoration(
          color: cor,
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
          border: Border.all(
            width: 1,
            color: SecudaryColor,
          ),
        ),
        child: Center(
            child: SubText(
                text: text, color: SecudaryColor, align: TextAlign.center)),
      ),
      onTap: () {
        onClick();
      },
    );
  }
}

class NivelButtom extends StatelessWidget {
  NivelButtom(
      {Key? key,
      required this.title,
      required this.color,
      this.onClick,
      required this.backc})
      : super(key: key);
  String title;
  Color color;
  Color backc;
  final Function? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration:
            BoxDecoration(color: backc, border: Border.all(color: lightColor)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: SubText(text: title, color: color, align: TextAlign.center),
        ),
      ),
      onTap: () {
        onClick!();
      },
    );
  }
}
