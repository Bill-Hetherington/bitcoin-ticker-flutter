import 'dart:convert';
import 'dart:io';
import '../coin_data.dart';
import 'package:http/http.dart' as http;

//request for crypto to fiat rate
//1 crypto to equivalent fiat
Future<CoinData> getRate(String fiat, String crypto) async {
  final response = await http.get(
      Uri.parse("https://rest.coinapi.io/v1/exchangerate/$crypto/$fiat"),
      headers: {HttpHeaders.authorizationHeader:'E97561CB-B1D8-4B19-8631-03FDAC6540E8'});

  print(response.body);
  if (response.statusCode == 200) {
    return CoinData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Coin Data');
  }
}
