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
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:nb_utils/nb_utils.dart';
import 'dart:io';
import 'package:loadng/services/apis/account.dart';


var functionfile = locator<CustomFunction>();
var accountapi = locator<AccountApi>();
// ignore: must_be_immutable 
// ignore: must_be_immutable
class RegisterPassword extends StatefulWidget {
 final RouteArgument routeArgument;
 String sentphone='';
 String sentemail='';
 String sentusername='';
 String accname='';
 String accno='';
 String sendtbnkid='';
 String accbnk='';
  static String tag = '/registerpassword'; 

  RegisterPassword({Key key,@required this.routeArgument }) {
    sentphone= this.routeArgument.argumentsList[0] as String;
    sentemail=this.routeArgument.argumentsList[1] as String;
    sentusername=this.routeArgument.argumentsList[2] as String;
    accname=this.routeArgument.argumentsList[3] as String;
    accno=this.routeArgument.argumentsList[4] as String;
    sendtbnkid=this.routeArgument.argumentsList[5] as String;
    accbnk=this.routeArgument.argumentsList[6] as String;
  }

  @override
  RegisterPasswordState createState() => RegisterPasswordState();
}
 
class RegisterPasswordState extends State<RegisterPassword> {
        TextEditingController _pass,_referby;
    String _fcmtoken;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
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
             AppTextStyle.text(AppTexts.welcometxt4 , textColor: AppColors.realblack, fontFamily: AppFontSize.montbold, fontSize: 22.0),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, bottom: 12),
                child: AppTextStyle.text(AppTexts.welcomepasslongtxt,
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
                              controller: _pass,
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              maxLength: 100,
                              style: TextStyle(
                                  fontSize: AppFontSize.textSizeLargeMedium,
                                  fontFamily: AppFontSize.fontRegular),
                              decoration: InputDecoration(
                                counterText: "",
                                contentPadding:
                                    EdgeInsets.fromLTRB(16, 10, 16, 10),
                                hintText: AppTexts.passwordhint,
                                hintStyle: TextStyle(color: AppColors.shadowdarkblack2,fontFamily: AppFontSize.montlight,fontWeight: FontWeight.w600,fontSize: AppFontSize.textSizeMedium),
                                border: InputBorder.none,
                              ),
                            ),
                          )
                          
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 24,
                    // ),
                    //   Container(
                    //   padding: EdgeInsets.only(left: 16),
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(4),
                    //       border: Border.all(color: AppColors.appTextColorPrimary, width: 0.5)),
                    //   child: Row(
                    //     children: <Widget>[
                    //       Expanded(
                    //         child: TextFormField(
                    //           controller: _referby,
                    //           obscureText: true,
                    //           keyboardType: TextInputType.text,
                    //           maxLength: 100,
                    //           style: TextStyle(
                    //               fontSize: AppFontSize.textSizeLargeMedium,
                    //               fontFamily: AppFontSize.fontRegular),
                    //           decoration: InputDecoration(
                    //             counterText: "",
                    //             contentPadding:
                    //                 EdgeInsets.fromLTRB(16, 10, 16, 10),
                    //             hintText: AppTexts.referhint ,
                    //             hintStyle: TextStyle(color: AppColors.shadowdarkblack2,fontFamily: AppFontSize.montlight,fontWeight: FontWeight.w600,fontSize: AppFontSize.textSizeMedium),
                    //             border: InputBorder.none,
                    //           ),
                    //         ),
                    //       )
                          
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      onTap: () {
         registerme(pass: _pass.text,referby:"LoadNG App",fcm:_fcmtoken,accbank:widget.accbnk,accname:widget.accname,accno:widget.accno,bankcode:widget.sendtbnkid);
                 },
                      child: Container(
                        alignment: Alignment.center,   
                        height: width / 8,
                        child: AppTextStyle.text(AppTexts.realregistertext,
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
       _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        _fcmtoken = "$token";
      });
    });
    _pass= TextEditingController();
    _referby= TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _referby.clear();
    _pass.clear();
    super.dispose();
  }

registerme({referby,pass,fcm,accbank,accname,accno,bankcode}) async {
  functionfile.onHorizontalLoading1(context);
    var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

    try {
      if (theinternet && theinternet2) {
        if (pass.isEmpty) {
          Navigator.of(context).pop();
          toast('Please enter a password',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        } else {
          var v = await accountapi.registerApi(uname: widget.sentusername,email: widget.sentemail,phoneno: widget.sentphone,referby: referby,pass: pass,fcm:fcm,accbank:accbank,accname:accname,accno:accno,bankcode:bankcode 
          ).timeout(Duration(seconds: 20), onTimeout: () {
           Navigator.of(context).pop();
         toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
         return null;
          });

        if(v!=null){
            if (v.status == true) {
                functionfile.storeDetails(
    uname:v.username,
    id:v.id,
    email:v.email,
    phoneno:v.phoneno,
    mainbal:v.walletbal,
    billbal:v.billbal,
    refillbal:v.refillbal,
    coins:v.coins,
    referby:v.referby,
    usertype:v.usertype,
    userlevel:v.userlevel,
    providusaccno:v.providusaccno,
    mainaccno:v.mainaccno,
    mainaccname:v.mainaccname,
    mainbnkname:v.mainaccbankname,
    activatepin:v.activatepin,
    datejoined:v.datejoined,
    fullnname:v.fullname,
    starcount:v.userstarcount,
    canlogin: 1,
              );
                 if(v.activatepin==1){
                   Navigator.of(context).pop();
                 toast("Registration  Successful, Input your pin to access your dashboard",gravity:ToastGravity.CENTER,bgColor: AppColors.appLight_parrot_green);
             Navigator.of(context).pushNamed('/verifypin');
              }else{
                Navigator.of(context).pop();
                 toast("Registration Successful, Welcome to LoadNG",gravity:ToastGravity.CENTER,bgColor: AppColors.appDark_parrot_green);
            Navigator.of(context).pushNamed('/userdashboard');
              }
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
