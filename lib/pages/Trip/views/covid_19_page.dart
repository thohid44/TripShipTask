import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class CovidPage extends StatefulWidget {
  const CovidPage({super.key});

  @override
  State<CovidPage> createState() => _CovidPageState();
}

class _CovidPageState extends State<CovidPage> {
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
                left: 20.w,
                right: 20.w,
                top: 150.h,
                child: Card(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        left: 10.w, right: 10.w, top: 15.h, bottom: 15.h),
                    width: 300.w,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            "Covid-19 Safety Checklist",
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "Avoid any interaction if you are sick of have any symptom of Covid-19",
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        ListTile(
                          title: Text(
                            "You are not Sick",
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "Avoid any interaction if you are sick of have any symptom of Covid-19",
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w600),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            //   Get.to();
                          },
                          title: Text(
                            "Wear a mask",
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "Please wear a face mask as health officials recommended.",
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w600),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Clean your hand",
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "Please clean your hand thoroughly with soap or hand-sanitizer frequenty",
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w600),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Keep distance",
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "Maintain recommended physical distance while interacting.",
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Text(
                          " ACKNOWLEDGE & PROCEED",
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.bold),
                        ),
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
