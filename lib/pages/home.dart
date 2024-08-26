import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:gexchange/controllers/exchange_controller.dart';
import 'package:gexchange/models/configuration.dart';
import 'package:gexchange/pages/result.dart';
import 'package:gexchange/pages/settings.dart';

import '../utils/config.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controller = TextEditingController();

  bool carregando = false;

  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(
        child: Scaffold(
          drawer: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Settings()));
                      },
                      child: Text("Configuration"))
                ],
              ),
            ),
          ),
          appBar: AppBar(
            centerTitle: true,
            title: Text("Exchange"),
            backgroundColor: AppColors.primaryColor,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 28.0, right: 28),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) return "Insira o valor";
                    },
                    keyboardType: TextInputType.number,
                    style:
                        TextStyle(fontSize: 12, color: AppColors.primaryColor),
                    controller: controller,
                    cursorColor: AppColors.primaryColor,
                    decoration: InputDecoration(
                        filled: true,
                        prefixIcon: Icon(
                          CupertinoIcons.money_dollar,
                          size: 30,
                          color: Color(0xff157992),
                        ),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff157992)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(11))),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF157992)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(11))),
                        fillColor: AppColors.bgColor,
                        // focusColor: Colors.red,
                        // hoverColor: Colors.red,
                        labelText: 'Valor',
                        labelStyle: TextStyle(color: Color(0xff157992)),
                        border: OutlineInputBorder()),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: TextButton(
                  onPressed: () async {
                    debugPrint("Pesquisando por::: ${controller.text}");

                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        carregando = true;
                      });
                      ExchangeController exchangeController =
                          ExchangeController(
                              exchangeSettings:
                                  GetIt.instance.get<ExchangeConfig>(),
                              value: double.parse(this.controller.text));

                      carregando = false;
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ResultExchange(
                                controller: exchangeController,
                              )));

                      setState(() {
                        carregando = false;
                      });
                    }
                  },
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.primaryColor),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: !carregando
                          ? Text("Converter")
                          : CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
