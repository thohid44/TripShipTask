import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripshiptask/Refferal/views/my_referrels_view.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:tripshiptask/Widget/app_bar_widget_1.dart';
import 'package:tripshiptask/Widget/customText.dart';

import 'package:tripshiptask/pages/Home/view/home_screen.dart';

import 'package:tripshiptask/pages/Login/view/login_screen.dart';
import 'package:tripshiptask/pages/Task/views/my_task_offers_page.dart';

import 'package:tripshiptask/pages/Trip/views/my_trips_offer_page.dart';
import 'package:tripshiptask/profile/view/all_Task_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripshiptask/profile/view/all_ship_page.dart';
import 'package:tripshiptask/profile/view/all_trrips_pages.dart';
import 'package:tripshiptask/rating/view/all_ship_rating_page.dart';
import 'package:tripshiptask/rating/view/all_task_rating_page.dart';
import 'package:tripshiptask/rating/view/all_trip_rating_page.dart';
import 'package:tripshiptask/support_Ticket/view/my_tickets_page.dart';
import 'package:tripshiptask/support_Ticket/view/trip_support_ticket.dart';

import '../../pages/Ship/views/my_ship_offers_page.dart';
import '../../pages/Task/views/task_home_page.dart';

class UserDeshBoard extends StatefulWidget {
  const UserDeshBoard();
  @override
  State<UserDeshBoard> createState() => _UserDeshBoardState();
}

class _UserDeshBoardState extends State<UserDeshBoard> {
  final _box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
         appBar: customAppBar1(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                AccountAppBar(box: _box),
                 SizedBox(
                          height: 5.h,
                        ),
                        
               Padding(
                 padding:  EdgeInsets.only(left:7.w),
                 child: Material(
                   elevation: 8,
                     color: primaryColor,
                     shadowColor: primaryColor,
                     borderRadius: BorderRadius.circular(5),
                   child: Container(
                        alignment: Alignment.centerLeft,
                        height: 515.h,
                        width: 200.w,
                            margin: EdgeInsets.only(left: 10.w),
                        decoration: BoxDecoration(color: primaryColor, 
                        borderRadius: BorderRadius.circular(10.r)
                        ),
                        child: ListView(
                          children: [
                          
                            // Container(
                            //   margin: EdgeInsets.only(left: 15.w),
                            //   child: Text(
                            //       "Dashboard",
                            //       style: GoogleFonts.inter(
                            //         fontWeight: FontWeight.w500,
                            //           fontSize: 14.sp, color: Colors.black),
                            //     ),
                            // ),
                           
                            ExpansionTile(
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.stretch,
                              
                              title: Text(
                                "Trip",
                                style: GoogleFonts.inter(
                                   fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 13.sp),
                              ),
                              children: [
                               
                                   InkWell(
                                   onTap: () {
                                     Get.to(HomeScreen(),
                    transition: Transition.leftToRight,
                    duration: Duration(milliseconds: 300));

                                   
                                  },
                                  child: ExpansionChild("Post a Trip"),
                                ),

                                  InkWell(
                                   onTap: () {
                                    Get.to(AllTripView(),
                                        transition: Transition.rightToLeft);
                                  },
                                  child: ExpansionChild("My Trips"),
                                ),
                               InkWell(
                                  onTap: () {
                                    Get.to(MyTripsOfferPage(),
                                        transition: Transition.leftToRight);
                                  },
                                  child: ExpansionChild("My Trip Offers"),
                                ),
                                     InkWell(
                                   onTap: () {
                                      Get.to(AllTripRatingPage(),
                                          transition: Transition.leftToRight);
                                    },
                                  child: ExpansionChild("My Trip Ratings"),
                                ),
                               
                              
                              ],
                            ),
                              Divider(height: 1,), 
                            ExpansionTile(
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.stretch,
                            
                              title: Text(
                                "Ship",
                                 style: GoogleFonts.inter(
                                   fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    
                                    fontSize: 13.sp),
                              ),
                              children: [
                                  InkWell(
                                   onTap: () {
                                    Get.to(HomeScreen(),
                                        transition: Transition.rightToLeft);
                                  },
                                  child: ExpansionChild("Post a Ship"),
                                ),
                                      InkWell(
                                   onTap: () {
                                    Get.to(AllShipPage(),
                                        transition: Transition.rightToLeft);
                                  },
                                  child: ExpansionChild("My Ships"),
                                ),
                               InkWell(
                                  onTap: () {
                                    Get.to(MyShipOfferPage(),
                                        transition: Transition.leftToRight);
                                  },
                                  child: ExpansionChild("My Ship Offers"),
                                ),
                                     InkWell(
                                    onTap: () {
                                    Get.to(AllShipRatingPage(),
                                        transition: Transition.leftToRight);
                                  },
                                  child: ExpansionChild("My Ship Ratings"),
                                ),
         
                              ],
                            ),
                            Divider(height: 1,), 
                            ExpansionTile(
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.stretch,
                              title: Text(
                                "Task",
                                style: GoogleFonts.inter(
                                   fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 13.sp),
                              ),
                              children: [
                                // ExpansionChild(
                                //    "Post a Task",
                                // ),
                                InkWell(
                                  onTap: () {
                                    Get.to(AllTaskPage(),
                                        transition: Transition.leftToRight);
                                  },
                                  child: ExpansionChild(
                                     "My Task",
                                  ),
                                  
                                ),
                                InkWell(
                                    onTap: () {
                                      Get.to(MyTaskOffersPage(),
                                          transition: Transition.leftToRight);
                                    },
                                    child: 
                                     ExpansionChild("My Task Offers"),
                                    ),
                                InkWell(
                                  onTap: () {
                                    Get.to(AllTaskRatingPage(),
                                        transition: Transition.leftToRight);
                                  },
                                  
                                  child:  ExpansionChild("My Task Ratings"),
                                )
                              ],
                            ),
                             Divider(height: 1,), 
                            ExpansionTile(
                              trailing: SizedBox(),
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.stretch,
                              
                              title: InkWell(
                                onTap: (){
                                    Get.to(MyReferrelsPage()); 
                                },
                                child: Text(
                                  "Referral",
                                  style: GoogleFonts.inter(
                                     fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 13.sp),
                                ),
                              ),),
                               Divider(height: 1,), 
 ExpansionTile(
                              trailing: SizedBox(),
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.stretch,
                              
                              title: InkWell(
                                onTap: (){
                                    Get.to(MyReferrelsPage()); 
                                },
                                child: Text(
                               "My Transactions",
                                  style: GoogleFonts.inter(
                                     fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 13.sp),
                                ),
                              ),),
                               ExpansionTile(
                              trailing: SizedBox(),
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.stretch,
                              
                              title: InkWell(
                                onTap: (){
                                    Get.to(MyReferrelsPage()); 
                                },
                                child: Text(
                                 "Withdrawal Method",
                                  style: GoogleFonts.inter(
                                     fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 13.sp),
                                ),
                              ),),
            
                         
                         Divider(height: 1,), 
                         
                            ExpansionTile(
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.stretch,
                              title: Text(
                                "Support",
                              style: GoogleFonts.inter(
                                   fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 13.sp),
                              ),
                              children: [
                                InkWell(
                                  onTap: (){
                                    Get.to(OpenATicket(),
                                          transition: Transition.leftToRight);
                                  },
                                  child: ExpansionChild("Open a Ticket")),
                                InkWell(
                                     onTap: (){
                                    Get.to(MyTicketsPage(),
                                          transition: Transition.leftToRight);
                                  },
                                  child: ExpansionChild(
                                     "My Tickets",
                                  ),
                                ),
                              ],
                            ),
                             Divider(height: 1,), 
                             ExpansionTile(
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.stretch,
                              title: Text(
                                "Profile",
                              style: GoogleFonts.inter(
                                   fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 13.sp),
                              ),
                              children: [
                                InkWell(
                                  onTap: (){
                                    // Get.to(TripSupportTicketPage(),
                                    //       transition: Transition.leftToRight);
                                  },
                                  child: ExpansionChild("General & Contact Info")),
                                   InkWell(
                                  onTap: (){
                                    // Get.to(TripSupportTicketPage(),
                                    //       transition: Transition.leftToRight);
                                  },
                                  child: ExpansionChild("NID Info")),
                                       InkWell(
                                  onTap: (){
                                    // Get.to(TripSupportTicketPage(),
                                    //       transition: Transition.leftToRight);
                                  },
                                  child: ExpansionChild("Change Password")),
                              ],
                            ),
                             Divider(height: 1,), 
                            InkWell(
                              onTap: () {
                                _box.remove(LocalStoreKey.token);
                                _box.remove(LocalStoreKey.accountNo);
                                _box.remove(LocalStoreKey.fullName);
                                _box.remove(LocalStoreKey.userId);
                                Get.offAll(LoginScreen());
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 15.w, top: 10.h),
                                child: Text(
                                  "Logout",
                               style: GoogleFonts.inter(
                                   fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 13.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                 ),
               ),
              
            ],
          )),
    );
  }
}

class ExpansionChild extends StatelessWidget {
  String? title;

  ExpansionChild(this.title); 
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26.h,
      alignment: Alignment.centerLeft,
      width: 190.w,
      padding: EdgeInsets.only(left: 40.w),
      decoration: BoxDecoration(
        color: Color(0xffBFC2C7),
        border: Border(
            bottom: BorderSide(
          color: Colors.black,
          width: 0.3,
        )),
      ),
      child: Text(
        "$title",
        style: GoogleFonts.inter(color: Color(0xff5A5A5C)),
      ),
    );
  }
}

class customText extends StatelessWidget {
  String? title;

  customText({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 40.w),
      padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(width: 0.5.w))),
      child: Text(
        "$title",
        style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontSize: 15.sp),
      ),
    );
  }
}
