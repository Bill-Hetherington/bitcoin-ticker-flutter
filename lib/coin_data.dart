
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
  final String time;
  final String crypto;
  final String fiat;
   String rate;

   CoinData(
      {String this.time, String this.crypto, String this.fiat, double rate}){
    this.rate=rate.toStringAsFixed(2);
  }

  //called to convert response to CoinData object
  factory CoinData.fromJson(Map<String, dynamic> json){
    return CoinData(
        time: json['time'],
        crypto: json['asset_id_base'],
        fiat: json['asset_id_quote'],
        rate: json['rate']
    );
  }
}
