import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://flutter.dev');



class PaymentUrl extends StatelessWidget {
  const PaymentUrl({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

body: Column(
  children: [
    ElevatedButton(onPressed: _launchUrl, child: Text("Pay"))
  ],
),
    );
  }

  
Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
}
