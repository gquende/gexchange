import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:gexchange/models/configuration.dart';
import 'package:gexchange/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  static late ExchangeConfig exchangeConfig;
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late ExchangeConfig exchangeConfig;

  TextEditingController taxaComissaoCarregamento = TextEditingController();
  TextEditingController taxaIVAComissaoCarregamento = TextEditingController();
  TextEditingController taxaComissaoCompra = TextEditingController();
  TextEditingController taxaIVAComissaoCompra = TextEditingController();
  TextEditingController taxaWise = TextEditingController();
  TextEditingController exchangeSellValue = TextEditingController();
  TextEditingController exchangeBuyValue = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    init();
  }

  Future init() async {
    var shared = await SharedPreferences.getInstance();

    if (shared.getString("config") == null) {
      exchangeConfig = GetIt.instance.get<ExchangeConfig>();
    } else {
      exchangeConfig = ExchangeConfig.fromMap(
          jsonDecode(shared.getString("config") as String));
    }
    taxaIVAComissaoCarregamento.text =
        "${exchangeConfig.taxaIVAComissaoCarregamento}";
    taxaComissaoCompra.text = "${exchangeConfig.taxaComissaoCompra}";
    taxaIVAComissaoCompra.text = "${exchangeConfig.taxaIVAComissaoCompra}";
    taxaWise.text = "${exchangeConfig.taxaWise}";
    exchangeSellValue.text = "${exchangeConfig.exchangeSellValue}";
    exchangeBuyValue.text = "${exchangeConfig.exchangeBuyValue}";
    taxaComissaoCarregamento.text =
        "${exchangeConfig.taxaComissaoCarregamento}";
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Configurações"),
      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Cambio Venda'),
                      Container(
                        width: size.width * 0.15,
                        child: TextFormField(
                          controller: exchangeSellValue,
                          keyboardType: TextInputType.number,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Cambio Compra'),
                      Container(
                        width: size.width * 0.15,
                        child: TextFormField(
                          controller: exchangeBuyValue,
                          keyboardType: TextInputType.number,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Comissao de Carregamento'),
                      Container(
                        width: size.width * 0.15,
                        child: TextFormField(
                          controller: taxaComissaoCarregamento,
                          keyboardType: TextInputType.number,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('IVA Comissao Carregamento'),
                      Container(
                        width: size.width * 0.15,
                        child: TextFormField(
                          controller: taxaIVAComissaoCarregamento,
                          keyboardType: TextInputType.number,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Comissao de Compra'),
                      Container(
                        width: size.width * 0.15,
                        child: TextFormField(
                          controller: taxaComissaoCompra,
                          keyboardType: TextInputType.number,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('IVA Comissao Compra'),
                      Container(
                        width: size.width * 0.15,
                        child: TextFormField(
                          controller: taxaIVAComissaoCompra,
                          keyboardType: TextInputType.number,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Taxa Wise'),
                      Container(
                        width: size.width * 0.15,
                        child: TextFormField(
                          controller: taxaWise,
                          keyboardType: TextInputType.number,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () async {
                        exchangeConfig.taxaWise = double.parse(taxaWise.text);
                        exchangeConfig.taxaIVAComissaoCompra =
                            double.parse(taxaIVAComissaoCompra.text);
                        exchangeConfig.taxaIVAComissaoCarregamento =
                            double.parse(taxaIVAComissaoCarregamento.text);
                        exchangeConfig.taxaComissaoCompra =
                            double.parse(taxaComissaoCompra.text);
                        exchangeConfig.taxaComissaoCarregamento =
                            double.parse(taxaComissaoCarregamento.text);
                        exchangeConfig.exchangeBuyValue =
                            double.parse(exchangeBuyValue.text);
                        exchangeConfig.exchangeSellValue =
                            double.parse(exchangeSellValue.text);

                        String config = jsonEncode(exchangeConfig.toMap());

                        GetIt.instance.unregister<ExchangeConfig>();
                        GetIt.instance
                            .registerLazySingleton(() => exchangeConfig);

                        var shared = await SharedPreferences.getInstance();

                        shared.remove("config");
                        shared.setString("config", config);

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Configurações salva com sucesso!")));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                            child: Text(
                          "Guardar",
                          style: TextStyle(color: Colors.white),
                        )),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
