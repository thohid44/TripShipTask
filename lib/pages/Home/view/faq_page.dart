import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripshiptask/Widget/app_bar_widget_1.dart';
import 'package:tripshiptask/pages/Home/trip_ship_task_home.dart';
import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:tripshiptask/pages/Task/views/task_home_page.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  List<Map<String, dynamic>> list1 = [
    {
      "id": 1,
      "question": "What is TripShipTask?",
      "answer":
          "TripShipTask is a versatile platform that connects people for various services, including task completion, communal travel, and goods delivery. It's a community-centric app where one can offer or avail services while earning money."
    },
    {
      "id": 2,
      "question": "How can you benefit from using TripShipTask?",
      "answer":
          "Whether you're looking to take on or delegate tasks, send or receive goods, and offer or looking for safe commute, TripShipTask provides a flexible and user-friendly platform. It allows you to connect with others in your community and earn money while saving time and resources."
    },
    {
      "id": 3,
      "question":
          "How does TripShipTask stand out from other service platforms?",
      "answer":
          "TripShipTask is unique in its multifaceted approach, combining task services, shipping solutions, and connect and commute in one platform. It emphasizes community connection, personal growth, and the opportunity for users to prosper through various tasks and journeys."
    },
    {
      "id": 4,
      "question": "How do I get started with TripShipTask?",
      "answer":
          "Simply download the TripShipTask mobile app or visit www.tripshiptask.com. Sign up, and start exploring the services you can offer or get. The app's intuitive interface makes it easy to navigate tasks, communal travel, and delivery options."
    },
    {
      "id": 5,
      "question": "Can I use TripShipTask for long-distance services?",
      "answer":
          "Yes, TripShipTask is a platform where users from all areas of the country can sign up and be available to use the platform. Tripshiptask id verified users cater to both local and long-distance needs. Whether it's a cross-town package delivery or a long-haul journey-share, users on the platform accommodate a wide range of distances."
    },
    {
      "id": 6,
      "question":
          "Is there an opportunity for full-time work through TripShipTask?",
      "answer":
          "While TripShipTask offers various part-time and full-time opportunities through the task module, some users have found full-time work or career advancements for the company itself. TripShipTask platform is designed to create employment along with 2 other types of activities through its website and Mobile App platform."
    },
    {
      "id": 7,
      "question": "What kind of tasks can I find or post on TripShipTask?",
      "answer":
          "Tasks can range from household chores to professional services like tutoring, tech support, or creative work and many more. The platform is designed to accommodate a wide variety of tasks and/or needs. Please sign up and explore from the task category on the platform."
    },
    {
      "id": 8,
      "question": "Can businesses use TripShipTask for their needs?",
      "answer":
          "Yes, businesses can use TripShipTask for efficient local deliveries, transport, and various task completions, adding efficiency to their operations."
    },
    {
      "id": 9,
      "question": "Is TripShipTask available in my city?",
      "answer":
          "TripShipTask is currently operating in Bangladesh - all regions. Check our app or website for the latest list of countries/cities where our member services are available."
    }
  ];
  List<Map<String, dynamic>> list2 = [
    {
      "id": 10,
      "question": "Can I choose who I connect with on TripShipTask?",
      "answer":
          "Yes, you have the flexibility to choose whom you connect with for trips, tasks, or deliveries, based on profiles, reviews, and specific service requirements."
    },
    {
      "id": 11,
      "question": "Can I schedule services in advance on TripShipTask?",
      "answer":
          "Yes, our platform allows you to schedule rides, deliveries, and tasks in advance according to your convenience. In fact, we highly encourage users to plan ahead and schedule actions well before the scheduled time for a better and safe process completion."
    },
    {
      "id": 12,
      "question": "How are payments handled on TripShipTask?",
      "answer":
          "Payments for services on TripShipTask are processed securely through the app. You can also transact cash with other users where TripShipTask keeps a record of the transaction and you pay the platform fee periodically. Users can make E-Payments using various debit or credit cards, mobile banking such as BKash, Nagad, UPay, Rocket, Upay – all these popular payment methods for seamless transactions."
    },
    {
      "id": 13,
      "question": "Are there any fees associated with using TripShipTask?",
      "answer":
          "TripShipTask may charge a nominal fee or commission for the services facilitated through the platform and for account verification, security deposit or cancellation fee. These are clearly outlined in Charge Points under QUICK LINKS on the website footer. Our terms and other conditions are designed to be transparent and user-friendly."
    },
    {
      "id": 14,
      "question": "Can I cancel a service on TripShipTask after booking?",
      "answer":
          "Yes, you can cancel a service, though certain conditions and potential fees may apply, as detailed in our cancellation policy."
    },
    {
      "id": 15,
      "question":
          "What happens if a task or delivery is not completed as expected?",
      "answer":
          "We have a dispute resolution system in place. Users can report any issues through the app ticket system, and our support team will assist in resolving them fairly."
    },
    {
      "id": 16,
      "question": "Can I request a specific service provider on TripShipTask?",
      "answer":
          "If you had a good experience with a provider, you can request them again, subject to their availability."
    },
    {
      "id": 17,
      "question": "How do I become a service provider on TripShipTask?",
      "answer":
          "Sign up through the app to browse, complete a quick verification process to enjoy full features of the App including posting and bidding on posts. There is no separate App, you can use the same app to act as a consumer as well as a service provider."
    },
    {
      "id": 18,
      "question": "Can I offer multiple services on TripShipTask?",
      "answer":
          "Absolutely! You can list multiple services you're capable of offering, from communal travel to various tasks. However, we do not encourage you to offer a service unless you are really good at it. TripShipTask does not take any responsibility in any accidents or mishaps that may take place because of your inexperience in a specific matter or area, so use your best judgment to avoid any kind of accident/unwanted situation."
    },
    {
      "id": 19,
      "question": "Is there an age requirement to use TripShipTask?",
      "answer":
          "Users must be at least 16 years old to register and use the services offered by TripShipTask. Under 16 users can use the platform with parents’ consent as well as TripShipTask approval process."
    },
    {
      "id": 20,
      "question":
          "How can I update my service offerings or availability on TripShipTask?",
      "answer":
          "You can easily update your service offerings and availability through the app's or website’s user-friendly interface."
    },
    {
      "id": 21,
      "question":
          "Can I pause my service offerings on TripShipTask when I'm not available?",
      "answer":
          "Yes, our app allows you to post according to your availability, giving you the flexibility to offer services only when you're available."
    },
    {
      "id": 22,
      "question": "Can I use TripShipTask for emergency services?",
      "answer":
          "While TripShipTask is a versatile platform, it is not intended for emergency use. It's designed for scheduled services and should not replace emergency professional services."
    }
  ];

  List<Map<String, dynamic>> list3 = [
    {
      "id": 23,
      "question": "Is TripShipTask safe to use?",
      "answer":
          "Safety is a top priority at TripShipTask. We ensure all members of our community are vetted for reliability and trustworthiness, providing a secure environment for all transactions and interactions. All members or users of TripShipTask are ID verified."
    },
    {
      "id": 24,
      "question":
          "How does TripShipTask ensure the quality of services offered?",
      "answer":
          "We encourage user ratings and reviews for users to understand and gauge other users' service standards. Additionally, regular quality checks and community feedback are integral to our process."
    },
    {
      "id": 25,
      "question": "What measures does TripShipTask take for COVID-19 safety?",
      "answer":
          "We follow the latest health guidelines and highly encourage our users contactless transactions, mask-wearing, and sanitization to ensure the safety of all users."
    },
    {
      "id": 26,
      "question": "How does TripShipTask ensure privacy and data protection?",
      "answer":
          "We adhere to strict privacy policies and employ robust security measures to protect user data. Your personal information is encrypted and securely stored."
    },
    {
      "id": 27,
      "question":
          "What should I do if I encounter an issue during a ride or task?",
      "answer":
          "Contact 999 immediately using your phone if you encounter any kind of adversity within Bangladesh. Inform our support team through the app about the incident. We're here to ensure your experience is safe and satisfactory by aiding you with necessary information or support where we can."
    },
    {
      "id": 28,
      "question":
          "What should I do if a service provider or customer behaves inappropriately?",
      "answer":
          "Inappropriate behavior is taken seriously. Report any such incidents immediately through the app or tripshiptask.com website, and our team will take appropriate action."
    },
    {
      "id": 29,
      "question": "How are service providers vetted on TripShipTask?",
      "answer":
          "We conduct a thorough vetting process, including background checks and verification of information on each user to ensure the safety and reliability of our users or service providers."
    },
    {
      "id": 30,
      "question":
          "What are the safety protocols for communal travelling on TripShipTask?",
      "answer":
          "Safety protocols include identification verification of the users, app usage history, and in-app safety features like activity tracking. Users are requested to ensure face-match the service provides, data check before starting to commute with another user to gauge or assess info consistency provided by another user."
    },
    {
      "id": 31,
      "question":
          "What safety measures should a user take while sending or receiving a package using Ship module?",
      "answer":
          "Each user should do the following before sending or receiving a package to deliver –\n- Make sure to physically see the items to ensure that the items are open and legal items.\n- Make sure to physically see the items to check the condition of the items, the fragility of the items, the size of the items, etc.\n- We do not encourage users to carry physical currency.\n- Each user should make sure that the person he/she is interacting with is the person that is on TripShipTask Mobile App or website. In other words, see the photo and ensure that it’s the same person in physical form."
    }
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
              child:    Text('Frequently Asked Questions',style: GoogleFonts.inter(fontSize: 13.sp, 
                        fontWeight: FontWeight.w500)),
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
                children: list1
                    .map(
                      (e) => ExpansionTileBorderItem(
                        title: Text('${e['id']}  ${e['question']}', style: GoogleFonts.inter(fontSize: 11.sp, 
                        fontWeight: FontWeight.bold),),
                        expendedBorderColor: Colors.blue,
                        children: [
                          Text('${e['answer']}',style: GoogleFonts.inter(fontSize: 12.sp, 
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
            ExpansionTileGroup(
                children: list2
                    .map(
                      (e) => ExpansionTileBorderItem(
                       title: Text('${e['id']}  ${e['question']}', style: GoogleFonts.inter(fontSize: 12.sp, 
                        fontWeight: FontWeight.bold),),
                        expendedBorderColor: Colors.blue,
                        children: [
                          Text('${e['answer']}',style: GoogleFonts.inter(fontSize: 12.sp, 
                        fontWeight: FontWeight.normal)),
                        ],
                      ),
                    )
                    .toList()),
        SizedBox(height: 10.h), 

             Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 15.w),
              
              child:    Text('Using the Platform :',style: GoogleFonts.inter(fontSize: 14.sp, 
                        fontWeight: FontWeight.bold)),
            ),
             SizedBox(height: 10.h), 
            ExpansionTileGroup(
                children: list3
                    .map(
                      (e) => ExpansionTileBorderItem(
                       title: Text('${e['id']}  ${e['question']}', style: GoogleFonts.inter(fontSize: 12.sp, 
                        fontWeight: FontWeight.bold),),
                        expendedBorderColor: Colors.blue,
                        children: [
                          Text('${e['answer']}',style: GoogleFonts.inter(fontSize: 12.sp, 
                        fontWeight: FontWeight.normal)),
                        ],
                      ),
                    )
                    .toList()),
          ],
        ));
  }
}
