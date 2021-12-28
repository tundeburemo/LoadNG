import 'package:flutter/material.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/locator.dart';
import 'package:loadng/styles/AppFontSizes.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/styles/AppImage.dart';
import 'package:loadng/widgets/loginScreen.dart';
import "package:loadng/model/system/route_argument.dart";

var functionfile = locator<CustomFunction>();

class NewCoinList extends StatefulWidget {
  static var tag = "/newcoinlist";

  @override
  NewCoinListState createState() => NewCoinListState();
}

class NewCoinListState extends State<NewCoinList> {
  int selectedPos = 1;
  @override
  void initState() {
    super.initState();
    selectedPos = 1;
  }

  @override
  Widget build(BuildContext context) {
    functionfile.changeStatusColor(Colors.transparent);
    return Scaffold(
      backgroundColor: AppColors.t5LayoutBackgroundWhite,
      body: Container(
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TopBar(),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 10),
              child: text("Sell Coins",
                  textColor: AppColors.shadowdarkblack,
                  fontFamily: AppFontSize.montbold,
                  fontSize: AppFontSize.textSizeLarge),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    itemCount: 9,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16),
                    itemBuilder: (BuildContext context, int index) {
                      var thehexcode, thename, therate, theimage, thenavlink;
                      if (index == 0) {
                        thehexcode = 0xfffae6fb;
                        thename = "Paxful Bitcoin";
                        therate = "460";
                        theimage = AppImage.paxful;
                        thenavlink = "/sellpaxful";
                      } else if (index == 1) {
                        thehexcode = 0xfffff0dd;
                        thename = "Blockchain BTC";
                        therate = "460";
                        theimage = AppImage.uni;
                        thenavlink = "/";
                      } else if (index == 2) {
                        thehexcode = 0xfffff9d9;
                        thename = "Cashapp & Other BTC";
                        therate = "460";
                        theimage = AppImage.cashapp;
                        thenavlink = "/";
                      } else if (index == 3) {
                        thehexcode = 0xffd9e1ff;
                        thename = "Ethereum";
                        therate = "460";
                        theimage = AppImage.eth;
                        thenavlink = "/";
                      } else if (index == 4) {
                        thehexcode = 0xfffce5c0;
                        thename = "Litecoin";
                        therate = "460";
                        theimage = AppImage.ltc;
                      } else if (index == 5) {
                        thehexcode = 0xffeeffdc;
                        thename = "Bitcoin Cash";
                        therate = "460";
                        theimage = AppImage.bch;
                        thenavlink = "/";
                      } else if (index == 6) {
                        thehexcode = 0xffe6f2ff;
                        thename = "USDC";
                        therate = "460";
                        theimage = AppImage.usd;
                        thenavlink = "/";
                      } else if (index == 7) {
                        thehexcode = 0xffffc1c1;
                        thename = "Perfect Money";
                        therate = "460";
                        theimage = AppImage.pm;
                        thenavlink = "/";
                      } else if (index == 8) {
                        thehexcode = 0xfffae6fb;
                        thename = "Others Coins";
                        therate = "460";
                        theimage = AppImage.others;
                        thenavlink = "/";
                      }
                      return GestureDetector(
                          onTap: () {
                            if (index == 0) {
                              Navigator.of(context).pushNamed('$thenavlink',
                                  arguments: new RouteArgument(argumentsList: [
                                    "$thename",
                                    "$theimage",
                                    "$therate",
                                    thehexcode
                                  ]));
                            } else if (index == 1) {
                              Navigator.of(context).pushNamed('$thenavlink',
                                  arguments: new RouteArgument(argumentsList: [
                                    "$thename",
                                    "$theimage",
                                    "$therate",
                                    thehexcode
                                  ]));
                            } else if (index == 2) {
                              Navigator.of(context).pushNamed('$thenavlink',
                                  arguments: new RouteArgument(argumentsList: [
                                    "$thename",
                                    "$theimage",
                                    "$therate",
                                    thehexcode
                                  ]));
                            } else if (index == 3) {
                              Navigator.of(context).pushNamed('$thenavlink',
                                  arguments: new RouteArgument(argumentsList: [
                                    "$thename",
                                    "$theimage",
                                    "$therate",
                                    thehexcode
                                  ]));
                            } else if (index == 4) {
                              Navigator.of(context).pushNamed('$thenavlink',
                                  arguments: new RouteArgument(argumentsList: [
                                    "$thename",
                                    "$theimage",
                                    "$therate",
                                    thehexcode
                                  ]));
                            } else if (index == 5) {
                              Navigator.of(context).pushNamed('$thenavlink',
                                  arguments: new RouteArgument(argumentsList: [
                                    "$thename",
                                    "$theimage",
                                    "$therate",
                                    thehexcode
                                  ]));
                            } else if (index == 6) {
                              Navigator.of(context).pushNamed('$thenavlink',
                                  arguments: new RouteArgument(argumentsList: [
                                    "$thename",
                                    "$theimage",
                                    "$therate",
                                    thehexcode
                                  ]));
                            } else if (index == 7) {
                              Navigator.of(context).pushNamed('$thenavlink',
                                  arguments: new RouteArgument(argumentsList: [
                                    "$thename",
                                    "$theimage",
                                    "$therate",
                                    thehexcode
                                  ]));
                            } else if (index == 8) {
                              Navigator.of(context).pushNamed('$thenavlink',
                                  arguments: new RouteArgument(argumentsList: [
                                    "$thename",
                                    "$theimage",
                                    "$therate",
                                    thehexcode
                                  ]));
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 16, right: 16),
                            decoration: boxDecoration(
                                radius: 16,
                                showShadow: true,
                                color: Color(thehexcode),
                                bgColor: Color(thehexcode)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Image.asset(
                                  theimage,
                                  width: 50,
                                  height: 50,
                                ),
                                SizedBox(height: 5),
                                text("$thename",
                                    textColor: AppColors.shadowdarkblack,
                                    fontSize: AppFontSize.textSizeSMedium,
                                    fontFamily: AppFontSize.montbold,
                                    maxLine: 3),
                                text("$therate₦/\$",
                                    fontSize: AppFontSize.textSizeMedium,
                                    fontFamily: AppFontSize.cooperaterunded),
                              ],
                            ),
                          ));
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
