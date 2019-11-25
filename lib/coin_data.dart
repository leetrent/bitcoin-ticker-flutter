import 'dart:convert';

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
    'https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    String url = '$bitcoinAverageURL$selectedCurrency';
    print('[CoinData][getCoinData] => (url): $url');

    http.Response response = await http.get(url);
    print(
        '[CoinData][getCoinData] => (response.statusCode): $response.statusCode');

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      double lastPrice = decodedData['last'];
      return lastPrice.toStringAsFixed(0);
    } else {
      throw 'Error: $response.statusCode';
    }
  }
}

//class CoinData {
//  Future<String> getCoinData(String currencyAbbreviation) async {
//    String lastPrice = '?';
//
//    String url =
//        'https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC$currencyAbbreviation';
//    print('[CoinDate][getCoinData] => (url): $url');
//
//    try {
//      var bitcoinData = await NetworkHelper(url: url).getData();
//      lastPrice = bitcoinData['last'].toString();
//
//      print('[CoinDate][getCoinData] => (lastPrice): $lastPrice');
//      return lastPrice;
//    } catch (err) {
//      return '?';
//    }
//  }
//}

//class CoinData {
//  Future<String> getCoinData(String currencyAbbreviation) async {
//    String lastPrice = '?';
//
//    String url =
//        'https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC$currencyAbbreviation';
//    print('[CoinDate][getCoinData] => (url): $url');
//
//    try {
//      var bitcoinData = await NetworkHelper(url: url).getData();
//      lastPrice = bitcoinData['last'].toString();
//
//      print('[CoinDate][getCoinData] => (lastPrice): $lastPrice');
//      return lastPrice;
//    } catch (err) {
//      return '?';
//    }
//  }
//}
