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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:loadng/services/apis/account.dart';
import 'package:nb_utils/nb_utils.dart';
import 'dart:io';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:loadng/services/appSettings.dart';



var functionfile = locator<CustomFunction>();
var accountapi = locator<AccountApi>(); 

class LogMeIn extends StatefulWidget {
  static String tag = '/login';

  @override
  LogInState createState() => LogInState();
}

class LogInState extends State<LogMeIn> {
    TextEditingController _email, _pass;
    String _fcmtoken;
    int resetrequest=0;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;


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
             text(AppTexts.logintext, textColor: AppColors.appColorPrimary, fontFamily: AppFontSize.montbold, fontSize: 22.0),
              Container(
                margin: EdgeInsets.all(24),
                decoration: boxDecoration(bgColor: AppColors.modernWhite, showShadow: true, radius: 4),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(height: 10),
                    EditText( 
                      mController: _email,
                      hint: AppTexts.phonehint, 
                      isPassword: false,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    EditText(mController: _pass,hint: AppTexts.passwordhint, isSecure: true),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
if(resetrequest==0){
                  Navigator.of(context).pushNamed('/forgot');
}else{
        Navigator.of(context).pushNamed('/resetpass');
}
                  
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
                        child: text(AppTexts.t5_forgot_pswd, textColor: AppColors.appColorPrimary, fontSize: AppFontSize.textSizeLargeMedium, fontFamily: AppFontSize.fontBold),
                        
                      ), 
                    ),
                    SizedBox(
                      height: 16,
                    ),
               
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              login(emaili: _email.text, passi: _pass.text, userfcm: _fcmtoken);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 16),
                              alignment: Alignment.center,
                              height: width / 8,
                              child: text(AppTexts.loginbutton, textColor: AppColors.appWhite, isCentered: true),
                              decoration: boxDecoration(bgColor: AppColors.appColorPrimary, radius: 8),
                            ),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => CustomDialog(),
                              );
                            },
                            child: SvgPicture.asset(AppImage.t5_img_fingerprint, width: width / 8.2, color: AppColors.appTextColorSecondary))
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
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        _fcmtoken = "$token";
      });
    });
    _email = TextEditingController();
    _pass = TextEditingController();
    userInfo();
    super.initState();
  }

  @override
  void dispose() {
    _email.clear();
    _pass.clear();
    super.dispose();
  }


    login({emaili, passi, userfcm}) async {
     functionfile.onHorizontalLoading1(context);
    var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

    try {
      if (theinternet && theinternet2) {
        if (emaili.isEmpty) {
          Navigator.of(context).pop(); 
          toast('Please enter an email',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        }  else if (passi.isEmpty) {
          Navigator.of(context).pop(); 
         toast('Password can not be empty',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        } else {
          var v = await accountapi.loginApi( 
            email: emaili,
            pass: passi,
            fcm: userfcm,
          ).timeout(Duration(seconds: 20), onTimeout: () {
            Navigator.of(context).pop(); 
         toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
         return null;
          });

        if(v!=null){
            if (v.status == true) {
                 if(v.activatepin==1){
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
    canlogin: 0,
              );
              Navigator.of(context).pop(); 
            toast("Login Successful, Input your pin to access your dashboard",gravity:ToastGravity.CENTER,bgColor: AppColors.appDark_parrot_green);
             Navigator.of(context).pushNamed('/verifypin');
              }else{
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
            Navigator.of(context).pop(); 
            toast("Login Successful. Welcome back to LoadNG.",gravity:ToastGravity.CENTER,bgColor: AppColors.appDark_parrot_green);
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

    Future<void> userInfo() async {
        final prefs = await StreamingSharedPreferences.instance;
    var storeddetails = MyAppSettings(prefs);
    
    if(mounted){
    setState(() {
      resetrequest= storeddetails.resetpass.getValue();
    });
    }
  }


}
