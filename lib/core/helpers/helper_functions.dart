import 'dart:convert';
import 'package:emschool_dashboard/core/helpers/spacing.dart';
import 'package:emschool_dashboard/core/utlis/app_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';

import '../theming/styles.dart';
import '../widgets/custom_button.dart';
import 'reponsiveness.dart';

pushPage(context, page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

pushPageReplace(context, page) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}
// FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
// void firebaseCloudMessagingListeners() {
//   if (Platform.isIOS) {
//     _firebaseMessaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//   }
//
//   _firebaseMessaging.getToken().then((token) {
//     AppModel.deviceToken = token!;
//     if (kDebugMode) {
//       print("${AppModel.deviceToken} =====> DIVICEToken");
//     }
//   });
// }

dailogDeleteData({context, value, onDelete, onCancel}) {
  showDialogWidget(
      context,
      Container(
        width: ResponsiveWidget.isSmallScreen(context) ? double.infinity : 500,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "هل آنت متآكد آنك تريد حذف ",
              style: TextStyles.textStyleFontBold15Red,
            ),
            verticalSpace(20),
            Text(
              value,
              style: TextStyles.textStyleFontBold14Blue,
            ),
            verticalSpace(30),
            Row(
              children: [
                Expanded(
                    child: CustomButton(
                  title: "نعم ",
                  onPressed: onDelete,
                  backgroundColor: Colors.red,
                )),
                horizontalSpace(20),
                Expanded(
                    child: CustomButton(
                  title: "الغاء ",
                  onPressed: onCancel,
                  backgroundColor: Colors.blue,
                ))
              ],
            )
          ],
        ),
      ));
}

// late String currentCity = "";
// LocationData locData = LocationData.fromMap({});
// Future getLocation() async {
//   Location location = Location();
//   bool serviceEnabled;
//   PermissionStatus permissionGranted;
//   serviceEnabled = await location.serviceEnabled();
//   if (!serviceEnabled) {
//     serviceEnabled = await location.requestService();
//     if (!serviceEnabled) {
//       return;
//     }
//   }
//
//   permissionGranted = await location.hasPermission();
//   if (permissionGranted == PermissionStatus.denied) {
//     permissionGranted = await location.requestPermission();
//     if (permissionGranted != PermissionStatus.granted) {
//       return;
//     }
//   }
//
//   locData = await location.getLocation();
// }

showSheet(BuildContext context, child) {
  showModalBottomSheet(
    context: context,
    clipBehavior: Clip.antiAlias,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext bc) {
      return child;
    },
  );
}

replacePage({context, page}) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => page));
}

pop(context) {
  Navigator.pop(context);
}

// signOut({ctx}) async {
//   const storage = FlutterSecureStorage();
//
//   token = "";
//   await storage.delete(key: "token");
//   await storage.delete(key: "role");
// token = '';
//   token = '';
//   currentUser!.role = null;
//   currentUser!.id = null;
//
//   replacePage(context: ctx, page: const SelectTypeAccountScreen());
// }
// void showDialogDeleteAccount({context}) {
//   showDialog<void>(
//     context: context,
//
//     barrierDismissible: false,
//     // user must tap button!
//     builder: (BuildContext contextt) {
//       return AlertDialog(
//         insetPadding: EdgeInsets.symmetric(horizontal: 20),
//         title: Text(
//           "حذف الحساب".tr(),
//           style: TextStyle(fontSize: 20, color: Palette.mainColor),
//         ),
//         content: Container(
//           width: widthScreen(context),
//           child: SingleChildScrollView(
//             child: ListBody(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Expanded(
//                         child: Text(
//                           "هل أنت متأكد أنك تريد جذف الحساب ؟".tr(),
//                           style: TextStyle(fontSize: 20, color: Colors.black),
//                           textAlign: TextAlign.center,
//                         )),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         actions: <Widget>[
//           BlocBuilder<AuthCubit, AuthState>(
//             builder: (context, state) {
//               return Row(
//                 children: [
//                   Expanded(
//                     child: CustomButton(
//                       elevation: 0,
//                       backgroundColor: Palette.mainColor,
//                       titleColor: Colors.white,
//                       onPressed: () async {
//                         pop(context);
//                         signOut(ctx: context);
//                         // deleteAccountDialog(context);
//                         showTopMessage(
//                             context: context,
//                             customBar:  CustomSnackBar.info(
//                               backgroundColor: Colors.orange,
//                               message: "ستقوم خدمةالعملاء بالتواصل معك لحذف الحساب".tr(),
//                               textStyle: TextStyle(
//                                   fontFamily: "font",
//                                   fontSize: 16,
//                                   color: Colors.white),
//                             ));
//
//
//
//                       },
//                       title: "نعم".tr(),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Expanded(
//                     child: CustomButton(
//                       elevation: 0,
//                       backgroundColor: Colors.white,
//                       titleColor: Colors.red,
//                       onPressed: () async {
//                         pop(contextt);
//                       },
//                       title: "الغاء".tr(),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           )
//         ],
//       );
//     },
//   );
// }

pushPageRoutName(context, route) {
  Navigator.pushNamed(
    context,
    route,
  );
}

pushPageRoutNameReplaced(context, route) {
  Navigator.pushReplacementNamed(
    context,
    route,
  );
}

widthScreen(context) => MediaQuery.of(context).size.width;

heightScreen(context) => MediaQuery.of(context).size.height;

SizedBox sizedHeight(double height) => SizedBox(
      height: height,
    );
SizedBox sizedWidth(double width) => SizedBox(
      width: width,
    );

// bool isLogin() {
//   return currentUser != null;
// }

// isArabic() {
//   return AppModel.lang == AppModel.langAr;
// }

// isStudennt() {
//   return currentUser!.user.role== AppModel.studentRole;
// }

//
// showTopMessage({context, customBar}) {
//   showTopSnackBar(
//     Overlay.of(context),
//     customBar,
//   );
// }
//
// saveUserData(UserLocalStorage user) {
//   const storage = FlutterSecureStorage();
//   storage.write(key: 'token', value: user.token);
//   storage.write(key: 'id', value: user.id);
//   storage.write(key: 'userName', value: user.userName);
//   storage.write(key: 'fullName', value: user.fullName);
//   storage.write(key: 'deviceToken', value: user.deviceToken);
//   storage.write(key: 'role', value: user.role);
//   storage.write(key: 'stageId', value: user.stageId.toString());
//     storage.write(key: 'typeEducationId', value:  user.typeEducationId.toString());
//   storage.write(key: 'classRoomId', value:  user.classRoomId.toString());
//   // storage.write(key: 'email', value: currentUser!.user!.email);
//   // storage.write(key: 'image', value:currentUser!.user!.profileImage
//
//   // );
// }
// //
// readToken() async {
//   // await getBaseUrl();
//   const storage = FlutterSecureStorage();
//   try {
//     // AppModel.lang = (await storage.read(key: "lang"))!;
//     currentUser!.token = (await storage.read(key: "token"))!;
//     currentUser!.id = (await storage.read(key: "id"));
//     currentUser!.role = (await storage.read(key: "role"));
//     currentUser!.fullName = (await storage.read(key: "fullName"));
//     currentUser!.userName = (await storage.read(key: "userName"));
//     currentUser!.deviceToken = (await storage.read(key: "deviceToken"));
//     currentUser!.stageId = int.parse((await storage.read(key: "stageId") ?? "0"));
//     currentUser!.typeEducationId = int.parse((await storage.read(key: "typeEducationId") ?? "0"));
//     currentUser!.classRoomId = int.parse((await storage.read(key: "classRoomId") ?? "0"));
//     if (kDebugMode) {
//       print("token == >: ${currentUser!.token}");
//     }
//   } catch (e) {
//     print(e.toString() + " sfsdl");
//   }
// }
//
// Future<void> showMyDialog({context, onTap}) async {
//   return showDialog<void>(
//     context: context,
//
//     barrierDismissible: false,
//     // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//         insetPadding: const EdgeInsets.symmetric(horizontal: 30),
//         content: Container(
//           // padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
//           width: widthScreen(context),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             // mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Row(
//                 children: [
//                   GestureDetector(
//                       onTap: () {
//                         pop(context);
//                       },
//                       child: SvgPicture.asset("assets/icons/close.svg")),
//                 ],
//               ),
//               SvgPicture.asset("assets/icons/location.svg"),
//               const SizedBox(
//                 height: 16,
//               ),
//               const Texts(
//                   title: "هل تسمح بالتطبيق بالوصول لموقعك ",
//                   family: AppFonts.moS,
//                   size: 12,
//                   textColor: Colors.black,
//                   widget: FontWeight.w700),
//               const SizedBox(
//                 height: 23,
//               ),
//               GestureDetector(
//                 onTap: onTap,
//                 child: const Texts(
//                     title: "نعم أسمح بذلك ",
//                     family: AppFonts.moS,
//                     size: 13,
//                     textColor: Color(0xffB8B8B8),
//                     widget: FontWeight.w700),
//               ),
//               const SizedBox(
//                 height: 23,
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
//
// Future<void> showDialogSuccess({context, message}) {
//   return showDialog<void>(
//     context: context,
//
//     barrierDismissible: false,
//     // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//         insetPadding: const EdgeInsets.symmetric(horizontal: 30),
//         content: Container(
//           // padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
//           width: widthScreen(context),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             // mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Row(
//                 children: [
//                   GestureDetector(
//                       onTap: () {
//                         pop(context);
//                       },
//                       child: SvgPicture.asset("assets/icons/close.svg")),
//                 ],
//               ),
//               SvgPicture.asset("assets/icons/successd.svg"),
//               const SizedBox(
//                 height: 16,
//               ),
//               Texts(
//                   title: message,
//                   line: 2,
//                   family: AppFonts.taM,
//                   size: 18,
//                   algin: TextAlign.center,
//                   textColor: Colors.black,
//                   widget: FontWeight.normal),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
//
Future saveData(key, value) async {
  const storage = FlutterSecureStorage();
  storage.write(key: key, value: value);
}

//
// DateTime INIT_DATETIME = DateTime.now();
// void showDateTimePicker2(context, {onConfirm}) {
//   DateTime? dateAdded;
//   showModalBottomSheet(
//       context: context,
//       // clipBehavior: Clip.antiAlias,
//       backgroundColor: Colors.white,
//       // isScrollControlled: true,
//       builder: (BuildContext bc) {
//         return Container(
//             height: 400,
//             child: Column(
//               children: [
//                 Expanded(
//                   child: CupertinoDatePicker(
//                       backgroundColor: Colors.white,
//                       use24hFormat: false,
//                       mode: CupertinoDatePickerMode.date,
//                       initialDateTime: INIT_DATETIME,
//                       // minuteInterval: 30,
//                       onDateTimeChanged: (date) {
//                         dateAdded = date;
//                       }),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: MaterialButton(
//                             onPressed: () {
//                               onConfirm(dateAdded);
//                             },
//                             color: Palette.mainColor,
//                             height: 40,
//                             child: Text("اختيار".tr(),
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 16))),
//                       ),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       Expanded(
//                         child: MaterialButton(
//                             onPressed: () {
//                               pop(context);
//                             },
//                             color: Colors.red,
//                             height: 40,
//                             child: Text(
//                               "الغاء".tr(),
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 16),
//                             )),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ));
//       });
//   ;
// }
//
// Future<void> showDialogLogin({context, message}) {
//   return showDialog<void>(
//     context: context,
//
//     barrierDismissible: false,
//     // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//         insetPadding: const EdgeInsets.symmetric(horizontal: 30),
//         content: Container(
//           // padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
//           width: widthScreen(context),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             // mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Row(
//                 children: [
//                   GestureDetector(
//                       onTap: () {
//                         pop(context);
//                       },
//                       child: SvgPicture.asset("assets/icons/close.svg")),
//                 ],
//               ),
//               const SizedBox(
//                 height: 16,
//               ),
//               Texts(
//                   title: "من فضلك سجل الدخول حتي تتمكن من التسوق ".tr(),
//                   line: 2,
//                   family: AppFonts.taM,
//                   size: 18,
//                   algin: TextAlign.center,
//                   textColor: Colors.black,
//                   widget: FontWeight.normal),
//               const SizedBox(
//                 height: 16,
//               ),
//               CustomButton(
//                   title: "تسجيل الدخول".tr(),
//                   onPressed: () {
//                     pop(context);
//                     pushPageRoutName(context, selectAccount);
//                   })
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
//
// openGoogleMapLocation({lat, lng}) async {
//   // try{
//   // String mapOptions = [
//   //   'saddr=${locData.latitude},${locData.longitude}',
//   //   'daddr=$lat,$lng',
//   //   'dir_action=navigate'
//   // ].join('&');
//
//   //   String url = 'https://www.google.com/maps?$mapOptions';
//   // // if (await canLaunchUrl(Uri.parse(url),)) {
//   //   await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication);
//   // // } else {
//   // //   throw 'Could not launch $url';
//   // // }
//   // }catch(e){
//   //    throw 'Could not launch ${e}';
//   // }
//
//   String appleUrl =
//       'https://maps.apple.com/?saddr=${locData.latitude},${locData.longitude}&daddr=$lat,$lng&directionsmode=driving';
//   String googleUrl =
//       'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
//
//   Uri appleUri = Uri.parse(appleUrl);
//   Uri googleUri = Uri.parse(googleUrl);
//
//   if (Platform.isIOS) {
//     if (await canLaunchUrl(appleUri)) {
//       await launchUrl(appleUri, mode: LaunchMode.externalApplication);
//     } else {
//       if (await canLaunchUrl(googleUri)) {
//         await launchUrl(googleUri, mode: LaunchMode.externalApplication);
//       }
//     }
//   } else {
//     if (await canLaunchUrl(googleUri)) {
//       await launchUrl(googleUri, mode: LaunchMode.externalApplication);
//     }
//   }
// }
bool isLogin() {
  return currentUser != null;
}

showToast({msg, color}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      webPosition: "Top",
      webShowClose: true,
      timeInSecForIosWeb: 1,
      backgroundColor: color ?? Colors.black,
      textColor: Colors.white,
      fontSize: 16.0);
}

void showBottomSheetWidget(context, child) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      builder: (context) {
        return child;
      });
}

void showDialogWidget(BuildContext context, Widget child) {
  showDialog<void>(
    context: context,

    barrierDismissible: false,
    // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        insetPadding: const EdgeInsets.all(20),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        content: child,
      );
    },
  );
}

String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd', "en");
  final String formatted = formatter.format(date);
  return formatted; // something like 2013-04-20
}

String formatDate2(DateTime date) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm a', "ar");
  final String formatted = formatter.format(date);
  return formatted; // something like 2013-04-20
}

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

Future<bool> hasInternet() async {
  bool result = await InternetConnectionChecker().hasConnection;
  return result;
}

// "service_id":"",
// "template_id":"",
// "user_id":"
Future sendMessageToGmail({name, email, subject, message}) async {
  final serverId = "service_4t05xj5";
  final templateId = "template_yu3gmfq";
  final userId = "OJyunrFeJoqoUxgK-";
  final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
  final response = await http.post(url,
      headers: {
        "origin": 'http://localhost',
        "Content-Type": 'application/json'
      },
      body: json.encode({
        'service_id': serverId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'to_email': email,
          'user_email': 'www.hatli.sa@gmail.com',
          'user_subject': "Id Your Market",
          'user_message': message
        }
      }));

  print(response.body);
}
