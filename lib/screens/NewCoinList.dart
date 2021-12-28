import 'package:flutter/material.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/locator.dart';
import 'package:loadng/styles/AppFontSizes.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/styles/AppImage.dart';
import 'package:loadng/widgets/loginScreen.dart';

var functionfile = locator<CustomFunction>();
class CoinsList extends StatefulWidget {
  static var tag = "/coinslist";

  @override
  CoinsListState createState() => CoinsListState();
}

class CoinsListState extends State<CoinsList> {
  int selectedPos = 1;
  @override
  void initState() {
    super.initState();
    selectedPos = 1;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
      functionfile.changeStatusColor(Colors.transparent);
 return   Scaffold(
      backgroundColor:  AppColors.t5LayoutBackgroundWhite,
      body: Container(
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TopBar(),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 10),
              child: text("Sell Coins", textColor: AppColors.appColorPrimary, fontFamily: AppFontSize.fontBold, fontSize: AppFontSize.textSizeLarge),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    itemCount:5,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        decoration: boxDecoration(radius: 16, showShadow: true),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image.asset(
                              AppImage.appLogoblack,
                              width: width / 13,
                              height: width / 13,
                            ),
                            SizedBox(height: 10),
                            text("Paxful", textColor:  AppColors.appColorPrimary, fontSize: AppFontSize.textSizeLargeMedium, fontFamily: AppFontSize.fontSemibold),
                            text("480₦/\$", fontSize: AppFontSize.textSizeMedium),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              decoration: boxDecoration(bgColor: AppColors.appDarkRed, radius: 16),
                              child: text("Sell", fontSize: AppFontSize.textSizeMedium, textColor: AppColors.appWhite),
                            ),
                            
                          ],
                        ),
                      );


                    }),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
