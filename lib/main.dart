import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:gexchange/pages/home.dart';
import 'package:gexchange/pages/result.dart';
import 'package:gexchange/utils/config.dart';

void main() {
  runApp(const App());
  Config.init();
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}
