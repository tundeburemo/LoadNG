import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loadng/styles/AppFontSizes.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/styles/AppText.dart';
import 'package:loadng/styles/AppImage.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/widgets/loginScreen.dart';
import 'package:loadng/locator.dart';
import 'package:loadng/utils/flutter_rating_bar.dart';
import "package:loadng/model/system/route_argument.dart";
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:loadng/services/appSettings.dart';
import 'package:nb_utils/nb_utils.dart';



var functionfile = locator<CustomFunction>();

class UserAccount extends StatefulWidget {
  static var tag = "/useraccount";

  @override
  UserAccountState createState() => UserAccountState();
}

class UserAccountState extends State<UserAccount> {
  double width;
  var username = "";
  var email = "";
  var userlevel = "";
  var kyclink = "";
  var startcount = 0;
  bool sendme = false;
  @override
  void initState() {
    userInfo();
    super.initState();
  }

  var currentIndex = 0;
  var iconList = <String>[
    AppImage.statistics,
    AppImage.t5_user,
    AppImage.passwordlock,
    AppImage.t5_img_settings,
    AppImage.t5_img_settings,
    AppImage.t5_img_fingerprint,
    AppImage.passwordlock2,
    AppImage.statistics,
    AppImage.t5_user,
    AppImage.t5_customer_service,
  ];
  var nameList = <String>[
    AppTexts.account_statistics,
    AppTexts.account_myprofile,
    AppTexts.account_password,
    AppTexts.account_bank,
    AppTexts.account_banktrans,
    AppTexts.account_finger,
    AppTexts.account_pin,
    AppTexts.account_myreferals,
    AppTexts.account_kyc,
    AppTexts.account_customersupport,
  ];

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget gridItem(int pos, String nav) {
    return GestureDetector(
        onTap: () {
if(nav!=" "){
          if (nav != "/inappwebview2") {
            if(nav=="/userreferals"){
                Navigator.of(context).pushNamed('/userreferals',arguments: new RouteArgument(argumentsList: [2]));
            }
            else{
            Navigator.of(context).pushNamed('$nav');
            }

            
          } else {
            if (sendme) {
               Uri theurl=Uri.parse("https://tawk.to/chat/5d49d339e5ae967ef80ec6b5/default");
              Navigator.of(context).pushNamed('/inappwebview2',
                  arguments: new RouteArgument(argumentsList: [
                    "LoadNG Support",
                    theurl,
                    "/userdashboard"
                  ]));
            } else {
              functionfile.showerror(context); 
            } 
          }
}else{
        toast(AppTexts.featurenotavailable);
}
        },
        child: Container(
            width: (width - (16 * 3)) / 2,
            height: (width - (16 * 3)) / 2,
            decoration: boxDecoration(
                radius: 24, showShadow: true, bgColor: AppColors.appWhite),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  iconList[pos],
                  width: width / 7,
                  height: width / 7,
                ),
                text(nameList[pos],
                    fontSize: AppFontSize.textSizeSMedium,
                    textColor: AppColors.shadowdarkblack,
                    fontFamily: AppFontSize.fontSemibold)
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    functionfile.changeStatusColor(AppColors.appWhite);
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar(
        context,
        "My Account",
      ),
      backgroundColor: AppColors.appWhite,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              height: width,
              color: AppColors.appShadowColorDark,
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 16),
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    padding: EdgeInsets.only(top: 60),
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                        color: AppColors.appShadowColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24))),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        text("$username",
                            textColor: AppColors.appColorPrimary,
                            fontFamily: AppFontSize.montbold,
                            fontSize: AppFontSize.textSizeNormal),
                        text("$email",
                            fontSize: AppFontSize.textSizeLargeMedium,
                            textColor: AppColors.shadowdarkblack),
                        text("$userlevel",
                            fontSize: AppFontSize.textSizeLargeMedium,
                            textColor: AppColors.shadowdarkblack),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 24.0, left: 24.0, bottom: 24.0),
                          child: Column(
                            children: <Widget>[
                              RatingBar(
                                initialRating: startcount.toDouble(),
                                minRating: 1,
                                direction: Axis.horizontal,
                                // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {},
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            gridItem(0, "/userstatistics"),
                            gridItem(1, "/userprofile")
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            gridItem(2, "/changepass"),
                            gridItem(3, "/mybanks")
                          ],
                        ),
                         SizedBox(height: 16),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            gridItem(4, "/mytransbanks"),
                            gridItem(5, " ")
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            gridItem(6, "/changepin"),
                            gridItem(7, "/userreferals")
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            gridItem(8, "$kyclink"),
                            gridItem(9, "/inappwebview2")
                          ],
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    child: Image.asset(
                        AppImage.profile), //CahedNetworkImageProvider("https"),
                    radius: 50,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> userInfo() async {
    checkmyinternet();
    final prefs = await StreamingSharedPreferences.instance;
    var storeddetails = MyAppSettings(prefs);

    if (mounted) {
      setState(() {
        username = storeddetails.dusername.getValue();
        email = storeddetails.demail.getValue();
        userlevel = storeddetails.duserlevel.getValue();
        startcount = storeddetails.dstarcount.getValue();
      });
    }

    if (storeddetails.kycfilled.getValue()==0 && storeddetails.kycapproved.getValue()==0) {
     setState(() {
        kyclink = "/kycform"; 
      });
    }else if(storeddetails.kycfilled.getValue()==0 && storeddetails.kycapproved.getValue()==1){
    setState(() { 
        kyclink = "/kycdetails";
      });
    }else if(storeddetails.kycfilled.getValue()==2 && storeddetails.kycapproved.getValue()==1){
    setState(() { 
        kyclink = "/kycdetails";
      });
    }else  if (storeddetails.kycfilled.getValue()==1 && storeddetails.kycapproved.getValue()==0) {
     setState(() {
        kyclink = "/kycform"; 
      });
    } else {
      setState(() {
        kyclink = "/kycform"; 
      });
      
    }
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
