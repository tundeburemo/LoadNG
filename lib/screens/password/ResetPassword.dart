import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loadng/locator.dart';
import 'package:loadng/styles/AppFontSizes.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/styles/AppText.dart';
import 'package:loadng/styles/AppImage.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/widgets/loginScreen.dart';
import 'package:loadng/styles/AppTextStyle.dart';
import 'package:nb_utils/nb_utils.dart';
import 'dart:io';
import 'package:loadng/services/apis/account.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';


var functionfile = locator<CustomFunction>();
var accountapi = locator<AccountApi>();
class ResetPassword extends StatefulWidget {
  static String tag = '/resetpass';

  @override
  ResetPassState createState() => ResetPassState();
}

class ResetPassState extends State<ResetPassword> {
       TextEditingController _snum, _token,_pass,_cpass;
    bool processing = false;
  @override
  Widget build(BuildContext context) {
    functionfile.changeStatusColor(AppColors.appWhite);
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // height: height,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(AppImage.appLogoblack, width: width / 2.5, height: width / 3.0),
           text(AppTexts.resettoptext, textColor: AppColors.appColorPrimary, fontFamily: AppFontSize.montbold, fontSize: 22.0),
            Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, bottom: 12),
                child: AppTextStyle.text(AppTexts.resettoplink,
                    textColor: AppColors.appSecondaryBackgroundColor,
                    fontFamily: AppFontSize.fontMedium,
                    fontSize: AppFontSize.textSizeMedium,
                    maxLine: 2,
                    isCentered: true),
              ),
              Container(
                margin: EdgeInsets.all(24),
                decoration: boxDecoration(bgColor: AppColors.modernWhite, showShadow: true, radius: 4),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(height: 10),
                    EditText(
                      mController: _token,
                      hint: AppTexts.tokenhint,
                      isPassword: false,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    // EditText(
                    //   mController: _snum,
                    //   hint: AppTexts.securitynohint, isSecure: true),
                    //       SizedBox(
                    //   height: 16,
                    // ),
                    EditText(
                      mController: _pass,
                      hint: AppTexts.resetpasswordhint, isSecure: true),
                          SizedBox(
                      height: 16,
                    ),
                    EditText(
                      mController: _cpass,
                      hint: AppTexts.resetcpasswordhint, isSecure: true),
                    SizedBox(
                      height: 16,
                    ),
                  
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
resetpassword(snum:_snum.text, token:_token.text, pass:_pass.text, cpass:_cpass.text);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 16),
                              alignment: Alignment.center,
                              height: width / 8,
                              child: text(AppTexts.resettext, textColor: AppColors.appWhite, isCentered: true),
                              decoration: boxDecoration(bgColor: AppColors.appColorPrimary, radius: 8),
                            ),
                          ),
                        ),
                      ],
                    )
                     ],
                ),
              ),
                  //               Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // children: <Widget>[
                      text("Didn't get the token? Check your spam mail or", textColor: AppColors.black, fontSize: AppFontSize.textSizeSmall, fontFamily: AppFontSize.montlight,isCentered: true),
                         GestureDetector(
                      onTap:(){
                          Navigator.of(context).pushNamed('/forgot');
                      },
                      child:
                       text(" request again!", textColor: AppColors.appColorPrimary, fontSize: AppFontSize.textSizeNormal, fontFamily: AppFontSize.fontBold,isCentered: true)),
                       SizedBox(height:10)
                  // ])
            ],
          ),
        ),
      ),
    );
  }


    @override
  void initState() {
    _snum = TextEditingController();
    _pass= TextEditingController();
    _cpass = TextEditingController();
    _token= TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _snum.clear();
    _pass.clear();
    _cpass.clear();
    _token.clear();

    super.dispose();
  }

   resetpassword({snum, token, pass, cpass}) async {
     snum=" ";
     functionfile.onHorizontalLoading1(context);
    var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

    try {
      if (theinternet && theinternet2) {
        if (token.isEmpty) {
          Navigator.of(context).pop(); 
          toast('Email is required',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        }
        // else if (snum.isEmpty) {
        //   Navigator.of(context).pop(); 
        //   toast('Security number is rquired',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        // }
        else if (pass.isEmpty) {
          Navigator.of(context).pop(); 
          toast('Password is required',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        } else if (cpass.isEmpty) {
          Navigator.of(context).pop(); 
          toast('Confirm Password is required',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        }else if (cpass!=pass) {
          Navigator.of(context).pop(); 
          toast('Password and Confirm Password must be the same',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        }else {
          var v = await accountapi.resetpassword(snum:snum,token:token,pass:pass,cpass:cpass
          ).timeout(Duration(seconds: 20), onTimeout: () {
         toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
         return null;
          });

        if(v!=null){
            if (v.status == true) {
             Navigator.of(context).pop();  
   toast("Password Reset Successfully,kindly login",gravity:ToastGravity.CENTER,bgColor: AppColors.appDark_parrot_green);
      final prefs = await StreamingSharedPreferences.instance;
            prefs.setInt('resetpass',0);
           Navigator.of(context).pushNamed('/login');
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
