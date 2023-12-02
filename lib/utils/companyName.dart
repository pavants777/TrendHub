import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CompanyName extends StatelessWidget {
  CompanyName({this.logofontSize, this.textfontSize});
  double? logofontSize;
  double? textfontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'TrendHub',
            style: TextStyle(
                fontSize: logofontSize ?? 25,
                letterSpacing: 3.0,
                fontWeight: FontWeight.bold),
          ),
          Text(
            'PavanGowda',
            style: TextStyle(
                fontSize: textfontSize ?? 10,
                letterSpacing: 1.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      )),
    );
  }
}
