import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripshiptask/Widget/app_bar_widget_1.dart';

import 'package:expansion_tile_group/expansion_tile_group.dart';


class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
List<Map<String, dynamic>> privacyPolicy = [
  {
    "section": "1. Information We Collect, and How We Use It.",
    "subsections": [
      {
        "type": "A. Information that you provide us directly",
        "content": [
          "Information you give us when you register an account with the Platform...",
          // Add other content
        ]
      },
      {
        "type": "B. Information that we automatically collect",
        "content": [
          "We automatically collect information about your computer, mobile device...",
          // Add other content
        ]
      },
      {
        "type": "C. Information you give us about your friends",
        "content": [
          "If you choose to use the Platform to tell a friend about us...",
          // Add other content
        ]
      },
      {
        "type": "D. Location Information",
        "content": [
          "When you use our Mobile App, we may collect and store information...",
          // Add other content
        ]
      },
    ]
  },
  {
    "section": "2. Sharing Your Information.",
    "content": [
      "In addition to using your information for the purposes described above, we may share...",
      // Add other content
    ]
  },
  {
    "section": "3. Controlling Your Information.",
    "subsections": [
      {
        "type": "A. Posting in Chat Groups",
        "content": ["When you post or make content available in Chat Groups, that content will be visible to everyone who is a member of that Chat Group."]
      },
      {
        "type": "B. Communicating with Users",
        "content": ["When you communicate with or make content available to a User that content is provided directly to the User and is subject to the User’s privacy or security practices and policies."]
      },
      {
        "type": "C. Accessing and Changing your Account Information; Deleting your Account",
        "content": ["You can edit, update, or delete your account at any time.", "If you delete your account, you won’t be able to sign in, use the Platform, or access any of your information."]
      },
      {
        "type": "D. Opting out of Receiving Communications",
        "content": ["If you are using the Platform, you are to be open to receiving communications from us. You won’t be able to opt out of Platform-related communications like Platform announcements, administrative notices, and the like."]
      },
    ]
  },
  {
    "section": "4. Security",
    "content": ["Your account, registration information, and password are protected so that only you (or any third parties that you allow to access your login credentials) can access your account.", "All personally identifiable information that we collect about you is stored in limited-access servers. The Platform has technical, administrative, and physical security measures in place to protect against the loss, misuse and alteration of the information which is under our control."]
  },
  {
    "section": "5. International Transfer",
    "content": ["TripShipTask stores its data in the United States, and may store data in any part of the world where it operates or it may choose to keep.", "Your information may be transferred to - and maintained on - computers located outside of your state, province, country, or other governmental jurisdiction where the privacy laws may not be as protective as those in your jurisdiction. By using the Platform, you understand and consent that your information may be transferred to our facilities and those third parties with whom we share it as described in this Privacy Policy."]
  },
  {
    "section": "6. Changes to our Privacy Policy",
    "content": ["We may modify our Privacy Policy from time to time.", "When we make changes, we will notify you by making the revised version available on this webpage, and will indicate at the top the date of the latest revision.", "You should check this Privacy Policy on a regular basis, since revised versions will be binding on you.", "Any such modifications will be effective when we post the updated Privacy Policy. You understand and agree that your continued access to our Platform after any posted modification to the Privacy Policy indicates your acceptance of those modifications."]
  },
  {
    "section": "7. Contact Us",
    "content": ["If you have any questions about this Privacy Policy, please email to support@tripshiptask.com."]
  },
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar1(),
        body: ListView(
          children: [
           
            Container(
              alignment: Alignment.center,
              height: 40.h,
              child:    Text('Frequently Asked Questions',style: GoogleFonts.inter(fontSize: 17.sp, 
                        fontWeight: FontWeight.bold)),
            ),
          SizedBox(height: 10.h), 

             Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 15.w),
              
              child:    Text('Understanding TripShipTask :',style: GoogleFonts.inter(fontSize: 14.sp, 
                       fontWeight: FontWeight.w500)),
            ),
             SizedBox(height: 10.h), 
            ExpansionTileGroup(
                children: privacyPolicy
                    .map(
                      (e) => ExpansionTileBorderItem(
                        title: Text('${e['id']}  ${e['question']}', style: GoogleFonts.inter(fontSize: 11.sp, 
                        fontWeight: FontWeight.bold),),
                        expendedBorderColor: Colors.blue,
                        children: [
                          Text('${e['content']}',style: GoogleFonts.inter(fontSize: 12.sp, 
                        fontWeight: FontWeight.normal)),
                        ],
                      ),
                    )
                    .toList()),
        SizedBox(height: 10.h), 

             Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 15.w),
              
              child:    Text('Safety and Security :',style: GoogleFonts.inter(fontSize: 14.sp, 
                       fontWeight: FontWeight.w500)),
            ),
             SizedBox(height: 10.h), 
          
       
          ],
        ));
  }
}
