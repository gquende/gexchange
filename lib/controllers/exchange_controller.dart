import 'package:get/get.dart';
import 'package:gexchange/models/configuration.dart';

class ExchangeController extends GetxController {
  ExchangeConfig exchangeSettings;
  double value;
  double? totalTaxValue;
  double? ivaComissaoCarregamento;
  double? comissaoCarregamento;
  double? ivaComissaoCompra;
  double? comissaoCompra;
  double? valorACarregar;
  double? totalTaxaCarregamento;
  double? totalTaxaCompra;
  double? valorRealCompra;
  double? lucro;
  ExchangeController({required this.exchangeSettings, required this.value}) {
    this.valorRealCompra =
        (this.value + this.value * exchangeSettings.taxaWise);

    this.ivaComissaoCompra =
        (this.valorRealCompra! * this.exchangeSettings.exchangeBuyValue) *
            exchangeSettings.taxaIVAComissaoCompra;
    this.comissaoCompra =
        (this.valorRealCompra! * this.exchangeSettings.exchangeBuyValue) *
            exchangeSettings.taxaComissaoCompra;

    this.totalTaxaCompra = this.ivaComissaoCompra! + this.comissaoCompra!;

    this.valorACarregar =
        this.valorRealCompra! * exchangeSettings.exchangeBuyValue +
            this.totalTaxaCompra!;

    this.comissaoCarregamento =
        this.valorACarregar! * exchangeSettings.taxaComissaoCarregamento;

    this.ivaComissaoCarregamento =
        this.valorACarregar! * exchangeSettings.taxaIVAComissaoCarregamento;

    this.totalTaxaCarregamento =
        this.comissaoCarregamento! + this.ivaComissaoCarregamento!;

    this.totalTaxValue = this.totalTaxaCompra! + this.totalTaxaCarregamento!;

    this.lucro = this.value * exchangeSettings.exchangeSellValue -
        this.valorACarregar! -
        this.totalTaxaCarregamento!;
  }

  double getEarns() {
    return 0;
  }
}
