import 'package:flutter/material.dart';
import 'package:loadng/route_generator.dart';
import 'package:loadng/services/apis/system.dart';
import 'package:loadng/styles/AppText.dart';
import 'package:loadng/styles/AppTheme.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/utils/store/AppStore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'locator.dart';

var functionfile = locator<CustomFunction>();
var systemapi = locator<SystemApi>();
AppStore appStore = AppStore();

class App extends StatefulWidget {
 final int toOpen;
  App({Key key, this.toOpen}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState(toOpen: toOpen);
}

class _MyAppState extends State<App> {
  _MyAppState({this.toOpen});
  final int toOpen;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
var inmaintanance=0;
  @override
  void initState() {
//getting permission to show notification in iOS
_firebaseMessaging.requestPermission(sound: true, alert: true, badge: true);
    // _firebaseMessaging.requestNotificationPermissions(
    //     const IosNotificationSettings());
//Storing the permission so as not to ask next time 
    // _firebaseMessaging.onIosSettingsRegistered
    //     .listen((IosNotificationSettings setting) {});
    userInfo();
geterPermision();
    super.initState();
  } 

geterPermision() async {
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
  alert: true,
  announcement: false,
  badge: true,
  carPlay: false,
  criticalAlert: false,
  provisional: false,
  sound: true,
);
}
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppTexts.appName,
      debugShowCheckedModeBanner: false,
      // navigatorKey: locator<NavigationService>().navigationKey,
      // initialRoute:inmaintanance==1?'/maintanance': (toOpen == 0 ? '/' : "/userdashboard" ), 
      initialRoute:(toOpen == 0 ? '/' :toOpen == 2?'/maintanance': "/userdashboard" ), 
      theme: !appStore.isDarkModeOn ? AppThemeData.lightTheme : AppThemeData.darkTheme,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }


    Future<void> userInfo() async {
      var theinternet = await functionfile.isInternet();
      var theinternet2 = await functionfile.checkInternetAccess();
      if (theinternet && theinternet2) {
      var checker=0;
      var checkeing = await systemapi.checkmaintanance();
      if (checkeing != null) {
      if (checkeing.status) {
        setState(() {
          inmaintanance=1;
        });
      }
      }

      }
    }
}
