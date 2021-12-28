import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loadng/locator.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/styles/AppText.dart';
import 'package:loadng/styles/AppImage.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/widgets/loginScreen.dart';
import 'package:loadng/styles/AppFontSizes.dart';
import 'package:nb_utils/nb_utils.dart';
import 'dart:io';
import 'package:loadng/services/apis/account.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';



var functionfile = locator<CustomFunction>();
var accountapi = locator<AccountApi>();
class VerifyPin extends StatefulWidget {
  static String tag = '/verifypin';

  @override
  VerifyPinState createState() => VerifyPinState();
}

class VerifyPinState extends State<VerifyPin> {
  @override
  Widget build(BuildContext context) {
    functionfile.changeStatusColor(AppColors.appWhite);
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
       child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TopBar(),
        Container(
          // height: height/1.6,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(AppImage.appLogoblack, width: width / 2.5, height: width / 2.5),
              text(AppTexts.verifytop, textColor: AppColors.appColorPrimary, fontFamily: AppFontSize.montbold, fontSize: 22.0),
              Container(
                margin: EdgeInsets.all(24),
                decoration: boxDecoration(bgColor: AppColors.modernWhite, showShadow: true, radius: 4),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(height: 10),
                  PinEntryTextField(
                    onSubmit: (chr){
                      functionfile.onHorizontalLoading1(context);
                        verifypin(pin:chr) ;
                    }, 
                          fields: 4,
                          fontSize: AppFontSize.textSizeXLarge,
                        ),
                          SizedBox(
                      height: 16,
                    ),
                   
                  ],
                ),
              )
            ],
          ),
        ),])
      ),
    );
  }

  verifypin({pin}) async {
    var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

    try {
      if (theinternet && theinternet2) {
        if (pin.isEmpty) {
          Navigator.of(context).pop();
          toast('Please enter a pin',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        } else {
          var v = await accountapi.userverifypin(pin: pin
          ).timeout(Duration(seconds: 20), onTimeout: () {
            Navigator.of(context).pop();
         toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
         return null;
          });

        if(v!=null){
            if (v.status == true) {
             Navigator.of(context).pop();  
            final prefs = await StreamingSharedPreferences.instance;
            prefs.setInt('canlogin',1);
                 toast("Login Successful, Welcome Back to LoadNG",gravity:ToastGravity.CENTER,bgColor: AppColors.appDark_parrot_green);
            Navigator.of(context).pushNamed('/userdashboard');
              
            }  else {
             Navigator.of(context).pop();  

               toast(v.msg,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
            }
          }else{
             Navigator.of(context).pop();  

             toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
          }
        }
      } else {
             Navigator.of(context).pop();  

         toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
      }
    } on SocketException catch (_) {
             Navigator.of(context).pop();  

       toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
    }
  }
}
