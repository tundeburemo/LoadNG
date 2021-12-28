import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:loadng/app.dart';
import 'package:loadng/locator.dart';
import 'package:loadng/services/apis/system.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'dart:async';
import 'package:loadng/services/appSettings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import 'styles/AppColors.dart';
import 'styles/AppFontSizes.dart';
import 'widgets/loginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loadng/utils/dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:loadng/styles/AppFontSizes.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/styles/AppImage.dart';
import 'package:loadng/screens/Drawer.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/widgets/loginScreen.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
  // final oCcy = new NumberFormat("#,##0.00", "en_US");
  var position = 0;
  var username = " ";
  var mainbal = " ";
  var billbal;
  var refillbal;
  var coinbal;
  var mainaccfast = " ";
  var proviaccfast = 0;
  var amnotban = "1";
  var amiapporoved = 0;
  var messtitle, notimesstitle;
  var messbody, notimessbody;
  var imageurl, notiimageurl;
var functionfile = locator<CustomFunction>();
var systemapi = locator<SystemApi>();
/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage event) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();
  // print('Handling a background message ${message.messageId}');
  // if
   var message=event.data;
        if(event.data!=null&&event.data.isNotEmpty){
        messtitle = message["data"]["title"];
        messbody = message["data"]["body"];
        imageurl = message["data"]["image"];
        }
        if(event.notification.body!=null){
        notimessbody = event.notification.body;
        }
        if(event.notification.title!=null){
        notimesstitle =event.notification.title;
        }
        // if(event.notification!=null){
        // notiimageurl = message["notification"]["image"];
        // }

        //once the app is opened and notification enters, it should pop up
        // showDialog(
        // context: context,
        // builder: (BuildContext context) => Dialog(
        // shape: RoundedRectangleBorder(
        // borderRadius: BorderRadius.circular(16),
        // ),
        // elevation: 0.0,
        // backgroundColor: Colors.transparent,
        // child: Container(
        // decoration: boxDecoration(
        // showShadow: true, radius: AppFontSize.spacing_standard),
        // child: Column(
        // mainAxisSize: MainAxisSize.min,
        // children: <Widget>[
        // imageurl != null
        // ? Image.network(
        // imageurl,
        // width: 220,
        // height: 120,
        // ).paddingTop(50)
        // : notiimageurl != null
        // ? Image.network(
        // notiimageurl,
        // width: 220,
        // height: 120,
        // ).paddingTop(50)
        // : Container(),
        // toolBarTitle(
        // (messtitle != null
        // ? messtitle
        // : notimesstitle != null
        // ? notimesstitle
        // : " "),
        // textColor: AppColors.appDarkRed)
        // .paddingTop(AppFontSize.spacing_large),
        // text(
        // messbody != null
        // ? messbody
        // : notimessbody != null
        // ? notimessbody
        // : " ",
        // maxLine: 18,
        // isCentered: true,
        // fontSize: AppFontSize.textSizeSMedium,
        // fontFamily: AppFontSize.spinnaker)
        // .paddingTop(AppFontSize.spacing_control),
        // SizedBox(
        // width: double.infinity,
        // child: MaterialButton(
        // padding: EdgeInsets.only(
        // top: AppFontSize.spacing_standard_new,
        // bottom: AppFontSize.spacing_standard_new),
        // child: text("OK",
        // textColor: Colors.white,
        // fontFamily: AppFontSize.fontMedium,
        // maxLine: 2),
        // shape: RoundedRectangleBorder(
        // borderRadius: new BorderRadius.circular(
        // AppFontSize.spacing_standard)),
        // color: AppColors.t12_primary_color,
        // onPressed: () {
        // Navigator.pop(context);
        // },
        // ),
        // ).paddingAll(AppFontSize.spacing_standard_new)
        // ],
        // ).paddingAll(AppFontSize.spacing_standard_new),
        // ),
        // ));
        }


void main()async{
     // SystemChrome.setEnabledSystemUIOverlays ([]); //Enable Full Screen Mode
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
   await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Set the background messaging handler early on, as a named top-level function
    /// Create an Android Notification Channel.
  ///
  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions( alert: true,
    badge: true,
    sound: true,
  );

  // SharedPreferences.setMockInitialValues({});
  // Crashlytics.instance.enableInDevMode = false;
  final preferences = await StreamingSharedPreferences.instance;
  final settings = MyAppSettings(preferences);
  preferences.setString('myversion', "2.8"); // always chnage dis in new version
  int checked = 0; 
  int maintain=0;
   var theinternet = await functionfile.isInternet();
      var theinternet2 = await functionfile.checkInternetAccess();
      if (theinternet && theinternet2) {
      var checker=0;
      var checkeing = await systemapi.checkmaintanance();
      if (checkeing != null) {
      if (checkeing.status) {
        maintain=2;
      }
      }

      }
if(maintain==0){
  if (settings.did.getValue() != 0 && settings.canlogin.getValue() != 0 && settings.demail.getValue() != '' && settings.demail.getValue() != null &&
      settings.dusername.getValue() != '' &&
      settings.dusername.getValue() != null) {
    checked = 1;
  }  else {
    checked = 0;
  }
}else{
        checked=2;
  
}

  

  // Pass all uncaught errors from the framework to Crashlytics firebase
  // Crashlytics is to get any error that occurs in app when it runs
  // FlutterError.onError = Crashlytics.instance.recordFlutterError;

  // runZoned(() {
    runApp(App(toOpen: checked,)); 
  // }, onError: Crashlytics.instance.recordError);

}

