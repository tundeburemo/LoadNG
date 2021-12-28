import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/locator.dart';
import 'package:loadng/styles/AppFontSizes.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/styles/AppText.dart';
import 'package:loadng/styles/AppTextStyle.dart';
import 'package:loadng/styles/AppImage.dart';
import "package:loadng/model/system/route_argument.dart";
import 'package:loadng/widgets/loginScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'dart:io';
import 'package:loadng/services/apis/account.dart';


var functionfile = locator<CustomFunction>();
var accountapi = locator<AccountApi>();
// ignore: must_be_immutable
class RegisterUsername extends StatefulWidget {
 final RouteArgument routeArgument;
 String sentphone='';
 String sentemail='';
  static String tag = '/registerusername'; 

  RegisterUsername({Key key,@required this.routeArgument }) {
    sentphone= this.routeArgument.argumentsList[0] as String;
    sentemail=this.routeArgument.argumentsList[1] as String;
  }

  @override
  RegisterUsernameState createState() => RegisterUsernameState();
}
 

class RegisterUsernameState extends State<RegisterUsername> {
      TextEditingController _uname;

  @override
  Widget build(BuildContext context) {
    functionfile.changeStatusColor(AppColors.appWhite);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height/1.3,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             Image.asset(AppImage.appLogoblack, 
                  width: width / 2.5,
                  height: width / 3.0),
             AppTextStyle.text(AppTexts.welcometxt3, textColor: AppColors.realblack, fontFamily: AppFontSize.montbold, fontSize: 22.0),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, bottom: 12),
                child: AppTextStyle.text(AppTexts.welcomeusernamelongtxt,
                    textColor: AppColors.appSecondaryBackgroundColor,
                    fontFamily: AppFontSize.fontMedium,
                    fontSize: AppFontSize.textSizeMedium,
                    maxLine: 2,
                    isCentered: true),
              ),
              Container(
                margin: EdgeInsets.all(24),
                decoration: boxDecoration(
                    bgColor: AppColors.appWhite, showShadow: true, radius: 4),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: AppColors.appTextColorPrimary, width: 0.5)),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: _uname,
                              keyboardType: TextInputType.text,
                              maxLength: 100,
                              style: TextStyle(
                                  fontSize: AppFontSize.textSizeLargeMedium,
                                  fontFamily: AppFontSize.fontRegular),
                              decoration: InputDecoration(
                                counterText: "",
                                contentPadding:
                                    EdgeInsets.fromLTRB(16, 10, 16, 10),
                                hintText: AppTexts.usernamehint,
                                hintStyle: TextStyle(color: AppColors.shadowdarkblack2,fontFamily: AppFontSize.montlight,fontWeight: FontWeight.w600,fontSize: AppFontSize.textSizeMedium),
                                border: InputBorder.none,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                   
                    GestureDetector(
                      onTap: () {
         verifier(username:_uname.text);
             },
                      child: Container(
                        alignment: Alignment.center,    
                        height: width / 8,
                        child: AppTextStyle.text(AppTexts.signupcontinue,
                            textColor:AppColors.appWhite, isCentered: true),
                        decoration:
                           boxDecoration(bgColor:AppColors.appColorPrimary, radius: 8),
                      ),
                    ),
                  ],
                ),
              ),
              
                       Row( 
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                      text("Already Registered?", textColor: AppColors.black, fontSize: AppFontSize.textSizeLargeMedium, fontFamily: AppFontSize.montlight,isCentered: true),
                         GestureDetector(
                      onTap:(){
                          Navigator.of(context).pushNamed('/login');
                      },
                      child:
                       text(" Login Now!", textColor: AppColors.appColorPrimary, fontSize: AppFontSize.textSizeLargeMedium, fontFamily: AppFontSize.fontBold,isCentered: true)),
                  ])
                       
            ],
          ),
        ),
      ),
    );
  }


  
      @override
  void initState() {
    _uname= TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _uname.clear();
    super.dispose();
  }

verifier({username}) async {
  functionfile.onHorizontalLoading1(context);
    var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

    try {
      if (theinternet && theinternet2) {
        if (username.isEmpty) {
         Navigator.of(context).pop(); 
          toast('Please enter a username',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        } else {
          var v = await accountapi.registerchecker( phoneno: " ",email:" ",uname: username
          ).timeout(Duration(seconds: 20), onTimeout: () {
              Navigator.of(context).pop(); 
         toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
         return null;
          });

        if(v!=null){ 
            if (v.status == true) {

     Navigator.of(context).pop(); 
            Navigator.of(context).pushNamed('/RegisterBank',arguments: new RouteArgument(argumentsList: [widget.sentphone, widget.sentemail,username]));   


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
