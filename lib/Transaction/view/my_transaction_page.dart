import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tripshiptask/pages/Home/trip_ship_task_home.dart';
import 'package:tripshiptask/pages/Trip/views/amar_pay_web_view.dart';

import '../controller/transaction_controller.dart';

class MyTransactionPage extends StatefulWidget {
  const MyTransactionPage({super.key});

  @override
  State<MyTransactionPage> createState() => _MyTransactionPageState();
}

class _MyTransactionPageState extends State<MyTransactionPage> {
    var controller = Get.put(TransactionController());
    void initState(){
      controller.getMyTransaction();
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: customAppBar(),
      body: Column(
        children: [

      
        ],
      ),
    ),
    
    );
  }
}