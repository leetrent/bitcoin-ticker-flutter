import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';
import 'crypto_card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';
  Map<String, String> coinValues = {};
  bool isWaiting = false;

  DropdownButton<String> createAndroidDropdown() {
    return DropdownButton<String>(
      value: this.selectedCurrency,
      items: this.createAndroidDropdownItems(),
      onChanged: (value) async {
        print(value);
        setState(
          () {
            this.selectedCurrency = value;
            this.getData();
          },
        );
      },
    );
  }

  List<DropdownMenuItem<String>> createAndroidDropdownItems() {
    List<DropdownMenuItem<String>> dropdownMenuItems = [];
    for (String currency in currenciesList) {
      dropdownMenuItems
          .add(DropdownMenuItem(child: Text(currency), value: currency));
    }
    return dropdownMenuItems;
  }

  CupertinoPicker createIOSPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
        setState(() {
          this.selectedCurrency = currenciesList[selectedIndex];
          this.getData();
        });
      },
      children: createIOSPickerItems(),
    );
  }

  List<Text> createIOSPickerItems() {
    List<Text> iosPickerItems = [];
    for (String currency in currenciesList) {
      iosPickerItems.add(Text(currency));
    }
    return iosPickerItems;
  }

  void getData() async {
    this.isWaiting = true;
    try {
      Map<String, String> data =
          await CoinData().getCoinData(this.selectedCurrency);
      this.isWaiting = false;
      setState(() {
        this.coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getData();
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CryptoCard(
                cryptoCurrency: cryptoList[0],
                value: (this.isWaiting) ? ('?') : (this.coinValues['BTC']),
                selectedCurrency: this.selectedCurrency,
              ),
              CryptoCard(
                cryptoCurrency: cryptoList[1],
                value: (this.isWaiting) ? ('?') : (this.coinValues['ETH']),
                selectedCurrency: this.selectedCurrency,
              ),
              CryptoCard(
                cryptoCurrency: cryptoList[2],
                value: (this.isWaiting) ? ('?') : (this.coinValues['LTC']),
                selectedCurrency: this.selectedCurrency,
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: (Platform.isIOS)
                ? this.createIOSPicker()
                : this.createAndroidDropdown(),
          ),
        ],
      ),
    );
  }
}
