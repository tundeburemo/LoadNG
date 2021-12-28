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
import 'package:nb_utils/nb_utils.dart';
import 'dart:io';
import 'package:loadng/services/apis/account.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';



var functionfile = locator<CustomFunction>();
var accountapi = locator<AccountApi>();
class ForgotPassword extends StatefulWidget {
  static String tag = '/forget';

  @override
  ForgotPassState createState() => ForgotPassState();
}

class ForgotPassState extends State<ForgotPassword> {
      TextEditingController _snum, _email;
  @override
  Widget build(BuildContext context) {
    functionfile.changeStatusColor(AppColors.appWhite);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(AppImage.appLogoblack, width: width / 2.5, height: width / 2.5),
                  text(AppTexts.forgotbutton, textColor: AppColors.appColorPrimary, fontFamily: AppFontSize.montbold, fontSize: 22.0),
              Container(
                margin: EdgeInsets.all(24),
                decoration: boxDecoration(bgColor: AppColors.modernWhite, showShadow: true, radius: 4),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(height: 10),
                    EditText(mController: _email, hint: AppTexts.emailhint, isPassword: false,),
                    SizedBox(
                      height: 16,
                    ),
                    // EditText(mController: _snum,   hint: AppTexts.securitynohint, isSecure: true),
                    //      SizedBox(
                    //   height: 10,
                    // ),
                    // SizedBox(
                    //   height: 16,
                    // ),
                   
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                      functionfile.onHorizontalLoading1(context);
  requestttoken(email:_email.text,snum:_snum.text);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 16),
                              alignment: Alignment.center,
                              height: width / 8,
                              child: text(AppTexts.signupcontinue, textColor: AppColors.appWhite, isCentered: true),
                              decoration: boxDecoration(bgColor: AppColors.appColorPrimary, radius: 8),
                            ),
                          ),
                        ),
                      ], 
                    )
                  ],
                ),
              ),
                                           Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                      text("New Here? ", textColor: AppColors.black, fontSize: AppFontSize.textSizeLargeMedium, fontFamily: AppFontSize.montlight,isCentered: true),
                         GestureDetector(
                      onTap:(){
                          Navigator.of(context).pushNamed('/register');
                      },
                      child:
                       text(" Register Now!", textColor: AppColors.appColorPrimary, fontSize: AppFontSize.textSizeLargeMedium, fontFamily: AppFontSize.fontBold,isCentered: true)),
                  ])
            ],
          ),
        ),
      ),
    );
  }

    @override
  void initState() {
    _email = TextEditingController();
    _snum = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.clear();
    _snum.clear();
    super.dispose();
  }

  
  requestttoken({email,snum}) async {
    snum=" ";
    var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

    try {
      if (theinternet && theinternet2) {
        if (email.isEmpty) {
          Navigator.of(context).pop();
          toast('Please enter your email',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        }
        // else if (snum.isEmpty) {
        //   Navigator.of(context).pop();
        //   toast('Please enter a security number',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        // }
         else {
          var v = await accountapi.resetpasswordtoken(snum:snum,email:email
          ).timeout(Duration(seconds: 40), onTimeout: () {
            Navigator.of(context).pop();
         toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
         return null;
          });
 
        if(v!=null){
            if (v.status == true) {
             Navigator.of(context).pop();  
   toast("Kindly check your mail on the process to complete your password reset",gravity:ToastGravity.CENTER,bgColor: AppColors.appDark_parrot_green);
     final prefs = await StreamingSharedPreferences.instance;
            prefs.setInt('resetpass',1);
        Navigator.of(context).pushNamed('/resetpass');

              
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
