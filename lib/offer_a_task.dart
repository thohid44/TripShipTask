
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:triptask/Utils/colors.dart';
// import 'package:triptask/Widget/customButtonOne.dart';
// import 'package:triptask/pages/TripPages/views/trip_page.dart';

// class OfferATask extends StatelessWidget {


//   final TextEditingController search = TextEditingController();
//   List<DropdownMenuItem<String>> get vehicleItem {
//     List<DropdownMenuItem<String>> destination = [
//       const DropdownMenuItem(child: Text("Select vehicle"), value: "Select vehicle"),
//       const DropdownMenuItem(child: Text("tripshiptask"), value: "tripshiptask"),
//     ];
//     return destination;
//   }
//   String vehicle = "Select vehicle";

//    List<DropdownMenuItem<String>> get howManyYou {
//     List<DropdownMenuItem<String>> destination = [
//       const DropdownMenuItem(child: Text("How many of you"), value: "How many of you"),
//       const DropdownMenuItem(child: Text("1"), value: "1"),
//     ];
//     return destination;
//   }
//   String howMany = "How many of you";

  
//    List<DropdownMenuItem<String>> get categoryList {
//     List<DropdownMenuItem<String>> categories = [
//       const DropdownMenuItem(child: Text("Select a Category"), 
//       value: "Select a Category"),
//       const DropdownMenuItem(child: Text("1"), value: "1"),
//     ];
//     return categories;
//   }
//   String category = "Select a Category";
  
//    List<DropdownMenuItem<String>> get skillList {
//     List<DropdownMenuItem<String>> categories = [
//       const DropdownMenuItem(child: Text("Skill required"), 
//       value: "Skill required"),
//       const DropdownMenuItem(child: Text("1"), value: "1"),
//     ];
//     return categories;
//   }
//   String skill = "Skill required";
//   List<DropdownMenuItem<String>> get willingPay {
//     List<DropdownMenuItem<String>> destination = [
//       const DropdownMenuItem(child: Text("USD"), 
//       value: "USD"),
//       const DropdownMenuItem(child: Text("BD"), value: "BD"),
//     ];
//     return destination;
//   }
//   String willing = "USD";
//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(
//             height: 25.h,
//           ),
//               Card(
//                           child: Container(
//                                         alignment: Alignment.center,
//                                         height: 35.h,
//                                      width: 320.w,
//                                         decoration: BoxDecoration(
//                                             border: Border.all( color: Colors.grey),
//                                             borderRadius: BorderRadius.circular(10.r)),
//                                         child: DropdownButton(
//                                           underline: SizedBox(),
//                                           isExpanded: true,
//                                           style: TextStyle(
//                           fontSize: 12.sp,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black),
//                                           value: category,
//                                           onChanged: (value) {},
//                                           items: categoryList,
//                                         ),
//                                       ),
//                         ),
//                      SizedBox(
//             height: 5.h,
//           ),
//             Container(
//                    width: 320.w,
//                     height: 35.h,
//                     child: CustomForm(
//                       hinttext: "Title of the task",
//                       radius: 5.r,
//                       textController: search,
//                     )),

//                  SizedBox(
//             height: 5.h,
//           ),
//              Card(
//                           child: Container(
//                              width: 320.w,
//                                         alignment: Alignment.center,
//                                         height: 35.h,
                                      
//                                         decoration: BoxDecoration(
//                                             border: Border.all( color: Colors.grey),
//                                             borderRadius: BorderRadius.circular(10.r)),
//                                         child: DropdownButton(
//                                           underline: SizedBox(),
//                                           isExpanded: true,
//                                           style: TextStyle(
//                           fontSize: 12.sp,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black),
//                                           value: skill,
//                                           onChanged: (value) {},
//                                           items: skillList,
//                                         ),
//                                       ),
//                         ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 20.w),
    
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
              
//                 Container(
//                     width: 150.w,
//                     height: 35.h,
//                     child: CustomForm(
//                       hinttext: "Date of the task",
//                       radius: 5.r,
//                       textController: search,
//                     )),
               
//                 Container(
//                     width: 150.w,
//                     height: 35.h,
//                     child: CustomForm(
//                       hinttext: " Time of the task",
//                       radius: 5.r,
//                       textController: search,
//                     ))
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 5.h,
//           ),
//            Container(
//                     width: 320.w,
//                     height: 35.h,
//                     alignment: Alignment.center,
//                     child: CustomForm(
//                       hinttext: "No of hours needed to carry out the task(dy default 1hr) ",
//                       radius: 5.r,
//                       textController: search,
//                     )),
//                     SizedBox(
//             height: 5.h,
//           ),
     
//           SizedBox(height: 5.h,), 
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 20.w),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
               
               
              
//                         Container(
//                   alignment: Alignment.center,
//                   height: 35.h,
//                   width: 155.w,
//                   decoration: BoxDecoration(
//                       border: Border.all(width: 1.w, color: Colors.grey),
//                       borderRadius: BorderRadius.circular(10.r)),
//                   child: DropdownButton(
//                     underline: SizedBox(),
//                     style: TextStyle(
//                         fontSize: 12.sp,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black),
//                     value: vehicle,
//                     onChanged: (value) {},
//                     items: vehicleItem,
//                   ),
//                 ),
//                 SizedBox(width: 5.w,),
//                         Container(
//                   alignment: Alignment.center,
//                   height: 35.h,
//                   width: 155.w,
//                   decoration: BoxDecoration(
//                       border: Border.all(width: 1.w, color: Colors.grey),
//                       borderRadius: BorderRadius.circular(10.r)),
//                   child: DropdownButton(
//                     underline: SizedBox(),
//                     style: TextStyle(
//                         fontSize: 12.sp,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black),
//                     value: howMany,
//                     onChanged: (value) {},
//                     items: howManyYou,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//            SizedBox(height: 5.h,), 
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 20.w),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
  
                     
//                 SizedBox(width: 5.w,),
//                 Card(
//                   child: Container(
//                     height: 35.h, 
//                     width: 90.w, 
//                     alignment: Alignment.center,
//                     child: Text("willing to pay",
//                       style: TextStyle(
//                           fontSize: 12.sp,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black),),
//                   ),
//                 ), 
//                         Card(
//                           child: Container(
//                                         alignment: Alignment.center,
//                                         height: 35.h,
//                                         width: 50.w,
//                                         decoration: BoxDecoration(
//                                             border: Border.all(width: 1.w, color: Colors.grey),
//                                             borderRadius: BorderRadius.circular(10.r)),
//                                         child: DropdownButton(
//                                           underline: SizedBox(),
//                                           style: TextStyle(
//                           fontSize: 12.sp,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black),
//                                           value: willing,
//                                           onChanged: (value) {},
//                                           items: willingPay,
//                                         ),
//                                       ),
//                         ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 5.h,
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 20.w),
//             child: TextFormField(
//               decoration:  InputDecoration(
//                 hintText: "Note", 
                
//                 border: OutlineInputBorder(),
                
//               ),
             
//       maxLines: 3,
            
//             ),
//           ), 
        
//           SizedBox(
//             height: 5.h,
//           ),
//           CustomButtonOne(
//             title: "Sumbit",
//             onTab: () {},
//             height: 40.h,
//             width: 150.w,
//             btnColor: navyBlueColor,
//             radius: 10.r,
//           )
//         ],
//       ),
//     );
//   }
// }
