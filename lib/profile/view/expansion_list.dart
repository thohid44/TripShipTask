import 'package:flutter/material.dart';


class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MyExpansionTile(
          title: 'Trip',
          height: 30,
          children: [
            MyChildItem('Trip Post', height: 23, title: '',),
            MyChildItem('My Trips', height: 23, title: '',),
            MyChildItem('Trips Rating', height: 23, title: '',),
          ],
        ),
      ],
    );
  }
}

class MyExpansionTile extends StatelessWidget {
  final String title;
  final double height;
  final List<Widget> children;

  MyExpansionTile({required this.title, required this.height, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
      ),
      child: ExpansionTile(
        title: Text(title),
        children: children,
      ),
    );
  }
}

class MyChildItem extends StatelessWidget {
  final String title;
  final double height;

  MyChildItem(String s, {required this.title, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
      ),
      padding: EdgeInsets.only(left: 16.0),
      alignment: Alignment.centerLeft,
      child: Text(title),
    );
  }
}
