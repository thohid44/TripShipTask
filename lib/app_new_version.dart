// import 'package:flutter/material.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:in_app_update/in_app_update.dart';



// class AppVersionUpdate extends StatefulWidget {
//   @override
//   _AppVersionUpdateState createState() => _AppVersionUpdateState();
// }

// class _AppVersionUpdateState extends State<AppVersionUpdate> {
//   late PackageInfo _packageInfo;

//   @override
//   void initState() {
//     super.initState();
//     _initPackageInfo();
//     _checkForUpdate();
//   }

//   Future<void> _initPackageInfo() async {
//     final PackageInfo packageInfo = await PackageInfo.fromPlatform();
//     setState(() {
//       _packageInfo = packageInfo;
//     });
//   }

//   Future<void> _checkForUpdate() async {
//     InAppUpdate.checkForUpdate().then((updateInfo) {
//       if (updateInfo.updateAvailability == true) {
//         InAppUpdate.performImmediateUpdate().catchError((e) {
//           // Handle error
//           print('Error during update: $e');
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My App'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'App Version: ${_packageInfo.version}',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Welcome to My App!',
//               style: TextStyle(fontSize: 24),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
