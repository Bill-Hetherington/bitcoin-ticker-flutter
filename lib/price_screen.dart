import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:bitcoin_ticker/services/coin_api_requests.dart';
import 'dart:io' show Platform;

String currencySelected = 'USD';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  //dropdown value state variable

  //android UI element for dropdown
  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(child: Text(currency), value: currency);
      dropDownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: currencySelected,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          currencySelected = value;
        });
      },
    );
  }

  //Returns ui element dependant on platform
  Widget getPicker() {
    if (Platform.isIOS) {
      return Text('Apple Sucks');
    }
    return androidDropDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CurrencyWidget(crypto: "BTC"),
          CurrencyWidget(crypto: "ETH"),
          CurrencyWidget(crypto: "LTC"),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: getPicker()),
        ],
      ),
    );
  }
}


class CurrencyWidget extends StatelessWidget {
  CurrencyWidget({this.crypto});

  final String crypto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: FutureBuilder<CoinData>(
              future: getRate(currencySelected, crypto),
              builder: (context, snapshot) {

                if (snapshot.hasData) {
                  String rate = snapshot.data.rate;
                  return Text(
                    '1 $crypto = $rate $currencySelected',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  );
                }

                return Text('1 $crypto = ? $currencySelected',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),);
              },
            ),
        ),
      ),
    );
  }
}
