import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripshiptask/pages/Home/trip_ship_task_home.dart';


class MapPage2 extends StatefulWidget {
  const MapPage2({super.key});

  @override
  State<MapPage2> createState() => _MapPage2State();
}

class _MapPage2State extends State<MapPage2> {
    static const LatLng _pGooglePlex = LatLng(37.4223, -122.0848);

  static const LatLng _pGooglePark = LatLng(37.3346, -122.0090);
  @override
  Widget build(BuildContext context) {
    return  GoogleMap(
        initialCameraPosition: CameraPosition(target: _pGooglePlex,
        zoom: 13, 
        ),
      );
    
  }
}