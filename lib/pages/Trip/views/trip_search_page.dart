// import 'package:tripshiptask/pages/Trip/Controller/TripController.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class TripSearchPage extends GetView<TripController> {
//   @override
//   Widget build(BuildContext context) {
//     var tripContrller = Get.put(TripController());
//     print("sear lenght ${tripContrller.tripSearchList.length}");
//     return Scaffold(
//       body: Obx(
//         () => ListView.builder(
//             itemCount: tripContrller.tripSearchList.length,
//             itemBuilder: (context, index) {
//               if (tripContrller.tripSearchList.length == 0) {
//                 return CircularProgressIndicator();
//               }
//               return Card(
//                 child: Container(
//                     margin: EdgeInsets.all(10.h),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 100.w,
//                           height: 100.h,
//                           child: Image.asset("assets/mobile.jpg"),
//                         ),
//                         Container(
//                           alignment: Alignment.topLeft,
//                           height: 100.h,
//                           child: Column(
//                             children: [
//                               Text(
//                                 "Trips Search result",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               Text(
//                                 "Trips Search result",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               Text(
//                                 "Trips Search result",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     )),
//               );
//             }),
//       ),
//     );
//   }
// }
