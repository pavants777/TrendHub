import 'package:flutter/material.dart';
import 'package:trendhub/Routes/routes.dart';
import 'package:trendhub/utils/companyName.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void navigatonChange() {
      Navigator.pushNamed(context, Routes.userCheck);
    }

    Future.delayed(const Duration(seconds: 5), navigatonChange);

    return Scaffold(
        body: PageView(
      children: [
        Container(
          child: CompanyName(
            logofontSize: 50,
            textfontSize: 15,
          ),
        ),
      ],
    ));
  }
}
