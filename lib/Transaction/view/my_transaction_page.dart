import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripshiptask/Widget/app_bar_widget_1.dart';



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
      appBar: customAppBar1(),
      body: Column(
        children: [

      
        ],
      ),
    ),
    
    );
  }
}