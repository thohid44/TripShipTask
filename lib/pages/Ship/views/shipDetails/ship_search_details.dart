import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tripshiptask/profile/view/user_deshboard.dart';

class ShipPageDetails extends StatefulWidget {
  const ShipPageDetails({super.key});

  @override
  State<ShipPageDetails> createState() => _ShipPageDetailsState();
}

class _ShipPageDetailsState extends State<ShipPageDetails> {
  @override
  Widget build(BuildContext context) {
    var shipData = Get.arguments;
    print("Ship Details ${shipData.startPoint}");
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          customText(
            title: "${shipData.startPoint}",
          ),
        ],
      ),
    );
  }
}
