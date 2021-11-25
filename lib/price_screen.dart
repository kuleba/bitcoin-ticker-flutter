import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? selectedCurrency = 'USD';
  CoinData coinData = CoinData();

  @override
  void initState() {
    super.initState();
    coinData.getCoinData('USD');
  }

  Widget getSelectBoxByPlatform() {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    if (isIOS) {
      return getCupertinoPickerIOS();
    } else {
      return getDropdownButtonAndroid();
    }
  }

  DropdownButton<String> getDropdownButtonAndroid() {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: [
        for (String item in currenciesList)
          DropdownMenuItem(
            child: Text(item),
            value: item,
          ),
      ],
      onChanged: (value) async {
        await coinData.getCoinData(value!);
        setState(() {
          selectedCurrency = value!;
          print(value);
        });
      },
    );
  }

  CupertinoPicker getCupertinoPickerIOS() {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) async {
        await coinData.getCoinData(currenciesList[selectedIndex]);
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
        });
      },
      children: [
        for (var item in currenciesList) Text(item),
      ],
    );
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
        children: <Widget>[
          for (var value in cryptoList)
            Padding(
              padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
              child: Card(
                color: Colors.lightBlueAccent,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                  child: Text(
                    '1 $value = ${coinData.rate.round()} $selectedCurrency',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: getSelectBoxByPlatform()),
        ],
      ),
    );
  }
}
