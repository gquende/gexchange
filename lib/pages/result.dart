import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:gexchange/controllers/exchange_controller.dart';

class ResultExchange extends StatelessWidget {
  //const ResultExchange({Key? key}) : super(key: key);

  ExchangeController controller;
  var formatCurrency =
      NumberFormat.simpleCurrency(locale: "pt_PT", name: "AOA");

  ResultExchange({required this.controller});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Exchange"),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 28.0, right: 10, left: 10),
                child: Container(
                  height: size.height * 0.3,
                  width: size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Valor a converter"),
                      Text(
                        "${controller.valorRealCompra?.toPrecision(2)} EU | USD",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 2),
                            color: Colors.black12,
                            spreadRadius: 3,
                            blurRadius: 13)
                      ]),
                ),
              ),
              Container(
                height: size.height * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CardInformation(
                        "Valor a carregar",
                        formatCurrency.format(controller.valorACarregar
                            ?.toPrecision(3) as double),
                        context),
                    CardInformation(
                        "Taxa de Carregamento",
                        formatCurrency.format(controller.totalTaxaCarregamento
                            ?.toPrecision(3) as double),
                        context),
                    CardInformation(
                        "Taxa de Compra",
                        formatCurrency.format(controller.totalTaxaCompra
                            ?.toPrecision(3) as double),
                        context),
                    CardInformation(
                        "Total de taxas",
                        formatCurrency.format(
                            controller.totalTaxValue?.toPrecision(3) as double),
                        context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget CardInformation(String title, String value, BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Container(
        height: size.height * 0.09,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              Text(
                "$value",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  spreadRadius: 0.4,
                  offset: Offset(0, 1))
            ]),
      ),
    );
  }
}
