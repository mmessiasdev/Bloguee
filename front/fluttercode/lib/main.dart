import 'package:Bloguee/component/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:Bloguee/route/route.dart';
import 'package:Bloguee/route/page.dart';
import 'package:flutter/services.dart';


Future main() async {
  // await dotenv.load(fileName: ".env");
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: TerciaryColor, // cor da barra superior
    statusBarIconBrightness: Brightness.dark, // ícones da barra superior
    systemNavigationBarColor: SecudaryColor, // cor da barra inferior
    systemNavigationBarIconBrightness:
        Brightness.dark, // ícones da barra inferior
  ));

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPage.list,
      initialRoute: AppRoute.dashboard,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      builder: EasyLoading.init(),
      theme: ThemeData(
        fontFamily: 'Montserrat'
      ),
    );
  }
}
