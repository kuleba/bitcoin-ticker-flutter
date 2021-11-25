import 'package:http/http.dart' as http;
import 'dart:convert';

const url = 'https://rest.coinapi.io/v1/exchangerate';
const ApiKey = 'FDDF9A87-6CC8-400B-93E3-689EEA8D5941';
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

class CoinData {
  double rate = 0;

  Future getCoinData(String currency) async {
    var decodedData;
    var uri = Uri.parse('$url/BTC/$currency?apikey=$ApiKey');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      decodedData = jsonDecode(response.body);
      rate = decodedData['rate'];
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    rate = decodedData['rate'];
  }
}
