import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/locator.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/styles/AppText.dart';
import 'package:loadng/utils/dots_indicator/dots_indicator.dart';
import 'package:loadng/styles/AppImage.dart';
import 'package:loadng/widgets/onBoardScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'dart:io';


var functionfile = locator<CustomFunction>();

class AppOnBoardScreen extends StatefulWidget {
  static String tag = '/';

  @override
  AppOnBoardScreenState createState() => AppOnBoardScreenState();
}

class AppOnBoardScreenState extends State<AppOnBoardScreen> {
  int currentIndexPage = 0;
  int pageLength;
  bool sendme = false;

  @override
  void initState() {
    super.initState();
    currentIndexPage = 0;
    checkmyinternet();
    pageLength = 3;
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
                WalkThrough(
                  textContent: AppTexts.boardsub1,
                  title: AppTexts.boardHeader1,
                  image: AppImage.board1,
                ),
                WalkThrough(
                  textContent: AppTexts.boardsub2,
                  title: AppTexts.boardHeader2,
                  image: AppImage.board2,
                ),
                WalkThrough(
                  textContent: AppTexts.boardsub3,
                  title: AppTexts.boardHeader3,
                  image: AppImage.board3,
                ),
              ],
              onPageChanged: (value) {
                setState(() => currentIndexPage = value);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Align(
                  child: DotsIndicator(
                      dotsCount: 3,
                      position: currentIndexPage,
                      decorator: DotsDecorator(
                        color: AppColors.appColorPrimary,
                        activeColor: AppColors.t6colorPrimary,
                      )),
                ),
                SizedBox(
                  height: 14,
                ),
                Row(children: <Widget>[
                  Expanded(
                      child: OnBoardButton(
                    textContent: AppTexts.getStarted,
                    onPressed: () {
                      checkmyinternet();
                      if (sendme) {
                        Navigator.of(context).pushNamed('/login');
                      } else {
                        toast(
                            'No active Internet connection or weak internet network',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
                      }
                    },
                  )),
                ])
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
