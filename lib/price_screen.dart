import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String valueOfOneBitcoin;

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
    try {
      String value = await CoinData().getCoinData(this.selectedCurrency);
      setState(() {
        this.valueOfOneBitcoin = value;
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
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $valueOfOneBitcoin $selectedCurrency',
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
            child: (Platform.isIOS)
                ? this.createIOSPicker()
                : this.createAndroidDropdown(),
          ),
        ],
      ),
    );
  }
}
