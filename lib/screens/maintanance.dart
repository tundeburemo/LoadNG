import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loadng/model/system/route_argument.dart';
import 'package:loadng/styles/AppFontSizes.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/locator.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/styles/AppText.dart';
import 'package:loadng/utils/dots_indicator/dots_indicator.dart';
import 'package:loadng/styles/AppImage.dart';
import 'package:loadng/widgets/onBoardScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'dart:io';
import 'package:loadng/services/apis/system.dart';
import 'package:loadng/utils/store/AppStore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

var functionfile = locator<CustomFunction>();
var systemapi = locator<SystemApi>();
AppStore appStore = AppStore();

class MainTananceScreen extends StatefulWidget {
  static String tag = '/maintanance';

  @override
  MainTananceScreenState createState() => MainTananceScreenState();
}

class MainTananceScreenState extends State<MainTananceScreen> {
  int currentIndexPage = 0;
  int pageLength;
  bool sendme = false;
  var endtime="";
  var notice="";
  int showsupport=0;

  @override
  void initState() {
    super.initState();
    userInfo();
    currentIndexPage = 0;
    checkmyinternet();
    pageLength = 3;
  }


    Future<void> userInfo() async {
      var theinternet = await functionfile.isInternet();
      var theinternet2 = await functionfile.checkInternetAccess();
      if (theinternet && theinternet2) {
      var checker=0;
      var checkeing = await systemapi.checkmaintanance();
      if (checkeing != null) {
      if (checkeing.status) {
        var dmess=checkeing.msg.split("||");
        // "$noticetext||$enddate||$showsupport";
        setState(() {
          endtime=dmess[1];
          notice=dmess[0];
          showsupport=int.parse(dmess[2]);
        });
      }
      }

      }
    }

  @override
  Widget build(BuildContext context) {
    functionfile.changeStatusColor(Colors.transparent);
    return WillPopScope(
         onWillPop: (){
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit the App'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => exit(0),
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
      },
        child:Scaffold(
        body: SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
              alignment: Alignment.topCenter,
              child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 18.0,
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      AppImage.appLogoblack,
                      width: 150,
                      height: 90,
                      //fit: BoxFit.cover,
                    ),
                  ))),
          Container(),
           Container(
            margin: EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: PageView(
              children: <Widget>[
                // Image.asset("assets/image/maintain.jpg")
              ]
            )),
          Container(
            margin: EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
      Text("$notice",
      textAlign:TextAlign.center,
              style: TextStyle(
                  fontSize: AppFontSize.textSizeLargeMedium, color: AppColors.appColorPrimary,fontFamily:  AppFontSize.montlight,fontWeight:FontWeight.bold)),
      Text("Maintenance is expected to finish by $endtime",
      textAlign:TextAlign.center,

              style: TextStyle(
                  fontSize: AppFontSize.textSizeSMedium, color: AppColors.primaryDark,fontFamily: AppFontSize.montlight)),
            
                SizedBox(
                  height: 14,
                ),
               showsupport==1? Row(children: <Widget>[
                  Expanded(
                      child: OnBoardButton(
                    textContent: "Chat Support",
                    onPressed: () {
                      checkmyinternet();
                      if (sendme) {
                          Uri theurl=Uri.parse("https://tawk.to/chat/5d49d339e5ae967ef80ec6b5/default");
                             Navigator.of(context).pushNamed('/inappwebview2',arguments: new RouteArgument(argumentsList: ["LoadNG Support",  theurl,"/userdashboard"])); 
                      } else {
                        toast(
                            'No active Internet connection or weak internet network',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
                      }
                    },
                  )),
                ]):Container()
              ],
            ),
          )
        ],
      ),
    )));
  }

  checkmyinternet() {
    functionfile.isInternet().then((value) =>
        functionfile.checkInternetAccess().then((value2) => value && value2
            ? setState(() {
                sendme = true;
              })
            : setState(() {
                sendme = false;
              })));
  }
}
