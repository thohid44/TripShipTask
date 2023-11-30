import 'package:flutter/material.dart';
import 'package:tripshiptask/pages/Home/trip_ship_task_home.dart';

class TripGivePostEdit extends StatefulWidget {
  const TripGivePostEdit({super.key});

  @override
  State<TripGivePostEdit> createState() => _TripGivePostEditState();
}

class _TripGivePostEditState extends State<TripGivePostEdit> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(),
        body: ListView(
          children: [],
        ),
      ),
    );
  }
}
