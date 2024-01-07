import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripshiptask/pages/Home/trip_ship_task_home.dart';

import '../../pages/Task/views/task_home_page.dart';

class MapTrip extends StatefulWidget {
  const MapTrip();
  @override
  State<MapTrip> createState() => _MapTripState();
}

class _MapTripState extends State<MapTrip> {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _kGooglPlex =
      CameraPosition(target: LatLng(23.738045, 73.084488), zoom: 14);

  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLine = {};
  List<LatLng> latLng = [
    LatLng(33.738045, 73.084488),
    LatLng(33.567997728, 72.635997456)
  ];


  void initState() {
    for (var i = 0; i < latLng.length; i++) {
      _markers.add(Marker(markerId: MarkerId(i.toString()),
      position: latLng[i],
      infoWindow: InfoWindow(
        title: "Trip Ship", 
        snippet: "S tar Rating"
      ), 
      icon: BitmapDescriptor.defaultMarker
      
      ));
      setState(() {
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: customAppBar(),
      body: GoogleMap(
        initialCameraPosition: _kGooglPlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _markers,
        myLocationEnabled: true,
        mapType: MapType.normal,
      ),
    ));
  }
}
