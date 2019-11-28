import 'dart:convert';

import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const bitcoinAverageURL =
    'https://apiv2.bitcoinaverage.com/indices/global/ticker';

//class CoinData {
//  Future getCoinData(String selectedCurrency) async {
//    String url = '$bitcoinAverageURL/BTC$selectedCurrency';
//    print('[CoinData][getCoinData] => (url): $url');
//
//    http.Response response = await http.get(url);
//    print('[CoinData][getCoinData] => (response.statusCode): ' +
//        response.statusCode.toString());
//
//    if (response.statusCode == 200) {
//      var decodedData = jsonDecode(response.body);
//      double lastPrice = decodedData['last'];
//
//      print('[CoinData][getCoinData] => (lastPrice): ' + lastPrice.toString());
//
//      FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: lastPrice);
//
//      //return lastPrice.toStringAsFixed(0);
//      //return fmf.output.nonSymbol;
//      return fmf.output.withoutFractionDigits;
//    } else {
//      throw 'Error: $response.statusCode';
//    }
//  }
//}

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};

    for (String crypto in cryptoList) {
      String requestURL = '$bitcoinAverageURL/$crypto$selectedCurrency';
      print('[CoinData][getCoinData] => (requestURL): $requestURL');

      http.Response response = await http.get(requestURL);
      print('[CoinData][getCoinData] => (response.statusCode): ' +
          response.statusCode.toString());

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['last'];
        print('[CoinData][getCoinData] => (lastPrice): ' +
            lastPrice.toString() +
            ' (selectedCurrency): ' +
            selectedCurrency);

        FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: lastPrice);
        cryptoPrices[crypto] = fmf.output.withoutFractionDigits;
      } else {
        throw 'Error: $response.statusCode';
      }
    }
    return cryptoPrices;
  }
}
