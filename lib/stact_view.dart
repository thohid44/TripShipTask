import 'package:flutter/material.dart';

class StackPage extends StatefulWidget {
  const StackPage({super.key});

  @override
  State<StackPage> createState() => _StackPageState();
}

class _StackPageState extends State<StackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [


          Stack(
            clipBehavior: Clip.none,
            children: [

              Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 100, 
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.amber
                  ),
                  child: Text("Stack View"),
                ),
              ), 
              Positioned(
                left: 150,
                top: -25,
                child: CircleAvatar(
                foregroundImage: AssetImage("assets/man.png")
                ))

            ],
          )
        ],
      ),
    );
  }
}