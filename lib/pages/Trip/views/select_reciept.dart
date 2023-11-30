import 'dart:async';

import 'package:tripshiptask/pages/Trip/views/covid_19_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

class SelectRecieptPage extends StatefulWidget {
  const SelectRecieptPage({super.key});

  @override
  State<SelectRecieptPage> createState() => _SelectRecieptPageState();
}

class _SelectRecieptPageState extends State<SelectRecieptPage> {
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: sourceLocation,
                zoom: 13.5,
              ),
              markers: {
                const Marker(
                  markerId: MarkerId("source"),
                  position: sourceLocation,
                ),
                const Marker(
                  markerId: MarkerId("destination"),
                  position: destination,
                ),
              },
              onMapCreated: (mapController) {
                _controller.complete(mapController);
              },
            ),
            Positioned(
                left: 40.h,
                bottom: 50.h,
                child: Card(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(15.h),
                    width: 300.w,
                    height: 130.h,
                    child: Column(
                      children: [
                        Container(
                          width: 300.w,
                          alignment: Alignment.center,
                          child: Text(
                            "For a better exprience, turn on divice location, which use Google's location service",
                            style: TextStyle(fontSize: 15.sp),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: Text(
                                "NO THANKS",
                                style: TextStyle(fontSize: 15.sp),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(CovidPage());
                              },
                              child: Container(
                                child: Text(
                                  "oK",
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
