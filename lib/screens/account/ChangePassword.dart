import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loadng/locator.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/styles/AppText.dart';
import 'package:loadng/styles/AppImage.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/widgets/loginScreen.dart';
import 'package:loadng/services/apis/account.dart';
import 'package:nb_utils/nb_utils.dart';
import 'dart:io';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';



var functionfile = locator<CustomFunction>();
var accountapi = locator<AccountApi>();
class ChangePassword extends StatefulWidget {
  static String tag = '/changepass';

  @override
  ChangePassState createState() => ChangePassState();
}

class ChangePassState extends State<ChangePassword> {
    TextEditingController _cpass, _pass,_opass;

  @override
  Widget build(BuildContext context) {
    functionfile.changeStatusColor(AppColors.appWhite);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
       child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TopBar(titleName: AppTexts.resettext,),
        Container(
          height: height/1.3,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(AppImage.appLogoblack, width: width / 2.5,),
            //  text(AppTexts.passwordhint, textColor: AppColors.primary, fontFamily: AppFontSize.fontBold, fontSize: 22.0),
              Container(
                margin: EdgeInsets.all(24),
                decoration: boxDecoration(bgColor: AppColors.modernWhite, showShadow: true, radius: 4),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(height: 10),
                    EditText(
                      mController: _pass,
                      hint: AppTexts.changepasswordhint, isSecure: true),
                          SizedBox(
                      height: 16,
                    ),
                    EditText(
                      mController: _cpass,
                      hint: AppTexts.changecpasswordhint, isSecure: true),
                    SizedBox(
                      height: 16,
                    ),
                      EditText(
                        mController: _opass,
                        hint: AppTexts.changeoldpasswordhint, isSecure: true),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                               chnagepassword(pass:_pass.text,cpass:_cpass.text,opass:_opass.text);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 16),
                              alignment: Alignment.center,
                              height: width / 8,
                              child: text(AppTexts.changetext, textColor: AppColors.appWhite, isCentered: true),
                              decoration: boxDecoration(bgColor: AppColors.appColorPrimary, radius: 8),
                            ),
                          ),
                        ),
                      ], 
                    )
                  ],
                ),
              )
            ],
          ),
        ),])
      ),
    );
  }




    @override
  void initState() {
     _cpass = TextEditingController();
    _pass = TextEditingController();
    _opass = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _cpass.clear();
    _pass.clear();
    _opass.clear();
    super.dispose();
  }


 chnagepassword({pass,cpass,opass}) async {
     functionfile.onHorizontalLoading1(context);
    var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

    try {
      if (theinternet && theinternet2) {
        if (pass.isEmpty) {
          Navigator.of(context).pop(); 
          toast(AppTexts.passerr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        }  else if (cpass.isEmpty) {
          Navigator.of(context).pop(); 
         toast(AppTexts.confirmpasserr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        }   else if (opass.isEmpty) {
          Navigator.of(context).pop(); 
         toast(AppTexts.oldpasserr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        } else if (cpass!=pass) {
          Navigator.of(context).pop(); 
         toast(AppTexts.confirmpassandpass,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        } else {
          var v = await accountapi.userchangepass(pass:pass,oldpass: opass
          ).timeout(Duration(seconds: 20), onTimeout: () {
            Navigator.of(context).pop(); 
         toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
         return null;
          });

        if(v!=null){
            if (v.status == true) {
              Navigator.of(context).pop(); 
            toast(AppTexts.passwordchanged,gravity:ToastGravity.CENTER,bgColor: AppColors.appDark_parrot_green);
               final prefs = await StreamingSharedPreferences.instance;
            prefs.setString('email','');
            prefs.setInt('userid',0);
            Navigator.of(context).pushNamed('/');
            }  else {
              Navigator.of(context).pop(); 
               toast(v.msg,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
            }
          }else{
            Navigator.of(context).pop(); 
             toast(AppTexts.errorinporcess,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
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
